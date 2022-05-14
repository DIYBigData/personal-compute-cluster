#!/bin/bash

SHELL=/bin/bash \
    XDG_RUNTIME_DIR=/home/spark/jupyter/runtime \
    PYSPARK_DRIVER_PYTHON=jupyter \
    PYSPARK_DRIVER_PYTHON_OPTS="notebook --no-browser --port=7777 --notebook-dir=/home/spark/jupyter/notebooks --ip=0.0.0.0 --NotebookApp.password='' --NotebookApp.token='' --NotebookApp.iopub_data_rate_limit=1.0e10" \
    $SPARK_HOME/bin/pyspark \
    --packages graphframes:graphframes:$GRAPHFRAMES_VERSION,com.johnsnowlabs.nlp:$SPARK_NLP_VERSION \
    --repositories https://repos.spark-packages.org/ \
    --master spark://spark-master:7077
