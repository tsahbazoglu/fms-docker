FROM ubuntu:20.04 as base

#ENV container openldap

LABEL project="FMS Developer"
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
# RUN apt-get install openjdk-8-jdk -y
RUN apt-get -y install git
RUN apt-get -y install maven

# WOWRKDIR
WORKDIR /home/fms

# COPY
USER fms

WORKDIR /home/fms

USER fms

#ENTRYPOINT ["/home/fms/start.sh"]
