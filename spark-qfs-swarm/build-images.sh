#!/bin/bash

set -e

DOCKER_BUILD_ARGS=

while getopts b: option
do
case "${option}"
in
b) DOCKER_BUILD_ARGS=${OPTARG};;
esac
done

if [ -z "$DOCKER_ARGS" ]
then
	echo "Building with default docker options"
else
	echo "Building with docker arguments = '$DOCKER_BUILD_ARGS'"
fi

# build images
docker build -t worker-node:latest $DOCKER_BUILD_ARGS ./worker-node
docker build -t qfs-master:latest $DOCKER_BUILD_ARGS ./qfs-master
docker build -t spark-master:latest $DOCKER_BUILD_ARGS ./spark-master
docker build -t jupyter-server:latest $DOCKER_BUILD_ARGS ./jupyter-server

# tag image with local repository
docker tag worker-node:latest master:5000/worker-node:latest
docker tag qfs-master:latest master:5000/qfs-master:latest
docker tag spark-master:latest master:5000/spark-master:latest
docker tag jupyter-server:latest master:5000/jupyter-server:latest

# push the images to local repository
docker push master:5000/worker-node:latest
docker push master:5000/qfs-master:latest
docker push master:5000/spark-master:latest
docker push master:5000/jupyter-server:latest
