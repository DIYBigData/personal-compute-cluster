FROM worker-node:latest

#
# Expected volumes:
#	/data/spark - this is the spark working directory
#

COPY start-spark-master.sh /
CMD ["/bin/bash", "/start-spark-master.sh"]
