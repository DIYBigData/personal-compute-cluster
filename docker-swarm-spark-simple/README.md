# Deploy Stand Alone Spark Cluster on Docker Swarm

This project brings up a simple Apache Spark stand alone cluster in a Docker swarm. It will also launch and make available a Jupyter PySpark notebook that is connected to the Spark cluster. The cluster has [`matplotlib`](https://matplotlib.org) and [`pandas`](https://pandas.pydata.org) preinstalled for your PySpark on Jupyter joys.

## Usage
First, edit the following items as needed for your swarm:

1. `configured-sparknode -> spark-conf -> spark-env.sh`: adjust the environment variables as appropriate for your cluster's nodes, most notably `SPARK_WORKER_MEMORY` and `SPARK_WORKER_CORES`. Leave 1-2 cores and at least 10% of RAM for other processes.
2. `configured-sparknode -> spark-conf -> spark-env.sh`: Adjust the memory and core settings for the executors and driver. Each executor should have about 5 cores (if possible), and should be a whole divisor into `SPARK_WORKER_CORES`. Spark will launch as many executors as `SPARK_WORKER_CORES` divided by `spark.executor.cores`. Reserve about 7-8% of `SPARK_WORKER_MEMORY` for overhead when setting `spark.executor.memory`.
3. `build-images.sh`: Adjust the IP address for your local Docker registry that all nodes in your cluster can access. You can use a domain name if all nodes in your swarm can resolve it. This is needed as it allows all nodes in the swarm to pull the locally built Docker images.
4. `spark-deploy.yml`: Adjust all image names for the updated local Docker registry address you used in the prior step. Also, adjust the resource limits for each of the services. Setting a `cpus` limit here that is smaller than the number of cores on your node has the effect of giving your process a fraction of each core's capacity. You might consider doing this if your swarm hosts other services or does not handle long term 100% CPU load well (e.g., overheats). Also adjust the `replicas` count for the `spark-worker` service to be equal to the number of nodes in your swarm (or less). 

This set up depends on have a GlusterFS volume mounted at `/mnt/gfs` on all nodes and the directories exist on it:

* `/mnt/gfs/jupyter-notbooks`
* `/mnt/gfs/data`

Then, to start up the Spark cluster in your Docker swarm, `cd` into this project's directory and:
```
./build-images.sh
docker stack deploy -c deploy-spark-swarm.yml spark
```

Point your development computer's browser at `http://swarm-public-ip:7777/` to load the Jupyter notebook.

## TODO
This cluster is a work in progress. Currently, the following items are missing:
* A distributed file system, such as HDFS or QFS. Currently there is no way to ingest data into the cluster except through network transfers, such as through `curl`, set up in a Jupyter notebook.

## Acknowledgements
The docker configuration leverages the [`gettyimages/spark`](https://hub.docker.com/r/gettyimages/spark/) Docker image as a starting point. 
