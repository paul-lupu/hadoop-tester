#!/bin/bash
echo ""
echo " ##### RUNNING HIVE TABLE LIST TEST ##### "
/usr/bin/timeout 400s /usr/bin/hive -e 'show tables;'
if [ $? -eq 0 ]; then
        echo "Test completed successfully."
				exit 0
else
        echo "Test failed."
				exit 1
fi
echo ""
/usr/bin/timeout 400s su - hive -c "/usr/bin/hive -e 'select count(*) from sample_07;'"
if [ $? -eq 0 ]; then
        echo "Test completed successfully."
        exit 0
else
        echo "Test failed."
        exit 1
fi


