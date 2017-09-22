$User = Read-Host -Prompt 'Input the account name'
Disable-ADAccount -Identity $User