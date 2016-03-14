#!/bin/bash

########################################################################
# Originally Created Created By: Andrina Kelly
# Modifications from scripts from Bryson Tyrrell 
# Final by Ross Derewianko
# Creation Date: April 2015
# Last modified: Feb 16,2016
# Brief Description: Gather diagnostic logs and submit to the JSS
########################################################################
# CHECK TO SEE IF A VALUE WAS PASSED IN PARAMETER 4 AND, IF SO, ASSIGN TO "basic_auth"
if [ "$4" != "" ] && [ "$basic_auth" == "" ]; then
  basic_auth=$4
fi

jss=`defaults read /Library/Preferences/com.jamfsoftware.jamf.plist jss_url`
serial=`/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial Number/ {print $NF}'`
LOGDATE=$(date +%Y%m%dT%H%M%S)
currentuser=`ls -l /dev/console | cut -d " " -f 4`

#find the machines ID
fullmachineinfo=$(curl "$jss"JSSResource/computers/serialnumber/"$serial" -H "Authorization: Basic $basic_auth")
machineid=$(echo $fullmachineinfo | /usr/bin/awk -F'<id>|</id>' '{print $2}'| sed 's/ /+/g')

echo $machineid
function get_ssl {
	(/bin/echo "GET /"; /bin/sleep 10) | /usr/bin/openssl s_client -connect ${1}:443 -showcerts -prexit &> /var/tmp/DSSL_openssl_debug_${2}_${currentuser}_${LOGDATE}.log
}

function curl_noproxy {
	/usr/bin/curl -ivs https://${1}/ &> /var/tmp/DSSL_curl_noproxy_${2}_${currentuser}_${LOGDATE}.log
}

function curl_proxy {
	/usr/bin/curl -ivs https://${1}/ -x "http://proxy.pac" &> /var/tmp/DSSL_curl_proxy_${2}_${currentuser}_${LOGDATE}.log
}

function debug_ssl {
	get_ssl "${1}"  "${2}"
	curl_noproxy "${1}" "${2}"
	curl_proxy "${1}" "${2}"
}

debug_ssl "mail.google.com" "gmail"
debug_ssl "www.facebook.com" "facebook"

/usr/bin/tar -czf /var/tmp/DSSLZ_${currentuser}_${LOGDATE}.tgz /var/tmp/DSSL*
rm /var/tmp/DSSL_*
FILE=$(ls -ltr /var/tmp | tail -1 | awk '{print $9}' | grep "DSSLZ")


fileupload=$(curl -X "POST" "$jss"JSSResource/fileuploads/computers/id/$machineid -F "file=@/var/tmp/$FILE"\
  -H "Authorization: Basic $basic_auth")

exit 0
