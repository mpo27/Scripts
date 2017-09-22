rem wmic product where name="Microsoft Office" call uninstall

msiexec /q /i \\srv-nas-01\technology\software\msi\googlechromestandaloneenterprise.msi

\\srv-nas-01\Technology\Software\msi\LibreOffice_5.0.3_Win_x86.msi /quiet


"\\srv-nas-01\Technology\Software\msi\7z920-x64.msi" /quiet


"\\srv-nas-01\Technology\Software\Adobe Reader\Setup.exe" /sAll

Copy \\srv-nas-01\technology\software\msi\3cxphoneforwindows14.msi "c:\program files"
copy \\srv-nas-01\technology\software\Setup.X86.en-us_O365BusinessRetail.exe "c:\program files"

Set /P response="Do you want to install 3CX? Enter y or n "
if "%response%"=="y" (
msiexec /q /i "c:\program files\3cxphoneforwindows14.msi")

\\srv-iis\sophosupdate\CIDs\S000\SAVSCFXP\setup.exe

Set /P response2="Do you want to install office? Enter y or n "
if "%response2%" == "y" (
"c:\program files\Setup.X86.en-us_O365BusinessRetail.exe")

del C:\Users\Public\Desktop\*.* /q



pause

