FROM debian:stretch
MAINTAINER Michael Kamprath "https://github.com/michaelkamprath"
#
# Base image for Apace Spak standalone cluster with QFS 
#
# Inspired by https://hub.docker.com/r/gettyimages/spark/dockerfile
#
#
# Expected volumes:
#	/data/qfs - this is where QFS will store its data
#	/data/spark - this is the spark working directory
#
# Expected service names:
#	qfs-master - the service where the QFS metaserver runs
#	spark-master - the service where the spark master runs
#

RUN apt-get update \
 && apt-get install -y locales \
 && dpkg-reconfigure -f noninteractive locales \
 && locale-gen C.UTF-8 \
 && /usr/sbin/update-locale LANG=C.UTF-8 \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update \
 && apt-get install -y curl unzip procps \
    python3 python3-setuptools \
    libboost-regex-dev \
 && ln -s /usr/bin/python3 /usr/bin/python \
 && easy_install3 pip py4j \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# add python libraries useful in PySpark
RUN python3 -mpip install matplotlib \
	&& pip3 install pandas

ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# JAVA
RUN apt-get update \
 && apt-get install -y openjdk-8-jre \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# create the user software will run from
RUN useradd -m -s /bin/bash spark

# QFS
ENV QFS_VERSION 2.1.3
ENV HADOOP_VERSION 2.7.2
ENV QFS_PACKAGE qfs-debian-9-${QFS_VERSION}-x86_64
ENV QFS_HOME /usr/qfs-${QFS_VERSION}
ENV QFS_LOGS_DIR /data/qfs/logs
ENV LD_LIBRARY_PATH ${QFS_HOME}/lib
RUN curl -sL --retry 3 \
	"https://s3.amazonaws.com/quantcast-qfs/qfs-debian-9-${QFS_VERSION}-x86_64.tgz" \
	| gunzip \
	| tar x -C /usr/ \
	&& mv /usr/$QFS_PACKAGE $QFS_HOME \
	&& chown -R root:root $QFS_HOME
COPY ./qfs-conf/* $QFS_HOME/conf/
ENV PATH $PATH:${QFS_HOME}/bin:${QFS_HOME}/bin/tools
RUN mkdir -p /data/qfs/ \
 && chown spark -R /data/qfs

# SPARK
ENV SPARK_VERSION 2.4.4
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-hadoop2.7
ENV SPARK_HOME /usr/spark-${SPARK_VERSION}
ENV SPARK_DIST_CLASSPATH="$QFS_HOME/lib/hadoop-$HADOOP_VERSION-qfs-$QFS_VERSION.jar:$QFS_HOME/lib/qfs-access-$QFS_VERSION"
ENV HADOOP_CONF_DIR=${SPARK_HOME}/conf/
ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -sL --retry 3 \
  "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
 && mv /usr/$SPARK_PACKAGE $SPARK_HOME \
 && chown -R root:root $SPARK_HOME
COPY ./spark-conf/* $SPARK_HOME/conf/
RUN mkdir -p /data/spark \
 && chown spark -R /data/spark

# set up command
COPY start-worker-node.sh /
USER spark
WORKDIR /home/spark
CMD ["/bin/bash", "/start-worker-node.sh"]
