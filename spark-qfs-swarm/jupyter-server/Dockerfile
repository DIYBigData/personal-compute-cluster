FROM qfs-master:latest

#
# Expected volumes:
#   /home/spark/jupyter/notebooks - where the Jupyter notebooks will be persisted
#   /data/spark - Spark's data directory
#

ENV GRAPHFRAMES_VERSION 0.8.3-spark3.5-s_2.12
ENV SPARK_NLP_VERSION spark-nlp-spark32_2.12:3.4.4

USER root
RUN apt-get install -y g++
RUN pip3 install \
        notebook \
        yapf wget jupyter_server \
	ipywidgets

COPY start-jupyter.sh /

USER spark
RUN mkdir -p /home/spark/jupyter/runtime \
 &&	mkdir -p /home/spark/jupyter/notebooks \
 &&	mkdir -p /home/spark/jars/

CMD ["/bin/bash", "/start-jupyter.sh"]
