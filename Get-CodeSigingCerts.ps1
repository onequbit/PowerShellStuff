$certs = Get-ChildItem -Path Cert:\CurrentUser\My
$codecerts = @()
foreach($cert in $certs)
{    
    $usages = foreach($key in $cert.Extensions)
    {
        if('KeyUsages' -in $key.psobject.Properties.Name )
        { 
            $key.KeyUsages
        }
        if('EnhancedKeyUsages' -in $key.psobject.Properties.Name)
        {
            $key.EnhancedKeyUsages.FriendlyName
        }
    }
    if ($usages -contains "Code Signing")
    {
        $subject = $cert.Subject
        $subject
    }    
}