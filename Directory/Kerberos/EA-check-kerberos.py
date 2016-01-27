#!/usr/bin/env python

import json
import subprocess

klist_output = subprocess.check_output(['klist', '--json'])

try:
    result = json.loads(klist_output)['principal']
    print '<result>' + result + '</result>'
except KeyError:
    print '<result>No Principal</result>'
    
