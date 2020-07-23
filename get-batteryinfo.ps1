$Battery = Get-CimInstance -ClassName win32_battery
Switch ($Battery.Availability) 
{
    1  { $Availability = "Other" ;break}
    2  { $Availability =  "Not using battery" ;break}
    3  { $Availability = "Running or Full Power";break}
    4  {$Availability =  "Warning" ;break}
    5  { $Availability = "In Test";break}
    6  { $Availability = "Not Applicable";break}
    7  { $Availability = "Power Off";break}
    8  { $Availability = "Off Line";break}
    9  { $Availability = "Off Duty";break}
    10  {$Availability =  "Degraded";break}
    11  {$Availability =  "Not Installed";break}
    12  {$Availability =  "Install Error";break}
    13  { $Availability = "Power Save - Unknown";break}
    14  { $Availability = "Power Save - Low Power Mode" ;break}
    15  { $Availability = "Power Save - Standby";break}
    16  { $Availability = "Power Cycle";break}
17  { $Availability = "Power Save - Warning";break}
}
$info = [PSCustomObject]@{ 
    BatteryStatus = $Battery.Status
    BatteryName = "$($Battery.name)"
    Remaining = $Battery.EstimatedChargeRemaining
    EstRunTimeMinutes = $Battery.EstimatedRunTime
    BatAvailability = $Availability
}
$info
