#TODO:
#add behavior that generates the hashes rather than verifying them as a command line option

param(
    [parameter(Mandatory=$true)][string]$file,
    [parameter(Mandatory=$true)][string]$targetfolder,
    [parameter(Mandatory=$false)][int]$skip = 0
)

function Write-ToApplicationLog([string] $eventtext, [bool] $echo = $false)
{    
    Import-Module Microsoft.PowerShell.Management

    if (Get-Command "Write-EventLog" -errorAction SilentlyContinue) 
    { 
        $rawdata = [system.Text.Encoding]::UTF8.GetBytes($eventtext)     
        Write-EventLog -LogName "Application" -Source $MyInvocation.MyCommand.Name -EventID 9001 -EntryType Information -Message $eventtext -Category 1 -RawData $rawdata
        if ($echo) { $eventtext }
    } else { 
        $eventtext
    }
    
}



if ((test-path -path $file) -eq $false) { "file not found"; exit }
if ((test-path -path $targetfolder) -eq $false) { "target folder invalid"; exit }

$hashdata = get-content $file | where-object {$_ -ne ""} | select-object -skip $skip

if ($hashdata.length % 3 -ne 0)
{
    $hashdata.length 
    "unexpected format"; exit
}

$rows = $hashdata.length / 3
$filehashes = @()
for($i = 0; $i -lt $rows; $i++)
{ 
    $algorithm,$hashvalue,$path,$hashdata = $hashdata
    $algorithm = $algorithm.split(":")[1].trim()
    $hashvalue = $hashvalue.split(":")[1].trim()
    $pathparts = $path.split("\")    
    $filename = $pathparts[$pathparts.length - 1]    
    $hashobject = @{ 
        Algorithm = $algorithm;
        Hash = $hashvalue;
        File = $filename
    }
    $filehashes += $hashobject
}

for($i = 0; $i -lt $rows; $i++)
{   
    $item = $filehashes[$i]
    $complete = [math]::round( ($i / $rows) * 100, 2)
    Write-Progress -Activity "Verifying Hashes" -Status "file $i of $rows, $complete% Complete:" -PercentComplete $complete; 
    $targetfile = join-path -path $targetfolder -ChildPath $item.File
    if ((test-path -path $targetfile) -eq $false) 
    {         
        Write-ToApplicationLog( "'$targetfile' not found", $true )
        continue
    }
    $hashtest = get-filehash -Path $targetfile -Algorithm $item.Algorithm
    $expected = $item.Hash; $detected = $hashtest.Hash
    if ($expected -ne $detected)
    {        
        Write-ToApplicationLog( "'$targetfile': expected $expected, detected $detected -> FAILED", $true )
    } else {
        Write-ToApplicationLog( "'$targetfile': expected $expected, detected $detected -> PASSED", $true )
    }    
}

