class WDdisk {
    [Int32]$DiskNumber
    [string]$DriveLetter
    [string]$SerialNumber
}

function Get-WDdisks
{
    $wddisks = Get-Disk | Where-Object {$_.FriendlyName -like 'WD Elements*'}
    $results = New-Object System.Collections.ArrayList
    foreach ($disk in $wddisks)
    {
        $result = [WDdisk]::new()
        $partition = $disk | Get-Partition
        $result.DiskNumber = $disk.Number
        $result.SerialNumber = $disk.SerialNumber
        $result.DriveLetter = $partition.DriveLetter
        $results.add($result)
    }
    return $results
}

function Format-WDDisks
{
    $wddisks = Get-WDdisks    
    return $wddisks
    #return $results

    # foreach ($disk in $wddisks) 
    # {
    #     $diskNumber = $disk.Number
    #     $newLabel = $disk.SerialNumber
    #     Initialize-Disk -Number $diskNumber -Confirm
    #     New-Partition -DiskNumber $diskNumber -UseMaximumSize | Format-Volume -FileSystem exFAT -NewFileSystemLabel $newLabel -Confirm
    # }
}

Export-ModuleMember -Function * -Alias *
