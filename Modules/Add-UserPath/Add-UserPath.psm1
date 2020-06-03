function Add-UserPath
{
    param ([string] $addedpath)

    $currentpaths = (get-itemproperty -path 'Registry::HKCU\Environment' -Name Path).Path -split(';')
    if ($addedpath -eq "")
    {
        echo "$currentpaths"
        return
    }

    if ( !($currentpaths -contains $addedpath) )
    {
        $userpath = (get-itemproperty -path 'Registry::HKCU\Environment' -Name Path).Path + "$addedpath;"
        set-itemproperty -path 'Registry::HKCU\Environment' -Name Path -Value $userpath
        echo "'$addedpath' added to User Environment Path"
    } else
    {
        echo "'$addedpath' already exists"
    }
}

Export-ModuleMember Add-UserPath