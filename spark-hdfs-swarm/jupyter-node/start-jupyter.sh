#!/bin/bash
if [ ! -d '/home/jupyter/notebooks' ]; then
  echo "Jupyter notebooke directory not found: /home/jupyter/notebooks"
  exit 2
fi

if [ ! -d '/data/spark' ]; then
  echo "Spark work directory not found: /data/spark"
  exit 2
fi

SHELL=/bin/bash XDG_RUNTIME_DIR=/home/jupyter/runtime PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS="notebook --no-browser --port=7777 --notebook-dir=/home/jupyter/notebooks --ip=* --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''" $SPARK_HOME/bin/pyspark --master spark://spark-master:7077
