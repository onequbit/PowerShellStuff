function Get-ConnectionStatus {
    $output = ""
    $computername=$env:computername
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
    $networks = Gwmi -Class Win32_NetworkAdapter -ComputerName $computername
    $networkName = @{name="NetworkName";Expression={$_.Name}}
    $networkStatus = @{name="Networkstatus";Expression={$statushash[[int32]$($_.NetConnectionStatus)]}}
    foreach ($network in $networks) {
        $output = $network | select $networkName, $Networkstatus
        $output
    }
}
Export-ModuleMember -Function *