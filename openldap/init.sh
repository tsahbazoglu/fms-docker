#!/usr/bin/env bash

# FMS Domain
echo $OPENLDAP_DOMAIN_EQ

# Base Content 
cat > add_content.ldif << EOL
dn: ou=Users,$OPENLDAP_DOMAIN_EQ
objectClass: organizationalUnit
ou: Users

dn: ou=Roles,$OPENLDAP_DOMAIN_EQ
objectClass: organizationalUnit
ou: Roles
EOL

# Roles
cat > add_role.ldif << EOL
dn: cn=admin,ou=Roles,$OPENLDAP_DOMAIN_EQ
cn: admin
uniqueMember: uid=admin,ou=Users,$OPENLDAP_DOMAIN_EQ
objectClass: groupOfUniqueNames
objectClass: top
EOL

# Users
cat > add_user.ldif << EOL
dn: uid=admin,ou=Users,$OPENLDAP_DOMAIN_EQ
cn: "Admin"
sn: "Admin"
givenName: "Admin Admin"
objectClass: top
objectClass: person
objectClass: inetOrgPerson
userPassword: 123
EOL

# restart OpenLdap
service slapd restart

# import base content, role and user
ldapadd -x -D cn=admin,$OPENLDAP_DOMAIN_EQ -w $OPENLDAP_PASSWORD -f add_content.ldif
ldapadd -x -D cn=admin,$OPENLDAP_DOMAIN_EQ -w $OPENLDAP_PASSWORD -f add_role.ldif
ldapadd -x -D cn=admin,$OPENLDAP_DOMAIN_EQ -w $OPENLDAP_PASSWORD -f add_user.ldif

# check
ldapsearch -x -LLL -H ldap:/// -b $OPENLDAP_DOMAIN_EQ dn

