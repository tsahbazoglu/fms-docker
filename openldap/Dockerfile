FROM ubuntu:20.04 as base

LABEL project="FMS OpenLdap"
LABEL maintainer "tsahbazoglu@tspb.org.tr"


# replace ubuntu archive
RUN apt-get -y install sed
#RUN sed -i 's/archive.ubuntu.com/us.archive.ubuntu.com/g' /etc/apt/sources.list

RUN useradd -ms /bin/bash fms

WORKDIR /home/fms

RUN mkdir -p /home/fms/Apps /home/fms/config
RUN chown fms:fms -R /home/fms

COPY ./init.sh  /home/fms/
COPY ./start.sh /home/fms/


ARG OLP="12345678"
ARG OLDT="tspb.org.tr"
ARG OLDE="dc=tspb,dc=org,dc=tr"

ENV OPENLDAP_PASSWORD=$OLP
ENV OPENLDAP_DOMAIN_DOT=$OLDT
ENV OPENLDAP_DOMAIN_EQ=$OLDE

RUN apt-get update && apt-get install -y --no-install-recommends debconf-utils && \
	echo 'slapd slapd/internal/generated_adminpw password' $OLP | debconf-set-selections && \
	echo 'slapd slapd/password2 password' $OLP | debconf-set-selections && \
	echo 'slapd slapd/internal/adminpw password' $OLP | debconf-set-selections && \
	echo 'slapd slapd/password1 password' $OLP | debconf-set-selections && \
	echo 'slapd slapd/domain string' $OLDT | debconf-set-selections && \
	echo 'slapd shared/organization string' $OLDT | debconf-set-selections && \
    apt-get install -y --no-install-recommends -y slapd && \
    apt-get install -y ldap-utils && \
    apt-get purge -y debconf-utils && \
    apt-get clean && \
chmod a+x /home/fms/start.sh && \
chmod a+x /home/fms/init.sh

RUN apt-get install -y iputils-ping && apt-get install -y net-tools

ENTRYPOINT ["/home/fms/start.sh"]


