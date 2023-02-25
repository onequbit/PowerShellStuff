$myIP = (Get-NetIPAddress | where {$_.AddressState -eq "Preferred" -and $_.AddressFamily -eq "IPv4" -and $_.PrefixOrigin -eq "Dhcp"}).IPAddress
$myIP
# $ethernetAdapter = get-netipaddress -addressfamily IPv4 | where {$_.PrefixOrigin -eq "Dhcp"}
# $lastoctet = $ethernetAdapter.IPAddress.split(".")[3]
# $lastoctet




