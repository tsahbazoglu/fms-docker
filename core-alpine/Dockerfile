FROM alpine:latest as base

RUN apk update

#ENV container openldap

LABEL project="FMS Core"
LABEL maintainer "tsahbazoglu@tspb.org.tr"

ARG ARG_BASE_DN="dc\=tspb,dc\=org,dc\=tr"
ENV BASE_DN="$ARG_BASE_DN"

RUN apk --no-cache add curl

# replace ubuntu archive
RUN apk add sed  
# RUN sed -i 's/archive.ubuntu.com/us.archive.ubuntu.com/g' /etc/apt/sources.list

# Prerequisites
RUN addgroup -S fms && adduser -S fms -G fms

RUN apk add unzip
#RUN apk add iputils-ping 
RUN apk add net-tools
RUN apk add nano


# setting locale
ENV MUSL_LOCALE_DEPS cmake make musl-dev gcc gettext-dev libintl 
ENV MUSL_LOCPATH /usr/share/i18n/locales/musl
RUN apk add --no-cache \
    $MUSL_LOCALE_DEPS \
    && wget https://gitlab.com/rilian-la-te/musl-locales/-/archive/master/musl-locales-master.zip \
    && unzip musl-locales-master.zip \
      && cd musl-locales-master \
      && cmake -DLOCALE_PROFILE=OFF -D CMAKE_INSTALL_PREFIX:PATH=/usr . && make && make install \
      && cd .. && rm -r musl-locales-master



#RUN locale-gen en_US.UTF-8

##RUN dpkg-reconfigure locales

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8


# InstallL OpenJDK 8
RUN apk fetch openjdk8
RUN apk add openjdk8

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

#ENTRYPOINT ["/home/fms/start.sh"]
