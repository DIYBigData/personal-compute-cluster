#!/bin/bash

SHELL=/bin/bash XDG_RUNTIME_DIR=/home/spark/jupyter/runtime PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS="notebook --no-browser --port=7777 --notebook-dir=/home/spark/jupyter/notebooks --ip=* --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''" $SPARK_HOME/bin/pyspark --packages graphframes:graphframes:0.7.0-spark2.4-s_2.11 --master spark://spark-master:7077
