#!/bin/bash

SYSTEMLOG=`/usr/bin/tail -n 500 /var/log/system.log`
if [ -n "${SYSTEMLOG}" ]; then
    echo "<result>${SYSTEMLOG}</result>"
else
    echo '<result>Could not fetch system.log</result>'
fi
