Import-Module Activedirectory
$user1 = Read-Host -Prompt 'Input the user to copy permissions from'
$user2 = Read-Host -Prompt 'Input the user to copy permissions to'
Get-ADUser -Identity $user1 -Properties memberof |
Select-Object -ExpandProperty memberof |
Add-ADGroupMember -Members $user2
pause