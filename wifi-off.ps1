PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Unrestricted -Command ""get-netadapter | Where -value \"Wi-Fi\" -CIn Name | Disable-NetAdapter -confirm:$False""' -Verb RunAs}";

