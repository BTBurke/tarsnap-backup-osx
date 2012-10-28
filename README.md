tarsnap-backup-osx
==================

A shell script and launchd config file to run daily backups on specified directories and upload them to tarsnap.

To use:
* Get a (http://tarsnap.com)[tarsnap] account and set it up
* Make the backup.sh executable
* Change the value of the array:string in the org.btb.backup.plist file to the location of your executable
* Place org.btb.backup.plist in your ~/Library/LaunchAgents directory
* If you change the name of the plist file, make sure that Label:string in the file matches
* Edit the $DIRS variable in the shell script to specify what directories you want to back up.  The format is `<directory>:<name>`.  This means that it will back up directory `<directory>` and name the archive `<name>-YY-MM-DD`.

Other features:
* The shell script has a SSIDHOME variable that lets you set the SSID name of your home network and will exit out of the script if you're on any other network.
* Logs are written by default to ~/logs/backup.log

Issues:
* The script can have problems with directories that inclue a space such as "/Google Drive/".  To fix, I create a shadow directory that is a symlink to the real directory (e.g., .gdrive/ -> /Google Drive/).  You can do this with `ln -s ~/Google\ Drive/ .gdrive`