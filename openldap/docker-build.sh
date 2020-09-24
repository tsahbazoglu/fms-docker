#!/usr/bin/env bash

NAME=tsahbazoglu/openldap
TAG=latest

#remove
#docker container stop openldap_$TAG
#docker container rm openldap_$TAG
#docker image rm $NAME:$TAG

#build
docker build -t $NAME:$TAG .

#list
docker images

# Delete all containers : docker rm $(docker ps -a -q)
# Delete all images     : docker rmi $(docker images -q)





