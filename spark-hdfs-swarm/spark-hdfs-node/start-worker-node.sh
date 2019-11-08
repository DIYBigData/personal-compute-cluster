#!/bin/bash

# first start HDFS datanode

# check for existence of required volumes
if [ ! -d '/data/hdfs' ]; then
  echo "HDFS work directory not found: /data/hdfs"
  exit 2
fi

# start ssh server
service ssh start

# start the HDFS data node
echo "Sleeping to wait for namenode to start"
sleep 180
echo "Starting HDFS datanode"
su -c "$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR --daemon start datanode" hadoop

# check for existence of required volumes
if [ ! -d '/data/spark' ]; then
  echo "Spark work directory not found: /data/spark"
  exit 2
fi

# start the spark worker 
echo "starting Spark worker"
su -c "$SPARK_HOME/sbin/start-slave.sh spark://spark-master:7077" hadoop

# now do nothing and do not exit
while true; do sleep 3600; done
