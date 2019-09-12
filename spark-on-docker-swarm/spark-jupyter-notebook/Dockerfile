FROM configured-spark-node:latest

RUN apt-get install -y g++
RUN pip3 install jupyter
RUN mkdir -p /home/jupyter/runtime

COPY start-jupyter.sh /

#EXPOSE 7777
#EXPOSE 4040

CMD ["/bin/bash", "/start-jupyter.sh"]
