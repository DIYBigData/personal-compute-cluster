FROM worker-node:latest

#
# Expected volumes:
#	/data/qfs - this is where QFS will store its data
#
# Instance should run on the swam's master node so as to persist configuration
#

# need python 2 for webserver

RUN apt-get update \
 && apt-get install -y python2.7 less wget vim \
 && ln -s /usr/bin/python2.7 /usr/bin/python2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# set configuration
COPY ./qfs-conf/* $QFS_HOME/conf/

# create some useful bash aliases for when at bash shell prompt of this image
RUN echo 'export PATH=$PATH:$QFS_HOME/bin/:$QFS_HOME/bin/tools/' >> ~/.bashrc \
 && echo 'alias qfs="qfs -fs qfs://qfs-master:20000"' >> ~/.bashrc \
 && echo 'alias cptoqfs="cptoqfs -s qfs-master -p 20000"' >> ~/.bashrc \
 && echo 'alias cpfromqfs="cpfromqfs -s qfs-master -p 20000"' >> ~/.bashrc \
 && echo 'alias qfsshell="qfsshell -s qfs-master -p 20000"' >> ~/.bashrc

COPY start-qfs-master.sh /
CMD ["/bin/bash", "/start-qfs-master.sh"]
