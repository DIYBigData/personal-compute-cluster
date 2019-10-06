#!/bin/bash

# start the QFS chunk server
$QFS_HOME/bin/chunkserver $QFS_HOME/conf/Chunkserver.prp &> $QFS_LOGS_DIR/chunkserver.log &

# start the spark worker 
$SPARK_HOME/sbin/start-slave.sh spark://spark-master:7077

# now do nothing and do not exit
while true; do sleep 3600; done
