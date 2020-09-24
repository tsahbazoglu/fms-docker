FROM ubuntu:19.10 as base

#ENV container openldap

LABEL project="FMS Core"
LABEL maintainer "tsahbazoglu@tspb.org.tr"

ARG ARG_BASE_DN="dc\=tspb,dc\=org,dc\=tr"
ENV BASE_DN="$ARG_BASE_DN"

# replace ubuntu archive
RUN apt-get -y install sed  
# RUN sed -i 's/archive.ubuntu.com/us.archive.ubuntu.com/g' /etc/apt/sources.list

# Prerequisites
RUN apt-get update
RUN useradd -ms /bin/bash fms
RUN apt-get -y install unzip
RUN apt-get -y install iputils-ping 
RUN apt-get -y install net-tools
RUN apt-get -y install nano


# setting locale
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8

##RUN dpkg-reconfigure locales

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8


# InstallL OpenJDK 8
RUN apt-get install openjdk-8-jdk -y

# WOWRKDIR
WORKDIR /home/fms

# COPY
USER fms

RUN mkdir -p /tmp/muhurdar
RUN mkdir -p /tmp/uys/tobesigned
RUN mkdir -p /tmp/uys/esigned
RUN mkdir -p /home/fms/Apps
RUN mkdir -p /home/fms/download
RUN mkdir -p /home/fms/export

COPY payara.zip               /home/fms/Apps
COPY uys-ear-3.2-SNAPSHOT.ear /home/fms
COPY start.sh                 /home/fms
COPY restart.sh               /home/fms
COPY restart-debug.sh         /home/fms
COPY config.sh                /home/fms
COPY deploy.sh                /home/fms
COPY log.sh                   /home/fms

WORKDIR /home/fms/Apps

RUN unzip payara.zip && \
    rm -rf payara.zip && \
    mv payara* payara

USER root

RUN chown fms:fms -R /home/fms/start.sh && \
    chown fms:fms -R /home/fms/restart.sh && \
    chown fms:fms -R /home/fms/restart-debug.sh && \
    chown fms:fms -R /home/fms/config.sh && \
    chown fms:fms -R /home/fms/deploy.sh && \
    chown fms:fms -R /home/fms/log.sh

RUN chmod a+x /home/fms/start.sh && \
    chmod a+x /home/fms/restart.sh && \
    chmod a+x /home/fms/restart-debug.sh && \
    chmod a+x /home/fms/config.sh && \
    chmod a+x /home/fms/deploy.sh && \
    chmod a+x /home/fms/log.sh

WORKDIR /home/fms

USER fms

ENV SERVER_HOME="/home/fms/Apps/payara"
ENV PATH="$PATH:$SERVER_HOME/bin"

ENTRYPOINT ["/home/fms/start.sh"]
