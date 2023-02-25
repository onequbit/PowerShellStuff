cls
Import-Module activedirectory
"=========================================================================================================================="
$UPNdomain = "@CSFOT.local"
$studenttemplatename = "_studenttemplate"
$password = ConvertTo-SecureString "n0pl@ce2H!D3" -AsPlainText -Force
$UPN = $studenttemplatename + $UPNdomain
New-ADUser -Name $studenttemplatename -DisplayName "Student Template" -SamAccountName $studenttemplatename -UserPrincipalName $UPN -AccountPassword $password -Enabled $false -ChangePasswordAtLogon $false –PasswordNeverExpires $true -CannotChangePassword $true
$studenttemplate = Get-ADUser $studenttemplatename
$studenttemplateproperties = Get-ADUser $studenttemplatename -Properties *s | Get-Member # | Where {$_.MemberType -eq "Property" } # -and $_.Definition -match 'set;' }
#$studenttemplateproperties

foreach ($property in $studenttemplateproperties) {
    $property.Name + ":" + $studenttemplate[$property.Name]
}


for ($i=1; $i -le 25; $i++) {
    $displayName = "Student" + $i
    $samAccountName = "student" + $i
    $UPN = $samAccountName + $UPNdomain
    New-ADUser -Name "$displayName" -DisplayName "$displayName" -SamAccountName $samAccountName -UserPrincipalName $UPN -AccountPassword $password -Enabled $true -ChangePasswordAtLogon $false –PasswordNeverExpires $true -CannotChangePassword $true
}

