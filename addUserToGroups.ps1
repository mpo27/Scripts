$groups = Import-CSV t:\scripts\groupsdanleystofeldco\groups.csv #c:\users\matthewo\groups.csv
$user2 = read-host -prompt 'Enter the username: '
foreach($group in $groups) {add-adgroupmember -identity $group.name -members $user2}