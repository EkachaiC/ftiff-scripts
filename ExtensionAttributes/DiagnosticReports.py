#!/usr/bin/env python

# Copyright 2016 François 'ftiff' Levaux-Tiffreau
# 
# Show the list of Diagnostic Reports in /Library/Logs/DiagnosticReports, ordered by number of crash files. 
#
# Example:
#<result>
#  74: com.apple.Enterprise-Connect.kerbHelper
#  22: awdd
#  20: powerstats
#   6: com.apple.WebKit.WebContent
#   2: storedownloadd
#   2: kcm
#   2: Hopper Disassembler v3
#   1: java
#   1: GIMP-bin
#   1: Google Chrome
#   1: installd
#   1: ntpd
#</result>

import os
import string

all_processes = {}
diagnostic_reports = os.listdir('/Library/Logs/DiagnosticReports/')

for dr in diagnostic_reports:
    process = string.split(dr, '_')[0]
    #print(process[0])
    if process in all_processes:
        all_processes[process] += 1
    else:
        all_processes[process] = 1


if all_processes:
    print('<result>')
    for (process) in sorted(all_processes, key=all_processes.__getitem__, reverse=True):
        print('{:4}: {}'.format(all_processes[process], process))
    print('</result>')
else:
    print('<result>No Diagnostic Report.</result>')
