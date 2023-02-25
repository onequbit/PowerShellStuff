$filename = $args[0]
$filecheck = test-path -path $filename
if ($filename -eq $null -or $filecheck -eq $false)
{
    throw "file not found"
}
$hashdata = get-content $filename

foreach ($line in $hashdata) {
    if ($line)
    {
        $line
    }
}

