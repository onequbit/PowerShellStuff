$computer = $env:computername
$session = New-PSSession -ComputerName $computer
Invoke-Command -Session $session -ScriptBlock {msg araquino 'This is a test message.'}