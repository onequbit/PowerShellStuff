$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$showProgress = ($args[2] -ne "loop")
function Ping-Subnet 
{
    param (
        [Parameter(Mandatory=$true)][string]$start_ip, 
        [Parameter(Mandatory=$true)][string]$end_ip
    )

    $myIP = (Get-NetIPAddress | where {$_.AddressState -eq "Preferred" -and $_.AddressFamily -eq "IPv4" -and $_.PrefixOrigin -eq "Dhcp"}).IPAddress
    $subnet = $myIP.split('.')[0..2] | join-string -Separator '.'
    $output = @()
    for ($i = $start_ip -as [int]; $i -le $end_ip -as [int]; $i++)
    {        
        $ip = $subnet + "." + $i        
        if ($showProgress)
        {
            $progress = [math]::round( (($i-$start_ip)/($end_ip-$start_ip)*100), 2)
            Write-Progress -Activity "Scanning IP Range..." -Status "[$ip] --> $progress% Complete" -PercentComplete $progress;
        }        
        try {
            $result = Test-Connection $ip -count 1 | select Destination,Status,@{n='TimeStamp';e={Get-Date}}                        
            $target = $result.Destination; $status = $result.Status; $time = $result.TimeStamp
            $line = "$target @ $time ... $status"
            if ($status -eq "Success")
            {
                $hostname = [System.Net.Dns]::GetHostByAddress($ip).HostName
                $line += " -> [" + $hostname +"]"
            }
            if ($showProgress)
            {
                $output += $line
            } else {
                $line
            }
        }
        catch {            
        }
    }
    # Write-Progress -Activity "Scanning IP Range..." -Completed
    # if ($showProgress) { "";"";"" }
    $output
}

if ($args[0] -eq $null) { throw "start_IP required (1..254)"}
if ($args[1] -eq $null) { throw "end_IP required (1..254)"}
Ping-Subnet $args[0] $args[1]
if ($args[2] -eq "loop")
{
    $command = "& .\Ping-Subnet $args"
    Start-Sleep -Seconds 1
    Invoke-Expression -command $command
}