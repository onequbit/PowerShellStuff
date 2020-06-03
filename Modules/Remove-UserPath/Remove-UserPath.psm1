
function Remove-UserPath
{
    param ([string] $pathToDelete)
    $currentpaths = (get-itemproperty -path 'Registry::HKCU\Environment' -Name Path).Path -split(';')
    if ( !($currentpaths -contains $pathToDelete) )
    {
        echo "path: '$pathToDelete' not found"
        return
    }
    $newPaths = $currentpaths | Where-Object { $_ –ne $pathToDelete }
    set-itemproperty -path 'Registry::HKCU\Environment' -Name Path -Value $newPaths
}

Export-ModuleMember Remove-UserPath