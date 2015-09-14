#!/bin/bash
echo ""
echo " ##### RUNNING HBASE TABLE LIST TEST ##### "
hbase shell hbase/hbase_commands
if [ $? -eq 0 ]; then
	echo "Test completed successfully."
	exit 0
else
	echo "Test failed."
	exit 1
fi

