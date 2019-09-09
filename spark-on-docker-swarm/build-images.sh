#!/bin/bash

set -e

#build images
docker build -t configured-spark-node:latest ./configured-spark-node
docker build -t spark-jupyter-notebook:latest ./spark-jupyter-notebook

# tag image with local repository
docker tag configured-spark-node:latest 10.1.1.1:5000/configured-spark-node:latest
docker tag spark-jupyter-notebook:latest 10.1.1.1:5000/spark-jupyter-notebook:latest

# push the images to local repository
docker push 10.1.1.1:5000/configured-spark-node:latest
docker push 10.1.1.1:5000/spark-jupyter-notebook:latest
