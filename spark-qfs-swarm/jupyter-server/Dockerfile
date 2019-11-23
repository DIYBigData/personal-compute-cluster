FROM qfs-master:latest

#
# Expected volumes:
# 	/home/spark/jupyter/notebooks - where the Jupyter notebooks will be persisted
#   /data/spark - Spark's ata directory
#

USER root
RUN apt-get install -y g++
RUN pip3 install jupyter
COPY start-jupyter.sh /

USER spark
RUN mkdir -p /home/spark/jupyter/runtime \
 &&	mkdir -p /home/spark/jupyter/notebooks

CMD ["/bin/bash", "/start-jupyter.sh"]
