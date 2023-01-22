``# boxstarter
My Boxstarter scripts for building PC's

After the PC Refresh is complete Logon to the Windows PC and apply all windows updates until there are no more pending installs.

Click Windows Start > Powershell ISE > Right click Select Run as Administrator
Paste this command:
. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/PatrickGallucci/boxstarter/master/boxstarter.ps1
http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/PatrickGallucci/boxstarter/master/boxstarter-dev.ps1
http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/PatrickGallucci/boxstarter/master/boxstarter-lukeg.ps1
