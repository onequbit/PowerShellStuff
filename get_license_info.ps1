cls
$result = get-wmiobject softwarelicensingproduct -ComputerName $env:COMPUTERNAME | where-object {$_.ApplicationID -eq "55c92734-d682-4d71-983e-d6ec3f16059f"} | Select-Object *
foreach ($item in $result) {
    "########################################################################"
    $count = 0
    foreach ($prop in $item.Properties) {        
        $isnull = $prop.Value -eq $null -or $prop.Value.ToString().Trim() -eq ""
        $maxint = $prop.Value -eq 4294967295        
        if (-not ($isnull -or $maxint)) {
            $line = $prop.Name + ":" + $prop.Value
            $line
            $count = $count + 1
        }        
    }
    $count
}
