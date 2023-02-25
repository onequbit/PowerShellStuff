function Find-FilePath
{
    param([string]$path, [string] $filename)
    if ($filename -eq "")
    {
        echo "invalid filename $filename"
        return
    }
    $found = (where.exe /r $path $filename) | split-path
    $found
}
Export-ModuleMember Find-FilePath
