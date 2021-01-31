#!/bin/sh

echo -e  "---------------------------------------------------------------------------------------------- Start"
asadmin start-domain production

echo -e  "---------------------------------------------------------------------------------------------- JNDI Custom Resources"
echo -e  "---------------------------------------------------------------- fms/environments"
asadmin delete-custom-resource fms/environment --user admin
asadmin create-custom-resource \
--user admin \
--restype java.lang.String \
--factoryclass org.glassfish.resources.custom.factory.PrimitivesAndStringFactory \
--property value=PRODUCT \
fms/environment

echo -e  "---------------------------------------------------------------- fms/mongoadmin"
asadmin delete-custom-resource fms/mongoadmin --user admin
asadmin create-custom-resource \
--user admin \
--restype java.lang.String \
--factoryclass org.glassfish.resources.custom.factory.PrimitivesAndStringFactory \
--property value=12345678 \
fms/mongoadmin

echo -e  "---------------------------------------------------------------- fms/mongourl"
# mongodb domain will be resolved by docker
# outside of docker it should be set to other domainname or ip
asadmin delete-custom-resource fms/mongourl --user admin
asadmin create-custom-resource \
--user admin \
--restype java.lang.String \
--factoryclass org.glassfish.resources.custom.factory.PrimitivesAndStringFactory \
--property value=mongodb \
fms/mongourl

echo -e  "---------------------------------------------------------------------------------------------- JMS Resources"
echo -e  "----------------------------------------------------------------- jms/emailQueuejms/emailQueue"
asadmin delete-jms-resource jms/fmsEmailQueue;
asadmin create-jms-resource \
--user admin --restype javax.jms.Queue \
--description "FMS Email Queue" \
--property Name=fmsEmailQueue \
jms/fmsEmailQueue;

echo -e  "---------------------------------------------------------------------------------------------- Connection Factories"
echo -e  "----------------------------------------------------------------- jms/fmsEmailQueueConnectionFactory"
asadmin delete-jms-resource jms/fmsEmailQueueConnectionFactory
asadmin create-jms-resource \
--restype javax.jms.QueueConnectionFactory \
--description "FMS Email Queue Connection Factory" \
jms/fmsEmailQueueConnectionFactory

echo -e  "---------------------------------------------------------------- ldap/openldap"
# openldap domain will be resolved by docker
# outside of docker it should be set to other domainname or ip
asadmin delete-custom-resource ldap/openldap
asadmin create-custom-resource \
--user admin \
--restype javax.naming.directory.Directory \
--factoryclass com.sun.jndi.ldap.LdapCtxFactory \
--property \
java.naming.security.credentials=test:\
java.naming.security.principal="cn\=admin":\
URL="ldap\://openldap\:389" \
ldap/openldap

echo -e  "---------------------------------------------------------------------------------------------- Realm"
# openldap domain will be resolved by docker
# outside of docker it should be set to other domainname or ip
asadmin delete-auth-realm OpenLdap;
asadmin create-auth-realm \
--user admin \
--classname com.sun.enterprise.security.auth.realm.ldap.LDAPRealm \
--property \
jaas-context=ldapRealm:\
directory="ldap\://openldap\:389":\
base-dn=$BASE_DN:\
assign-groups="ou\=Roles,$BASE_DN" \
OpenLdap;

echo -e  "---------------------------------------------------------------------------------------------- Java Mail Session"
echo -e  "----------------------------------------------------------------- mail/fmsInternal"
asadmin delete-javamail-resource --user admin mail/fmsInternal
asadmin create-javamail-resource \
--user admin \
--mailhost 0.0.0.0 \
--mailuser fms@tspb.org.tr \
--fromaddress fms@tspb.org.tr \
--storeprotocol POP3 \
--storeprotocolclass com.sun.mail.pop3.POP3Store \
--property \
mail.smtp.connectiontimeout=10000:\
mail.smtp.timeout=10000:\
mail.smtp.port=25 \
mail/fmsInternal;

echo -e  "----------------------------------------------------------------- mail/fmsExternal"
asadmin delete-javamail-resource --user admin mail/fmsExternal
asadmin create-javamail-resource \
--user admin \
--mailhost 0.0.0.0 \
--mailuser fms@tspb.org.tr \
--fromaddress fms@tspb.org.tr \
--storeprotocol POP3 \
--storeprotocolclass com.sun.mail.pop3.POP3Store \
--property \
mail.smtp.connectiontimeout=10000:\
mail.smtp.timeout=10000:\
mail.smtp.port=25 \
mail/fmsExternal;

echo -e  "---------------------------------------------------------------------------------------------- Stop"
asadmin stop-domain production

