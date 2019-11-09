FROM hadoop-node:latest
MAINTAINER Michael Kamprath "https://github.com/michaelkamprath"
#
# Base image for Apace Spak standalone cluster with HDFS 
#
# Expected volumes:
#	/data/hdfs - this is where HDFS will store its data
#	/data/spark - this is the spark working directory
#
# Expected service names:
#	namenode - the service where the hdfs name node runs
#	spark-master - the service where the spark master runs
#

RUN apt-get update \
 && apt-get install -y locales \
    python3 python3-setuptools \
 && dpkg-reconfigure -f noninteractive locales \
 && locale-gen C.UTF-8 \
 && /usr/sbin/update-locale LANG=C.UTF-8 \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen \
 && ln -s /usr/bin/python3 /usr/bin/python \
 && easy_install3 pip py4j \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# add python libraries useful in PySpark
RUN python3 -mpip install matplotlib \
	&& pip3 install pandas

# SPARK
RUN mkdir -p /data/spark/
RUN chown hadoop -R /data/spark/
ARG SPARK_VERSION=2.4.4
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-without-hadoop
ENV SPARK_HOME /usr/spark-${SPARK_VERSION}
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -sL --retry 3 \
  "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
 && mv /usr/$SPARK_PACKAGE $SPARK_HOME \
 && chown -R root:root $SPARK_HOME
COPY ./spark-conf/* $SPARK_HOME/conf/

# set up command
COPY start-worker-node.sh /
COPY start-spark-master.sh /

CMD ["/bin/bash", "/start-worker-node.sh"]
