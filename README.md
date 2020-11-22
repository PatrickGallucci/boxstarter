``# boxstarter
My Boxstarter scripts for building PC's

After the PC Refresh is complete Logon to the Windows PC and apply all windows updates until there are no more pending installs.


Click Windows Start > Powershell ISE > Right click Select Run as Administrator
Paste this command:
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Paste this command:
    cinst boxstarter

http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/PatrickGallucci/boxstarter/master/boxstarter.ps1
http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/PatrickGallucci/boxstarter/master/boxstarter-dev.ps1

