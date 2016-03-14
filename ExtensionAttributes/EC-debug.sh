#!/bin/bash
# This script will simply display all lines matching "ECDebug" in /var/log/system.log

ECDebug=`/usr/bin/grep ECDebug /var/log/system.log`
if [ -n "${ECDebug}" ]; then
    echo "<result>${ECDebug}</result>"
else
    echo '<result>No Debug info for Enterprise Connect</result>'
fi
