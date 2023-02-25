# $FindDrives = Get-WmiObject -Query "SELECT * from win32_logicaldisk where DriveType = '2'" | Select-Object -ExpandProperty DeviceID
$FindDrives = Get-CimInstance -query "select * from win32_logicaldisk" | Select-Object -ExpandProperty DeviceID
$LogFile = "$env:USERPROFILE\Desktop\Mirror_USB_Logs\"
$colDrives = @()
$colDest = @()
$DestinationDrives = @()
$SelSource = ""

cls
Write-Host "WARNING! This script has the ability to write and ERASE DATA from Drives!"
Write-Host
Write-Host "Press 'Enter' to Acknowledge and continue."
Read-Host

Foreach ($drive in $FindDrives) {
    $i++
    
    $temp = New-Object System.Object
    $temp | Add-Member -MemberType NoteProperty -Name "ID" -Value $i
    $temp | Add-Member -MemberType NoteProperty -Name "Drive" -Value $drive\
    $colDrives += $temp

} $i = 0

Do {
cls
Write-Host "Choose an ID."
$colDrives | Format-Table -AutoSize
$SelSource = Read-Host "Please select a Source"
$SourceDrive = $colDrives[$SelSource - 1] | Select-Object -ExpandProperty Drive
} Until (($SelSource -ne "") -and ($colDrives.ID -contains $SelSource))
cls

Do {
cls
Write-Host "Choose an ID."
$colDrives | Where-Object {$_.ID -ne $SelSource} | Format-Table -AutoSize
$SelDest = Read-Host "Separate ID's with a comma. (ex. 1, 2, 3)"
$colDest = @($SelDest.Replace(' ','').Split(','))
Foreach ($Dest in $colDest) {
    If (($Dest -ne "") -and ($Dest -ne $SelSource) -and ($colDrives.ID -contains $Dest)){
        $DestinationDrives += @($colDrives[$Dest - 1] | Select-Object -ExpandProperty Drive)
    }}
} Until ($colDest.Count -gt 0)


cls
Write-Output "The source drive is set to: $SourceDrive"

# Start Background Jobs
Foreach ($DestinationDrive in $DestinationDrives){
    Write-Host "Mirroring" $DestinationDrive
    Start-Job -Scriptblock {robocopy $args[0] $args[1] /mir /np /z /v}  -Name $DestinationDrive -ArgumentList $SourceDrive, $DestinationDrive > $null
}

# Creates Logfile directory on desktop
If ((test-path $LogFile) -eq $FALSE) {
    mkdir -Path $LogFile > $null
}

# Setting up log file and name
$Time = get-date -f yyyy-MM-dd_hh.mm.ss
$File = $LogFile + $Time

#Log and Cleanup
    Foreach ($DestinationDrive in $DestinationDrives) {
        Wait-Job -Name $DestinationDrive -Force > $null
        Get-Job $DestinationDrive | Select-Object ID, Name, State, PSBeginTime, PSEndTime, Command | Format-Table -Wrap -AutoSize | Out-File -Append -Filepath $File`.log > $null
        Receive-Job $DestinationDrive | Out-File -Append -Filepath $File`.log > $null
        Remove-Job $DestinationDrive > $null
    }

cls
Write-Host "Mirror Complete!"
Write-Host
Write-Host "A log file has been placed on your desktop."
Write-Host
Join or Login to share what you think!