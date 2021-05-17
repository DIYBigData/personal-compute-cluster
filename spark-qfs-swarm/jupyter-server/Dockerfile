FROM qfs-master:latest

#
# Expected volumes:
#   /home/spark/jupyter/notebooks - where the Jupyter notebooks will be persisted
#   /data/spark - Spark's data directory
#

ENV GRAPHFRAMES_VERSION 0.8.1-spark3.0-s_2.12

USER root
RUN apt-get install -y g++
RUN pip3 install \
        notebook==5.7.9 \
        jupyter_nbextensions_configurator \
        jupyter_contrib_nbextensions \
        yapf wget

COPY start-jupyter.sh /

USER spark
RUN jupyter contrib nbextension install --user
RUN jupyter nbextensions_configurator enable --user
RUN jupyter nbextension enable toc2/main
RUN jupyter nbextension enable codefolding/main
RUN jupyter nbextension enable execute_time/ExecuteTime

RUN mkdir -p /home/spark/jupyter/runtime \
 &&	mkdir -p /home/spark/jupyter/notebooks \
 &&	mkdir -p /home/spark/jars/

CMD ["/bin/bash", "/start-jupyter.sh"]
