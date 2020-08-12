<#
.SYNOPSIS
  BoxStarter script to configure Windows 10 Pro on SurfaceBook2

.DESCRIPTION
  Install BoxStarter:
  Set-ExecutionPolicy Unrestricted
  . { Invoke-WebRequest -useb http://boxstarter.org/bootstrapper.ps1 } | Invoke-Expression; get-boxstarter -Force

  Run by calling the following from an **elevated** command-prompt. 
  Remove -DisableReboots parameter to allow the script to reboot as required.
  Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/holgerimbery/boxstarter/master/SurfaceBook/boxstarter.ps1 -DisableReboots

.NOTES
  Author : Holger Imbery
  Created: 2020-07-24
#>

#Temporarily disable UAC
Disable-UAC


#Trust PSGallery
Get-PackageProvider -Name NuGet -ForceBootstrap
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted


#Install PowerShell Get
Install-Module -Name PowerShellGet -force


#Powershell Core
cinst powershell-core --install-arguments='"ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1"' -y


#Windows Terminal
cinst microsoft-windows-terminal -y


#Configure Windows: Explorer Options
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar
#Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowHiddenFilesFoldersDrives -EnableShowFullPathInTitleBar


#Configure Windows: Taskbar
#Set-TaskbarOptions -Size Small -Dock Top -Combine Full -AlwaysShowIconsOn


#Reset Cache Location
choco config set cacheLocation "$env:temp\chocolatey"


#Disable SMBv1
Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol


# Disable Application suggestions and automatic installation
Function DisableAppSuggestions {
	Write-Output "Disabling Application suggestions..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-314559Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Name "AllowSuggestedAppsInWindowsInkWorkspace" -Type DWord -Value 0
	# Empty placeholder tile collection in registry cache and restart Start Menu process to reload the cache
	If ([System.Environment]::OSVersion.Version.Build -ge 17134) {
		$key = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\*windows.data.placeholdertilecollection\Current"
		Set-ItemProperty -Path $key.PSPath -Name "Data" -Type Binary -Value $key.Data[0..15]
		Stop-Process -Name "ShellExperienceHost" -Force -ErrorAction SilentlyContinue
	}
}
DisableAppSuggestions


##Uninstall Bing Finance, News, Sports & Weather
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
#Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
#Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage


#Uninstall Unrequired Windows 10 Store Apps
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage
Get-AppxPackage *Solitaire* | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage
Get-AppxPackage *king* | Remove-AppxPackage
Get-AppxPackage *xing* | Remove-AppxPackage
#Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage


#Install Fonts: SourceCodePro, cascadiacodepl
cinst sourcecodepro -y
cinst cascadiacodepl -y


#
# visualstudio code and visualstudio enterprise

#Install Visual Studio Enterprise
cinst visualstudio2019enterprise -y
refreshenv

#Install Visual Studio Code
cinst vscode -y
refreshenv

#Install Visual Studio Code Extensions
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
refreshenv
#code --force --install-extension ms-vscode-remote.remote-wsl
code --force --install-extension sohamkamani.code-eol
#code --force --install-extension ms-vscode.cpptools
code --force --install-extension ms-vscode.powershell


#install node.js lts, python3
cinst nodejs-lts
cinst python


#Install Git
cinst git --params '"/GitAndUnixToolsOnPath /WindowsTerminal /SChannel"' -y
refreshenv
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
refreshenv
git config --global credential.helper wincred
git config --global --bool pull.rebase true


# install gsudo
cinst gsudo -y
refreshenv`

#Installing posh-git and oh-my-posh
Install-Module -Name posh-git
Update-Module -Name posh-git
Install-Module -Name oh-my-posh
Update-Module -Name oh-my-posh

#Install NuGet Package Explorer
cinst nugetpackageexplorer -y
if (test-path (Join-Path ([Environment]::GetFolderPath("Desktop")) "NugetPackageExplorer.exe.lnk")) {
    Move-Item (Join-Path ([Environment]::GetFolderPath("Desktop")) "NugetPackageExplorer.exe.lnk") (Join-Path ([Environment]::GetEnvironmentVariable("AppData")) "Microsoft\Windows\Start Menu\Programs\NugetPackageExplorer.lnk")
}

#Install Microsoft Edge
cinst microsoft-edge


#Install chocolatey GUI
cinst chocolateygui -y


#install WinSCP
cinst winscp -y 


#Install Mouse without Borders
cinst mousewithoutborders -y


#Install Powertoys
cinst powertoys -y


Write-Output "Complete"

#Restore UAC
Enable-UAC

#Check for / install Windows Updates
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula

$computername = "SurfaceBook2"
if ($env:computername -ne $computername) {
	Rename-Computer -NewName $computername
}
