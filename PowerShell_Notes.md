# PowerShell Notes



#### Show Enabled Windows Features
```
Get-WindowsOptionalFeature -Online | where {$_.State -eq "Enabled"}
```
---

### **Windows Subsystem for Linux 2 - Installation**

https://docs.microsoft.com/en-us/windows/wsl/wsl2-install


#### 1. *As Administrator:*
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

#### 2. reboot

#### 3. download Appx package locally
- * Use Fiddler to capture the Microsoft Store traffic
- * Start the Install from the Microsoft Store, then pause immediately
- * Find the URI of the download in Fiddler, copy to clipboard
- * Paste into a browser to download the file and save locally

#### 4. install via PowerShell
```
Add-AppxPackage -Path .\Downloaded.AppxBundle
```

#### 5. Open Ubuntu App to Initialize

#### 6. Set WSL Version

*for a specific distro:*
```
wsl --set-version <Distro> 2
```

*for all distros:*
```
wsl --set-default-version 2
```

---




