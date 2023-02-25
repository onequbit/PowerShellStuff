$ethernetAdapter = get-netipaddress -addressfamily IPv4 | where {$_.InterfaceAlias -eq "Ethernet"}
$lastoctet = $ethernetAdapter.IPAddress.split(".")[3]
$computername = "StudentPC-$lastoctet"
rename-computer -newname $computername
