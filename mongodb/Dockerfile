FROM ubuntu:20.04 as base

#ENV container openldap

ARG MONGO_VERSION
#ARG MONGO_VERSION=3.6.2 

LABEL project="FMS MongoDB"
LABEL maintainer "tsahbazoglu@tspb.org.tr"

# replace ubuntu archive
RUN apt-get -y install sed
#RUN sed -i 's/archive.ubuntu.com/us.archive.ubuntu.com/g' /etc/apt/sources.list

# Prerequisites
RUN apt-get update
RUN useradd -ms /bin/bash fms
RUN apt-get -y install unzip
RUN apt-get install -y iputils-ping
RUN apt-get install -y net-tools
RUN apt-get install -y nano
RUN apt-get install -y libcurl4

RUN mkdir -p /home/fms/Apps /home/fms/demo /home/fms/tspbdb /home/fms/tdubdb /home/fms/fmsdb

COPY start.sh                  /home/fms
COPY init.sh                   /home/fms
COPY ${MONGO_VERSION}.tgz      /home/fms/Apps
COPY demo/init.sh              /home/fms/demo
COPY demo/admin.js             /home/fms/demo
COPY demo/properties.js        /home/fms/demo
COPY demo/projects.js          /home/fms/demo
COPY demo/ldapmatch.js         /home/fms/demo
COPY demo/ldapmatch.js         /home/fms/demo
COPY demo/init-basedb-user.js  /home/fms/demo

WORKDIR /home/fms/Apps

RUN tar xzvf ${MONGO_VERSION}.tgz && \
    rm -rf ${MONGO_VERSION}.tgz && \
    chown fms:fms -R /home/fms && \
    chmod u+x /home/fms/start.sh && \
    chmod u+x /home/fms/init.sh && \
    chmod u+x /home/fms/demo/init.sh

WORKDIR /home/fms

USER fms

ENV MONGODB_HOME="/home/fms/Apps/${MONGO_VERSION}"
ENV PATH="$PATH:$MONGODB_HOME/bin"

ENTRYPOINT ["/home/fms/start.sh"]
