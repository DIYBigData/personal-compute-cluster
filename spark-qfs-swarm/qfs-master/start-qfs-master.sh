#!/bin/bash

$QFS_HOME/bin/metaserver $QFS_HOME/conf/Metaserver.prp &> $QFS_LOGS_DIR/metaserver.log &

python2.7 $QFS_HOME/webui/qfsstatus.py $QFS_HOME/conf/webUI.cfg &> $QFS_LOGS_DIR/webui.log &

$QFS_HOME/bin/tools/qfs -fs qfs://qfs-master:20000 -D fs.trash.minPathDepth=2 -runEmptier &

# now do nothing and do not exit
while true; do sleep 3600; done

