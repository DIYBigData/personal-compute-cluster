FROM worker-node:latest

#
# Expected volumes:
#	/data/spark - this is the spark working directory
#
USER root
COPY start-spark-master.sh /

USER spark
CMD ["/bin/bash", "/start-spark-master.sh"]
