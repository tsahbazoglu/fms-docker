#!/usr/bin/env bash

NAME=tsahbazoglu/fms-core-alpine
TAG=latest

#remove
#docker container stop fmscore_$TAG
#docker container rm fmcore_$TAG
#docker image rm $NAME:$TAG

#build
docker build -t $NAME:$TAG .

#list
docker images

# Delete all containers : docker rm $(docker ps -a -q)
# Delete all images     : docker rmi $(docker images -q)


