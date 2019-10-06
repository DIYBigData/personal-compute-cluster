# the total amount of memory a worker (node) can use
SPARK_WORKER_MEMORY=52g

# the total amount of cores a worker (node) can use
SPARK_WORKER_CORES=12

# the number of worker processes per node
SPARK_WORKER_INSTANCES=1

# the ports the worker will advertise
SPARK_WORKER_PORT=8881
SPARK_WORKER_WEBUI_PORT=8081

# which python the spark cluster should use for pyspark
PYSPARK_PYTHON=python3 

# hash seed so all node hash numbers consistently
PYTHONHASHSEED=8675309

# the location of spark working files
SPARK_LOCAL_DIRS=/data/spark
