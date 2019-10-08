

$mapsbroker_path = "HKLM:\system\currentcontrolset\services\MapsBroker"
Set-ItemProperty -Path $mapsbroker_path -name "Start" -Value 4

$onesync_keys = Get-ChildItem -path:"HKLM:\system\currentcontrolset\services\onesync*"
foreach ($key in $onesync_keys) {
    $path = $key.Name.Replace("HKEY_LOCAL_MACHINE","HKLM:")
    Set-ItemProperty -Path $path -name "Start" -Value 4
}
