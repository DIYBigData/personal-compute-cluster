FROM gettyimages/spark

# add python libraries useful in PySpark
RUN python3 -mpip install matplotlib \
	&& pip3 install pandas

# copy desired configuration to the spark conf
COPY ./spark-conf/* $SPARK_HOME/conf/

# same default command as the FROM image
CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]
