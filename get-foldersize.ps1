$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

function Get-FolderContentSize
{
    param(
        [Parameter(Mandatory=$true)][string]$target
    )
    $result = "{0} MB" -f ((Get-ChildItem $target -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)
    $result
}


if ($args[0] -eq $null) { throw "target folder required"}

Get-FolderContentSize $args[0]
