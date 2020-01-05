# Deploy Standalone Spark Cluster with QFS on Docker Swarm
This project deploys a standalone Spark Cluster onto a Docker Swarm. Includes the [Quantcast File System](https://github.com/quantcast/qfs) (QFS) as the clusters distributed file system. Why QFS? Why not. This configuration will also launch and make available a Jupyter PySpark notebook that is connected to the Spark cluster. The cluster has [`matplotlib`](https://matplotlib.org) and [`pandas`](https://pandas.pydata.org) preinstalled for your PySpark on Jupyter joys.

## Usage
First, edit the following items as needed for your swarm:

1. `worker-node -> spark-conf -> spark-env.sh`: adjust the environment variables as appropriate for your cluster's nodes, most notably `SPARK_WORKER_MEMORY` and `SPARK_WORKER_CORES`. Leave 1-2 cores and at least 10% of RAM for other processes.
2. `worker-node -> spark-conf -> spark-env.sh`: Adjust the memory and core settings for the executors and driver. Each executor should have about 5 cores (if possible), and should be a whole divisor into `SPARK_WORKER_CORES`. Spark will launch as many executors as `SPARK_WORKER_CORES` divided by `spark.executor.cores`. Reserve about 7-8% of `SPARK_WORKER_MEMORY` for overhead when setting `spark.executor.memory`.
3. `build-images.sh`: Adjust the IP address for your local Docker registry that all nodes in your cluster can access. You can use a domain name if all nodes in your swarm can resolve it. This is needed as it allows all nodes in the swarm to pull the locally built Docker images.
4. `deploy-spark-qfs-swarm.yml`: Adjust all image names for the updated local Docker registry address you used in the prior step. Also, adjust the resource limits for each of the services. Setting a `cpus` limit here that is smaller than the number of cores on your node has the effect of giving your process a fraction of each core's capacity. You might consider doing this if your swarm hosts other services or does not handle long term 100% CPU load well (e.g., overheats). 

This set up depends on have a GlusterFS volume mounted at `/mnt/gfs` and a normal file system (such as XFS) at `/mnt/data` on all nodes and the following directories exist on it:

* `/mnt/gfs/jupyter-notbooks` - used to persist the Jupyter notebooks. 
* `/mnt/gfs/data` - a location to transitionally store data that is accessible from the Jupyter server
* `/mnt/data/qfs/logs` - where QFS will store it's logs
* `/mnt/data/qfs/chunk` - Where the chunk servers of QFS will store the data
* `/mnt/data/qfs/checkpoint` - Where the QFS metaserver will store the fulesystem check points. This actually only needs to exist on the master node.
* `/mnt/data/spark` - The local working directory for spark

You can adjust these as you see fit, but be sure to update the mounts specified in `deploy-spark-qfs-swarm.yml`. 

Before the first time you run this cluster, you will need to initialize the QFS file system. Do so by launching a qfs-master container on the master node:
```
docker run -it -u spark --mount type=bind,source=/mnt/data/qfs,target=/data/qfs master:5000/qfs-master:latest /bin/bash
```
Then at the shell prompt in this container, run the following to initialize QFS and create the directory for Spark history server:
```
$QFS_HOME/bin/metaserver -c $QFS_HOME/conf/Metaserver.prp
qfs -mkdir /history/spark-event
exit
```

Finally, to start up the Spark cluster in your Docker swarm, `cd` into this project's directory and:
```
./build-images.sh
docker stack deploy -c deploy-spark-qfs-swarm.yml spark
```

Point your development computer's browser at `http://swarm-public-ip:7777/` to load the Jupyter notebook.

### Working with QFS
To launch a Docker container to give you command line access to QFS, use the following command:
```
docker run -it --network="spark_cluster_network" -u spark master:5000/qfs-master:latest /bin/bash
```
Note that you must attach to the network on which the Docker spark cluster services are using. From this command prompt, the following commands are pre-configured to connect to the QFS instance:

* `qfs` - enables most linux-style file operations on the QFS instance.
* `cptoqfs` - Copies files from the local file system (in the Docker container) to the QFS instance.
* `cpfromqfs` - Copies files from the QFS instance to the local file system (in the Docker container)
* `qfsshell` - A useful shell-style interface to the QFS instance
* `qfsfsck` - Perform `fsck` on the QFS file system

You might consider adding a volume mount to the `docker run` command so that the Docker container can access data from you local file system.
