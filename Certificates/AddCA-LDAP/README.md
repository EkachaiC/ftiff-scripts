Author: Francois 'ftiff' TIFFREAU

- adds the root CA in /etc/openldap/certs/
- create a hard link to the SSL hash (to use CACERTDIR)
- modify /etc/openldap/ldap.conf to add the path

Useful in 10.5 and 10.6. 
For 10.7 please add certificate in system keychain (use AddCA-Keychain).

