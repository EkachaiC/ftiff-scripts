include /usr/local/share/luggage/luggage.make
TITLE=AddCA-LDAP
PAYLOAD=pack-etc-openldap-ldap.conf \
pack-etc-openldap-certs-myCA.pem


pack-etc-openldap-ldap.conf: l_etc_openldap
	@sudo ${CP} ldap.conf ${WORK_D}/private/etc/openldap
	@sudo chown root:wheel ${WORK_D}/private/etc/openldap/ldap.conf
	@sudo chmod 644 ${WORK_D}/private/etc/openldap/ldap.conf

l_certs: l_etc_openldap
	@sudo mkdir ${WORK_D}/private/etc/openldap/certs
	@sudo chown root:wheel ${WORK_D}/private/etc/openldap/certs
	@sudo chmod 755 ${WORK_D}/private/etc/openldap/certs

pack-etc-openldap-certs-myCA.pem: l_certs
	@sudo ${CP} myCA.pem ${WORK_D}/private/etc/openldap/certs
	@sudo chown root:wheel ${WORK_D}/private/etc/openldap/certs/myCA.pem
	@sudo chmod 644 ${WORK_D}/private/etc/openldap/certs/myCA.pem
	@sudo ln ${WORK_D}/private/etc/openldap/certs/myCA.pem ${WORK_D}/private/etc/openldap/certs/"$(shell openssl x509 -hash -noout -in myCA.pem)".0

