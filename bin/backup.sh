#!/bin/bash

# Add to the list under DIRS to create a new directory to back up.  The format
# is <drive>:<name>.  The tarsnap backup will be named <name>-YY-MM-DD.
# Set SSIDHOME to be the name of your home network so that backups only occur
# when you are connected to a known network.
DIRS="~/dropbox:dropbox 
~/.gdrive:gdrive"
SSIDHOME="1L7S1"



# Perform a back up on directories listed in $DIRS when on the $SSIDHOME network
# If archive already exists, abort.  Log output to $LOGFILE.
SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'
)
DATETODAY=$(date "+%Y-%m-%d")
LOGFILE=~/logs/backup.log

sleep 15

for dir in $DIRS
do
	LOC=$(echo $dir | cut -f 1 -d :)
	NAME=$(echo $dir | cut -f2 -d :)


	if [ $SSID == $SSIDHOME ]; then

		if [ $(tarsnap --list-archives | grep $NAME-$DATETODAY) ]; then
			echo $DATETODAY ":" $NAME "archive already exists." >> $LOGFILE
		else
			tarsnap -c -f $NAME-$DATETODAY $LOC
			if [ $? -eq 0 ]; then
				echo $DATETODAY ":" $NAME ": Backup successfully completed." >> $LOGFILE
			else
				echo $DATETODAY ":" $NAME ": Error uploading backup." >> $LOGFILE
			fi
		fi

	else
		echo $DATETODAY": Not on home network.  Aborting backup for today." >> $LOGFILE
	fi
done