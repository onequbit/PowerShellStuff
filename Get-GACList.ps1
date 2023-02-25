New-PSDrive -Name HKCR -PSProvider 'Microsoft.PowerShell.Core\Registry' -Root HKEY_CLASSES_ROOT
$assemblies = Get-ItemProperty -Path 'HKCR:\Installer\Assemblies\Global' | Get-Member -MemberType *
$assemblies | where {$_.Name -and $_.Name.StartsWith("System.")}

