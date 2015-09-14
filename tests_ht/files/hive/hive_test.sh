#!/bin/bash
echo ""
echo " ##### RUNNING HIVE TABLE LIST TEST ##### "
su - hive -c "hive -e 'show tables;'"
if [ $? -eq 0 ]; then
        echo "Test completed successfully."
				exit 0
else
        echo "Test failed."
				exit 1
fi

