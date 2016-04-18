#!/usr/bin/env python

# Copyright 2016 François 'ftiff' Levaux-Tiffreau
# 
# Set a list of certificate names you expect to have. 
# This script will output the list of certs that are missing.
# eg. <result>Missing certificate(s): [''MyDummyCert1]</result>

import subprocess

certificate_names = [
    'MyDummyCert1',
    'MyDummyCert2'
]

missing_certificates = []

for certificate in certificate_names:
    result = subprocess.call([
        'security',
        'find-certificate',
        '-c',
        certificate
        ], stdin=None, stdout=None, stderr=None)
    #print('{} -> {}'.format(certificate, result))
    if result != 0:
        missing_certificates.append(certificate)
        

if missing_certificates:
    print('<result>Missing certificate(s): {}</result>'.format(missing_certificates))
else:
    print('<result>Certificates: OK!</result>')
