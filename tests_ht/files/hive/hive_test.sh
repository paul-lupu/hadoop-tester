#!/bin/bash
echo ""
echo " ##### RUNNING HIVE TABLE LIST TEST ##### "
/usr/bin/timeout 400s /usr/bin/hive -e 'show tables;'
if [ $? -eq 0 ]; then
        echo "Test completed successfully."
else
        echo "Test failed."
				exit 1
fi
echo ""
echo " ##### RUNNING HIVE SELECT COUNT(*) TEST ##### "
/usr/bin/timeout 400s /usr/bin/hive -e 'select count(*) from sample_07;'
if [ $? -eq 0 ]; then
        echo "Test completed successfully."
else
        echo "Test failed."
        exit 1
fi
exit 0 

