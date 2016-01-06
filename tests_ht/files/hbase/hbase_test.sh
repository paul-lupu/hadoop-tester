#!/bin/bash
echo ""
echo  " ##### SENDING HBASE START COMMAND AND WAITING FOR SERVICE TO START #####"

curl  -s -u admin:admin -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo":{"context":"Turn Off Maintenance Mode"},"Body":{"ServiceInfo":{"maintenance_state":"OFF"}}}'  http://localhost:8080/api/v1/clusters/Sandbox/services/HBASE
sleep 5
until curl  -s -u admin:admin -i -H 'X-Requested-By: ambari' -X PUT -d '{"ServiceInfo": {"state" : "STARTED"}}'  http://localhost:8080/api/v1/clusters/Sandbox/services/HBASE | grep Accepted; do sleep 2; done;
until /usr/bin/curl -s --user admin:admin -H "X-Requested-By: ambari" http://localhost:8080/api/v1/clusters/Sandbox/services/HBASE | grep -P '"CRITICAL" : 0'; do echo -n .; sleep 2; done;
sleep 5
echo " ##### RUNNING HBASE TABLE LIST TEST ##### "
timeout 300s /usr/bin/hbase shell /opt/tests/hbase/hbase_commands
if [ $? -eq 0 ]; then
        echo "Test completed successfully."
        exit 0
else
        echo "Test failed."
        exit 1
fi

