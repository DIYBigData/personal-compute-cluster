FROM qfs-master:latest

#
# Expected volumes:
# 	/home/spark/jupyter/notebooks - where the Jupyter notebooks will be persisted
#   /data/spark - Spark's ata directory
#

USER root
RUN apt-get install -y g++
RUN pip3 install notebook==5.7.8 \
		jupyter_nbextensions_configurator \
		jupyter_contrib_nbextensions
COPY start-jupyter.sh /

USER spark
RUN jupyter contrib nbextension install --user
RUN jupyter nbextensions_configurator enable --user
RUN jupyter nbextension enable toc2/main
RUN jupyter nbextension enable codefolding/main
RUN jupyter nbextension enable execute_time/ExecuteTime

RUN mkdir -p /home/spark/jupyter/runtime \
 &&	mkdir -p /home/spark/jupyter/notebooks

CMD ["/bin/bash", "/start-jupyter.sh"]
