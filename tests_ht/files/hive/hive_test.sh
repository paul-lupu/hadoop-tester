#!/bin/bash
echo ""
echo " ##### RUNNING HIVE TABLE LIST TEST ##### "
su - hive -c "hive -e 'show tables;'"
if [ $? -eq 0 ]; then
        echo "Test completed successfully."
else
        echo "Test failed."
fi

