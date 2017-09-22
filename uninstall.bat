rem wmic product where name="Microsoft Office" call uninstall /nointeractive
rem wmic product where name="3CX CRM Integration" call uninstall /nointeractive
rem wmic product where name="3CXPhone for Windows" call uninstall /nointeractive

rem When installing, copy the MSI to the remote computer

rem Get list of all computers in call center and anyone else that uses
rem the 3CX Phone client

rem copy the MSI to the remote computer's C drive


rem Install the MSI
wmic /node:@"\\srv-nas-01\technology\scripts\computers.txt" /user:administrator /password:"!&!m0bil@R@xis0916" product call install true,"" , "c:\3CXPhoneforWindows14.msi"