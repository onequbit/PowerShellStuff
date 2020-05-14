$dnsname = "$env:COMPUTERNAME"
$subject = "CN=$dnsname code signing"
$certs = (Get-ChildItem -Path Cert:\CurrentUser\My) | where {$_.Subject -eq "$subject"}
$certExists = $certs.Count -gt 0
if ($certExists)
{
    $certs
}
else {
    $cert = New-SelfSignedCertificate -CertStoreLocation cert:\currentuser\my `
    -DnsName $dnsname `
    -Subject "$subject" `
    -KeyAlgorithm RSA `
    -KeyLength 2048 `
    -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" `
    -KeyExportPolicy Exportable `
    -KeyUsage DigitalSignature `
    -Type CodeSigningCert
    $cert
    "...created"
}


