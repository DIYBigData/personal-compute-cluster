# the total amount of memory a worker (node) can use
export SPARK_WORKER_MEMORY=52g

# the total amount of cores a worker (node) can use
export SPARK_WORKER_CORES=12

# the number of worker processes per node
export SPARK_WORKER_INSTANCES=1

# the ports the worker will advertise
export SPARK_WORKER_PORT=8881
export SPARK_WORKER_WEBUI_PORT=8081

# which python the spark cluster should use for pyspark
export PYSPARK_PYTHON=python3 

# hash seed so all node hash numbers consistently
export PYTHONHASHSEED=8675309

# the location of spark working files
export SPARK_LOCAL_DIRS=/data/spark/tmp
export SPARK_WORKER_DIR=/data/spark/work


export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:$HADOOP_HOME/etc/hadoop/}
