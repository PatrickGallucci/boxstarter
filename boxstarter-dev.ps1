<#
.SYNOPSIS
  Script to configure Windows 10,11

.DESCRIPTION
  Install Windows 11:

.NOTES
  Author : Gallucci
  Created: 2023-01-21
#>

Disable-UAC

# Boxstarter Options
Write-Output "Setting Boxstarter variables"
mkdir c:\temp -Confirm:0 -ErrorAction Ignore
$Boxstarter.Log = "C:\temp\boxstarter.log"
$Boxstarter.SuppressLogging = $false
$Boxstarter.RebootOk = $true
$Boxstarter.NoPassword = $false
$Boxstarter.AutoLogin = $true

# No confirmation i.e. --yes
choco feature enable --name=allowGlobalConfirmation

# Disable Microsoft and Windows update
Disable-MicrosoftUpdate

#Trust PSGallery
Get-PackageProvider -Name NuGet -ForceBootstrap
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name PowerShellGet -force

## Rename Windows
$computername = "PIZZAPIZZA"

# Requires restart, or add the -Restart flag
if ($env:computername -ne $computername) {
	#Rename-Computer -NewName $computername
}

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

# Tools
Write-Host "Installing Tools..." -ForegroundColor "Yellow"
choco install googlechrome -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"
choco install 7zip.install -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"   
choco install filezilla -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install paint.net -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install snagit --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install camtasia -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install kindle -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install audacity -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install discord -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install github-desktop -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install notion -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

#Visual Studio
Write-Host "Installing Visual Studio..." -ForegroundColor "Yellow"
choco install visualstudio2022enterprise --All -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache"

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

choco install visualstudio2022-workload-managedgame --All -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-azurebuildtools --All -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-azure --All -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-python -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-visualstudioextension -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-visualstudioextensionbuildtools -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-office -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-azurebuildtools -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-manageddesktop -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-manageddesktopbuildtools -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-datascience -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-data -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-databuildtools -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-netweb -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install visualstudio2022-workload-webbuildtools -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

#Developer Tools
Write-Host "Installing Developer Tools..." -ForegroundColor "Yellow"
choco install vscode -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

choco install vscode-powershell -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install vscode-settingssync -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install vscode-jupyter -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install vscode-mssql -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install vscode-xmltools -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install python -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install unity-docs -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install unity -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install unity-standard-assets -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install unity-hub -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install git -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install git-helper -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install git-credential-manager-for-windows -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install debugdiagnostic -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install sqlnexus -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

#Install SQL Tools
choco install sql-server-2022 -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install sql-server-management-studio -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

choco install sqltoolbelt -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install azure-data-studio -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install azure-data-studio-sql-server-admin-pack -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install azuredatastudio-powershell -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install powerbi -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install powerbi-reportbuilder -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

#Install Azure
choco install azure-cli -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install azure-cosmosdb-emulator -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install microsoftazurestorageexplorer -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install azure-functions-core-tools-3 -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install vscode-azure-deploy -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install azurepowershell -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install windowsazurelibsfornet -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install amsexplorer -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install vscode-azurerm-tools -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install cosmosdbexplorer -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install azcopy -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install azcopy10 -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 
choco install servicebusexplorer -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

#Ubuntu
Write-Host "Installing Ubuntu..." -ForegroundColor "Yellow"
choco install wsl -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

## choco install wsl-ubuntu-2204 -y --cacheLocation "$env:UserProfile\AppData\Local\ChocoCache" 

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

#auto upgrade
choco install choco-upgrade-all-at-startup

#--- Uninstall unnecessary applications that come with Windows out of the box ---
Write-Host "Uninstall some applications that come with Windows out of the box" -ForegroundColor "Yellow"
function removeApp {
	Param ([string]$appName)
	Write-Output "Trying to remove $appName"
	Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
	Get-AppXProvisionedPackage -Online | Where DisplayName -like $appName | Remove-AppxProvisionedPackage -Online
}

$applicationList = @(
	"Microsoft.BingFinance"
	"Microsoft.3DBuilder"
	"Microsoft.BingNews"
	"Microsoft.BingSports"
	"Microsoft.BingWeather"
	"Microsoft.CommsPhone"
	"Microsoft.Getstarted"
	"Microsoft.WindowsMaps"
	"*MarchofEmpires*"
	"Microsoft.GetHelp"
	"Microsoft.Messaging"
	"*Minecraft*"
	"Microsoft.MicrosoftOfficeHub"
	"Microsoft.OneConnect"
	"Microsoft.WindowsPhone"
	"Microsoft.WindowsSoundRecorder"
	"*Solitaire*"
	"Microsoft.MicrosoftStickyNotes"
	"Microsoft.Office.Sway"
	"Microsoft.XboxApp"
	"Microsoft.XboxIdentityProvider"
	"Microsoft.XboxGameOverlay"
	"Microsoft.XboxGamingOverlay"
	"Microsoft.ZuneMusic"
	"Microsoft.ZuneVideo"
	"Microsoft.NetworkSpeedTest"
	"Microsoft.FreshPaint"
	"Microsoft.Print3D"
	"Microsoft.People*"
	"Microsoft.Microsoft3DViewer"
	"Microsoft.MixedReality.Portal*"
	"*Skype*"
	"*Autodesk*"
	"*BubbleWitch*"
    	"king.com*"
    	"G5*"
	"*Dell*"
	"*Facebook*"
	"*Keeper*"
	"*Netflix*"
	"*Twitter*"
	"*Plex*"
	"*.Duolingo-LearnLanguagesforFree"
	"*.EclipseManager"
	"ActiproSoftwareLLC.562882FEEB491" # Code Writer
	"*.AdobePhotoshopExpress"
);

foreach ($app in $applicationList) {
    removeApp $app
}

## Configure Windows
Write-Output "Configure Windows..." -ForegroundColor "Yellow"
# Turn off screensaver
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name ScreenSaveActive -Value 0
Set-StartScreenOptions -EnableBootToDesktop
# Disable UAC popups
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name EnableLUA -Value 0 -Force
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0
#--- Configuring Windows properties ---
#--- Windows Features ---
# Show hidden files, Show protected OS files, Show file extensions
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
#--- File Explorer Settings ---
# will expand explorer to the actual folder you're in
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
#adds things back in your left pane like recycle bin
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
#opens PC to This PC, not quick access
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
#taskbar where window is open for multi-monitor
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

##Disable GameBarTips
Disable-GameBarTips
#Disable Windows Consumer Features 
Write-Output "Disable Windows Consumer Features" -ForegroundColor "Yellow"
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWORD -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWORD -Value 1 -Force
# Hide Search button / box
Write-Output "Hide Search Button" -ForegroundColor "Yellow"
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }


## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

# Power Options - disable hibernation and disable monitor standby
Write-Host "Configuring power options..." -ForegroundColor "Yellow"
$highPerfGuid = (powercfg -l | ? {$_.Contains("Balanced")}).Split(":")[1].Trim().Split(' ')[0];
Write-Host $highPerfGuid -ForegroundColor "Yellow"
$newGuid = [System.Guid]::NewGuid()

powercfg -duplicatescheme $highPerfGuid $newGuid | Out-Null
powercfg -changename $newGuid "Gallucci Power Scheme"

powercfg -setactive $newGuid
powercfg -X monitor-timeout-ac 0
powercfg -X disk-timeout-ac 0
powercfg -X standby-timeout-ac 0
powercfg -X hibernate-timeout-ac 0
powercfg -X hibernate-timeout-dc 0

$SubGroup_PowerButtonsAndLid = '4f971e89-eebd-4455-a8de-9e59040e7347'
$pwr_LidCloseAction = '5ca83367-6e45-459f-a27b-476b1d01c936'
$pwr_PowerButtonAction = '7648efa3-dd9c-4e3e-b566-50f929386280'
$pwr_SleepButtonAction = '96996bc0-ad50-47ec-923b-6f41874dd9eb'
$pwr_StartMenuPowerButton = 'a7066653-8d6c-40a8-910e-a1f54b84c7e5'

powercfg -setdcvalueindex $newGuid $SubGroup_PowerButtonsAndLid $pwr_LidCloseAction 2
powercfg -setacvalueindex $newGuid $SubGroup_PowerButtonsAndLid $pwr_LidCloseAction 2
powercfg -setdcvalueindex $newGuid $SubGroup_PowerButtonsAndLid $pwr_PowerButtonAction 3
powercfg -setacvalueindex $newGuid $SubGroup_PowerButtonsAndLid $pwr_PowerButtonAction 3
powercfg -setdcvalueindex $newGuid $SubGroup_PowerButtonsAndLid $pwr_SleepButtonAction 1
powercfg -setacvalueindex $newGuid $SubGroup_PowerButtonsAndLid $pwr_SleepButtonAction 1
powercfg -setdcvalueindex $newGuid $SubGroup_PowerButtonsAndLid $pwr_StartMenuPowerButton 2
powercfg -setacvalueindex $newGuid $SubGroup_PowerButtonsAndLid $pwr_StartMenuPowerButton 2

$SubGroup_Display = '7516b95f-f776-4464-8c53-06167f40cc99'
$pwr_DimDisplayAfter = '17aaa29b-8b43-4b94-aafe-35f64daaf1ee'
$pwr_TurnOffDisplayAfter = '3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e'
$pwr_DisplayBrightness = 'aded5e82-b909-4619-9949-f5d71dac0bcb'
$pwr_DimmedDisplayBrightness = 'f1fbfde2-a960-4165-9f88-50667911ce96'

powercfg -setdcvalueindex $newGuid $SubGroup_Display $pwr_DimDisplayAfter (0x12c)
powercfg -setacvalueindex $newGuid $SubGroup_Display $pwr_DimDisplayAfter 0
powercfg -setdcvalueindex $newGuid $SubGroup_Display $pwr_TurnOffDisplayAfter (0x258)
powercfg -setacvalueindex $newGuid $SubGroup_Display $pwr_TurnOffDisplayAfter 0
powercfg -setdcvalueindex $newGuid $SubGroup_Display $pwr_DisplayBrightness 50
powercfg -setacvalueindex $newGuid $SubGroup_Display $pwr_DisplayBrightness 100
powercfg -setdcvalueindex $newGuid $SubGroup_Display $pwr_DimmedDisplayBrightness 25
powercfg -setacvalueindex $newGuid $SubGroup_Display $pwr_DimmedDisplayBrightness 50

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }

Write-Output "Complete"

#Check for / install Windows Updates
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula

## Testing for Reboot
Write-Output "Testing for Reboot..." -ForegroundColor "Blue"
if (Test-PendingReboot) { Invoke-Reboot }