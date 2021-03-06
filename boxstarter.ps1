<#
.SYNOPSIS
  BoxStarter script to configure Windows 10

.DESCRIPTION
  Install BoxStarter:

.NOTES
  Author : Patrick Gallucci
  Created: 2020-08-12
#>

# Boxstarter Options
Write-Output "Setting Boxstarter variables"
mkdir c:\temp -Confirm:0 -ErrorAction Ignore
$Boxstarter.Log="C:\temp\boxstarter.log"
$Boxstarter.SuppressLogging=$false
$Boxstarter.RebootOk=$true # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true # Save my password securely and auto-login after a reboot

# Remote access / support
Enable-RemoteDesktop

# Install Windows Update and reboot
Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }

# Power Options - disable hibernation and disable monitor standby
Write-Host "Configuring power options..."
powercfg -change -monitor-timeout-ac 0
powercfg -change -standby-timeout-ac 0
powercfg -h off

# Boxstarter (not Chocolatey) commands
Write-Output "Boxstarter commands"
Update-ExecutionPolicy Unrestricted
Disable-InternetExplorerESC  #Turns off IE Enhanced Security Configuration that is on by default on Server OS versions
Disable-UAC  # until this is over
Disable-MicrosoftUpdate # until this is over
Set-ExplorerOptions -showHidenFilesFoldersDrives -showFileExtensions
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1

#Trust PSGallery
Write-Output "Setting PSGallery & NuGet"
Get-PackageProvider -Name NuGet -ForceBootstrap
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name PowerShellGet -force

Write-Output "Setting choco"
choco feature enable -n=allowEmptyChecksums
choco feature enable -n=allowGlobalConfirmation
cinst chocolatey-windowsupdate.extension

# disabled bing search in start menu
Write-Output "Disabling Bing Search in start menu"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
	New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1

##Disable GameBarTips
Disable-GameBarTips


  # Hide taskbar search box
  Write-Output "Hiding task bar search box"
  Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

  # Hide Task View
  Write-Output "Hiding task view"
  Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0

  # Hide task Bar People icon
  Write-Output "Hiding task bar people icon"
  If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
      New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
  }
  Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0

# Disable Cortana
Function DisableCortana {
	Write-Output "Disabling Cortana..."
	If (!(Test-Path "HKCU:\Software\Microsoft\Personalization\Settings")) {
		New-Item -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
	If (!(Test-Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore")) {
		New-Item -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" -Name "Value" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
	If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Force | Out-Null
	}
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "AllowInputPersonalization" -Type DWord -Value 0
}
DisableCortana


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
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage


#Uninstall Unrequired Windows 10 Store Apps
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage
Get-AppxPackage *Solitaire* | Remove-AppxPackage
Get-AppxPackage *king* | Remove-AppxPackage
Get-AppxPackage *xing* | Remove-AppxPackage
Get-AppxPackage *spotify* | Remove-AppxPackage
Get-AppxPackage *YourPhone* | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage

choco install googlechrome -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
choco install visualstudio2019community --All -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
refreshenv
choco install visualstudio2019-workload-managedgame --All -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
refreshenv
choco install vscode -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
refreshenv
choco install adobereader -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install office365proplus -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install 7zip.install -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"   
choco install python -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install filezilla -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install itunes -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install microsoft-teams.install -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install paint.net -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install putty.portable -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install atom -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install unity-docs -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install unity -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install unity-standard-assets -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install unity-hub -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install zoom -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install 4k-video-downloader -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install camtasia -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install snagit -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install steam -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 


#Install NuGet Package Explorer
cinst nugetpackageexplorer -y
if (test-path (Join-Path ([Environment]::GetFolderPath("Desktop")) "NugetPackageExplorer.exe.lnk")) {
    Move-Item (Join-Path ([Environment]::GetFolderPath("Desktop")) "NugetPackageExplorer.exe.lnk") (Join-Path ([Environment]::GetEnvironmentVariable("AppData")) "Microsoft\Windows\Start Menu\Programs\NugetPackageExplorer.lnk")
}

#Install chocolatey GUI
cinst chocolateygui -y

Write-Output "Complete"


#Check for / install Windows Updates
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula -GetUpdatesFromMS

#$computername = "SurfBook"
#if ($env:computername -ne $computername) {
#	Rename-Computer -NewName $computername
#}