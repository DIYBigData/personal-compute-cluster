#!/bin/bash

# start Spark master
$SPARK_HOME/sbin/start-master.sh

# now do nothing and do not exit
while true; do sleep 3600; done
