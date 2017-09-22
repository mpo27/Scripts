$user = read-host -prompt 'Enter the username: '
get-adprincipalgroupmembership -identity $user | select name | export-csv -delimiter "," -path "groups.csv"