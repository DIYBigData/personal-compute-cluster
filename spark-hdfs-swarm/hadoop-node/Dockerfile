FROM debian:stretch
MAINTAINER Michael Kamprath "https://github.com/michaelkamprath"
#
# Base image for a Hadoop install.
#
# Inspired by https://github.com/sciencepal/dockers/blob/master/hadoop_hive_spark_docker/hadoop/Dockerfile
#
# Expected volumes:
#	/data/hdfs - this is where HDFS will store its data. The host system should have the 
#				 following subdirectories: datanode, namenode, logs
#
#

USER root
EXPOSE 22
EXPOSE 9866
EXPOSE 9867
EXPOSE 34593

RUN apt-get update \
	&& apt-get install -y \
		curl unzip procps \
		ssh openssl pdsh \
		less vim net-tools \
		openssh-server openssh-client \
		openjdk-8-jdk \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash hadoop

# set pubkey authentication so Hadoop name node can communicate with data nodes
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/ssh_config
RUN mkdir -p /home/hadoop/.ssh
RUN echo "PubkeyAcceptedKeyTypes +ssh-dss" >> /home/hadoop/.ssh/config \
		&& echo "PasswordAuthentication no" >> /home/hadoop/.ssh/config \
		&& echo "StrictHostKeyChecking no" >> /home/hadoop/.ssh/config \
		&& echo "UserKnownHostsFile /dev/null" >> /home/hadoop/.ssh/config \
		&& echo "LogLevel QUIET" >> /home/hadoop/.ssh/config

# make and copy keys
RUN ssh-keygen -q -t rsa -N '' -f /home/hadoop/.ssh/id_rsa
RUN cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys
RUN chown hadoop -R /home/hadoop/.ssh

# Hadoop Environment
RUN mkdir -p /data/hdfs/
RUN chown hadoop -R /data/hdfs/
ARG HADOOP_VERSION=3.2.1
ENV HADOOP_HOME /usr/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR $HADOOP_HOME/etc/hadoop/
ENV PATH $PATH:$HADOOP_HOME/bin
RUN curl -sL --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
  | gunzip \
  | tar -x -C /usr/ \
 && rm -rf $HADOOP_HOME/share/doc \
 && chown -R root:root $HADOOP_HOME
COPY ./hadoop-conf/* $HADOOP_CONF_DIR
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

COPY start-hdfs-*.sh /

WORKDIR /home/hadoop

CMD ["/bin/bash", "/start-hdfs-datanode.sh"]
