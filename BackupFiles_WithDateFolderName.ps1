#Author:  Brett Pynn
#Created: 01-15-2018
#Lang:  Powershell
#Purpose: Backup text files placed on server. (Change extension type for other file types)
#Details: Makes a backup of the files put on a server that needs to be labeled with a date.

#Customize the days to add to the folder name. Use (-) to remove days.
$DaysToAdd = -1
$FolderDate = Get-Date; $FolderDate=$FolderDate.AddDays($DaysToAdd); $FolderDate.ToString('yyyy-MM-dd')
$MAPPEDDRIVELETTER = "Z:\"

#Backup - Enter your drive location
$SOURCEFOLDER="<DRIVE:>\<Folder> OR \\<SERVER>\<FOLDER>"

#Choose to use the same machine as the source or a different destination.
#Uncomment and comment which destination you want.
$DESTBACKUPFOLDER=$MAPPEDDRIVELETTER+"<FOLDER>\"+$FolderDate.ToString('yyyy-MM-dd')
#$DESTBACKUPFOLDER="<DRIVE:>\<Folder> OR \\<SERVER>\<FOLDER>"+$FolderDate.ToString('yyyy-MM-dd')

net use $MAPPEDDRIVE $SOURCEFOLDER

New-Item -Path $SOURCEBACKUPFOLDER -ItemType directory -force
Copy-Item -Path $MAPPEDDRIVELETTER+"*.txt" -Destination $SOURCEBACKUPFOLDER -force -recurse -verbose

net use $MAPPEDDRIVE /delete
