#!/bin/bash

# check for existence of required volumes
if [ ! -d '/data/hdfs' ]; then
  echo "HDFS work directory not found: /data/hdfs"
  exit 2
fi

# HACK ALERT
# For what ever reason, Docker does not resolve the service name for this serice until
# a little bit after it is launch. I assume it takes some time for a launched service 
# to show up in the Docker Swarm VIP resolver. Since the HDFS namenode needs to 
# resolve its own service name almost immediately upon startup, we need to wait a little
# while until Docker has entered this service's name into its VIP resolver.
#
# If you know of a better way to handle this issue, pull requests are welcome!
echo "Sleeping namenode until Docker registers service ..."
sleep 180

# start the name node
echo "Launching HDFS namenode."
su -c "$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR --daemon start namenode" hadoop

# now do nothing and do not exit
echo "Maintaining container persistence."
while true; do sleep 3600; done
