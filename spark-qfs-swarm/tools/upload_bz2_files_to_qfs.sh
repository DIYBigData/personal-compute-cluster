#!/bin/bash

#
# Usage:
#   ./upload_bz2_files_to_qfa.sh /local/path/to/source_dir /path/oth/qfs/destination_dir
#
# Will create docker container using the qfs-master image and connectiong to
# the spark_cluster_network swarm network.
#

source_dir=${1%/}

echo "Uploading files from $source_dir locally to $2 on QFS."
docker run -it \
    --network spark_cluster_network \
    --mount type=bind,src=$source_dir,dst=/data \
    --env DESTINATION_DIR=$2 \
    qfs-master:latest \
    /bin/bash -c \
    'qfs -fs qfs://qfs-master:20000 -mkdir $DESTINATION_DIR; for filename in /data/*.bz2; do echo "uploading - ${filename} to $DESTINATION_DIR"; ( cptoqfs -s qfs-master -p 20000 -d "${filename}" -k $DESTINATION_DIR -r 2 ); done; echo "Finished uploading files."'
