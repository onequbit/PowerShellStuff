@powershell "while (1){test-connection %1 -count 1|select Address,@{n='TimeStamp';e={Get-Date}},ResponseTime";start-sleep -seconds 1}
