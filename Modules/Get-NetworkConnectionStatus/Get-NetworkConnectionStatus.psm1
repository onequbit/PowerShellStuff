function Get-NetworkConnectionStatus {
    param(
        $ComputerName=$env:computername
    )
    echo "Getting network connection status"
    $ComputerName
    $statushash = @{
        0 = "Disconnected"
        1 = "Connecting"
        2 = "Connected"
        3 = "Disconnecting"
        4 = "Hardware not present"
        5 = "Hardware disabled"
        6 = "Hardware malfunction"
        7 = "Media Disconnected"
        8 = "Authenticating"
        9 = "Authentication Succeeded"
        10 = "Authentication Failed"
        11 = "Invalid Address"
        12 = "Credentials Required"
    }
    $networks = get-ciminstance -class Win32_NetworkAdapter # -ComputerName $computername    
    $networkName = @{name="NetworkName";Expression={$_.Name}}
    $networkStatus = @{name="Networkstatus";Expression={$statushash[[int32]$($_.NetConnectionStatus)]}}    
    foreach ($network in $networks) {        
        $network | select $networkName, $Networkstatus
    }    
}
Export-ModuleMember Get-NetworkConnectionStatus
