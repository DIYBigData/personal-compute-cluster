#!/bin/bash

# start Spark master
su -c "$SPARK_HOME/sbin/start-master.sh" hadoop

# now do nothing and do not exit
while true; do sleep 3600; done
