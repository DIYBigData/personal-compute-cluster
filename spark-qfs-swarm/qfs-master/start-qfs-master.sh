#!/bin/bash

$QFS_HOME/bin/metaserver $QFS_HOME/conf/Metaserver.prp &> $QFS_LOGS_DIR/metaserver.log &

python2 $QFS_HOME/webui/qfsstatus.py $QFS_HOME/conf/webUI.cfg &> $QFS_LOGS_DIR/webui.log &

# now do nothing and do not exit
while true; do sleep 3600; done

