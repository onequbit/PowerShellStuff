function msgbox {
    param (
        [string]$Message,
        [string]$Title = '$env:ComputerName',   
        [string]$buttons = 'OK'
    )
    # This function displays a message box by calling the .Net Windows.Forms (MessageBox class)
     
    # Load the assembly
    Add-Type -AssemblyName System.Windows.Forms | Out-Null
     
    # Define the button types
    switch ($buttons) {
       'OK' {$btn = [System.Windows.Forms.MessageBoxButtons]::OK; break}
       'OKCancel' {$btn = [System.Windows.Forms.MessageBoxButtons]::OKCancel; break}
       'YesNoCancel' {$btn = [System.Windows.Forms.MessageBoxButtons]::YesNoCancel; break}
       'yesno' {$btn = [System.Windows.Forms.MessageBoxButtons]::yesno; break}
       'RetryCancel'{$btn = [System.Windows.Forms.MessageBoxButtons]::RetryCancel; break}
       default {$btn = [System.Windows.Forms.MessageBoxButtons]::RetryCancel; break}
    }
     
    # Display the message box
    $Return=[System.Windows.Forms.MessageBox]::Show($Message,$Title,$btn)
    
    # Display the option chosen by the user:
    $Return
}

$targetComputer = $args[0]
$sameComputer = $targetComputer -eq $env:ComputerName
$thisFile = $MyInvocation.PSCommandPath
Write-Host "this: $env:ComputerName, target: $targetComputer (same: $sameComputer), file: $thisFile"

if ($sameComputer)
{
    // msgbox("I'm here")
    Invoke-Command -ComputerName $targetComputer -FilePath $thisFile -Credential $targetComputer\Alfred
}
else {
    msgbox("I'm there!")
}
