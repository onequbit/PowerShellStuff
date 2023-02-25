for ($i = 1; $i -le 25; $i++)
{
    $name = "STUDENTPC" + $i.ToString().PadLeft(2,"0")    
    New-ADComputer -Name "$name" -SamAccountName "$name" -Path "CN=Computers,DC=CSFOT,DC=local" -Enabled $True
    "$name created"
}
"Computer accounts created"
    

