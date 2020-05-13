function Get-StampedFileName {
    $output = get-date -format "yyyyMMdd_HHmm"
    $output
}
Export-ModuleMember -Function *