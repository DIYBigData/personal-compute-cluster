FROM spark-hdfs-node:latest

RUN apt-get install -y g++
RUN pip3 install jupyter
RUN mkdir -p /home/jupyter/runtime
RUN mkdir -p /home/jupyter/notebooks
RUN chown hadoop -R /home/jupyter/

RUN mkdir -p /gfs/data
RUN chown hadoop -R /gfs/data

COPY start-jupyter.sh /

USER hadoop 

CMD ["/bin/bash", "/start-jupyter.sh"]
