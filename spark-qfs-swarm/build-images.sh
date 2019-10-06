#!/bin/bash

set -e

# build images
docker build -t worker-node:latest ./worker-node
docker build -t qfs-master:latest ./qfs-master
docker build -t spark-master:latest ./spark-master
docker build -t jupyter-server:latest ./jupyter-server

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
