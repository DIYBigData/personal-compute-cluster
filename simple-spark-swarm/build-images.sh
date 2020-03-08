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
docker build -t simple-spark-cluster-node:latest $DOCKER_BUILD_ARGS ./simple-spark-cluster-node
docker build -t simple-spark-cluster-jupyter:latest $DOCKER_BUILD_ARGS ./simple-spark-cluster-jupyter

# tag image with local repository
docker tag simple-spark-cluster-node:latest master:5000/simple-spark-cluster-node:latest
docker tag simple-spark-cluster-jupyter:latest master:5000/simple-spark-cluster-jupyter:latest

# push the images to local repository
docker push master:5000/simple-spark-cluster-node:latest
docker push master:5000/simple-spark-cluster-jupyter:latest
