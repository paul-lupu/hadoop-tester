#!/bin/bash
echo " ##### RUNNING HBASE TABLE LIST TEST ##### "
timeout 300s /usr/bin/hbase shell /opt/tests/hbase/hbase_commands
if [ $? -eq 0 ]; then
        echo "Test completed successfully."
        exit 0
else
        echo "Test failed."
        exit 1
fi

