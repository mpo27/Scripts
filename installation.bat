msiexec /q /i t:\software\msi\googlechromestandaloneenterprise.msi

msiexec /i t:\Software\msi\LibreOffice_5.0.3_Win_x86.msi /quiet


msiexec /i "t:\Software\msi\7z920-x64.msi" /quiet


rem "t:\Software\Adobe Reader\Setup.exe" /sAll

Copy t:\software\msi\3cxphoneforwindows14.msi "c:\program files"

Set /P response="Do you want to install 3CX? Enter y or n "
if "%response%"=="y" (
msiexec /q /i "c:\program files\3cxphoneforwindows14.msi")


msiexec /i t:\software\MSI\wsasme.msi GUILIC=SAFB-ENTP-47CB-3332-7663 CMDLINE=SME,quiet /qn /l*v install.log

"t:\software\Setup.X86.en-us_O365BusinessRetail_05ac22b3-2f3b-4d40-af8c-174a0fef5838_TX_PR_b_32_.exe"

del C:\Users\Public\Desktop\*.* /q

pause

