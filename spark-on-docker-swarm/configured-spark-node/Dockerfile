FROM gettyimages/spark

# copy desired configuration to the spark conf
COPy ./spark-conf/* $SPARK_HOME/conf/

# same default command as the FROM image
CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]
