#!/bin/bash

# start the spark worker 
$SPARK_HOME/sbin/start-slave.sh spark://spark-master:7077

# now do nothing and do not exit
while true; do sleep 3600; done
