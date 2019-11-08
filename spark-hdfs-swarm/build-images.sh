#!/bin/bash

set -e

# default  software versions
BUILD_SPARK_VERSION=${BUILD_SPARK_VERSION:-"2.4.4"}
BUILD_HADOOP_VERSION=${BUILD_HADOOP_VERSION:="3.2.1"}

# build images
docker build \
	--build-arg HADOOP_VERSION=${BUILD_HADOOP_VERSION} \
	-t hadoop-node:${BUILD_HADOOP_VERSION} \
	./hadoop-node
docker tag hadoop-node:${BUILD_HADOOP_VERSION} hadoop-node:latest

docker build \
	--build-arg SPARK_VERSION=${BUILD_SPARK_VERSION} \
	-t spark-hdfs-node:latest \
	./spark-hdfs-node
docker build -t jupyter-node:latest ./jupyter-node


# tag image with local repository
docker tag hadoop-node:${BUILD_HADOOP_VERSION} \
	master:5000/hadoop-node:${BUILD_HADOOP_VERSION}
docker tag hadoop-node:latest master:5000/hadoop-node:latest
docker tag spark-hdfs-node:latest master:5000/spark-hdfs-node:latest
docker tag jupyter-node:latest master:5000/jupyter-node:latest

# push the images to local repository
docker push master:5000/hadoop-node:${BUILD_HADOOP_VERSION}
docker push master:5000/hadoop-node:latest
docker push master:5000/spark-hdfs-node:latest
docker push master:5000/jupyter-node:latest
