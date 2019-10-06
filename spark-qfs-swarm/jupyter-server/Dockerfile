FROM qfs-master:latest

RUN apt-get install -y g++
RUN pip3 install jupyter
RUN mkdir -p /home/jupyter/runtime

COPY start-jupyter.sh /

CMD ["/bin/bash", "/start-jupyter.sh"]
