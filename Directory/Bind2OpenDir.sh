#!/bin/sh

# Script I use to bind a 10.7 client to Open Directory + SSL
# Use only on startup volume, in casper suite make sure to select "At Reboot"

# Define variables for path to executables
DSCONFIGLDAP="/usr/sbin/dsconfigldap"

# Define variables
ODM="nestor.esl.lan"
OSXVER=`sw_vers -productVersion`

# Check OSX Version
echo We will bind to $ODM

if [[ $OSXVER != "10.7"* ]];
	then 
		echo "This script only works in 10.7.x, please use built-in casper tools"
		exit;
	else
		echo We will bind to $ODM
		echo $DSCONFIGLDAP -vsemgx -a $ODM
		$DSCONFIGLDAP -vsemgx -a $ODM << EOF
		y
		EOF
		echo "Done !"
fi

# done ! :)
