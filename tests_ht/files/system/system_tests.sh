#!/bin/bash
#this file will start up all services and check that everything is able to start correctly

echo  "##### WAITING ON GUEST TO BECOME READY #####"
TO=0; until curl -s -u admin:4o12t0n -i -H 'X-Requested-By: ambari' http://localhost:8080/api/v1/hosts/sandbox.hortonworks.com/ | grep host_status  | grep -E 'HEALTHY||ALERT' | grep -v UNHEALTHY &> /dev/null || [ $TO -eq 180 ] ; do sleep 1 $(( TO++ ));
if [ $TO -eq 180 ]; then
 echo "Host state is unhealthy. Exiting."
 exit 1
fi
 done

if [ $TO -eq 180 ]; then
 echo "Host state is unhealthy. Exiting."
 exit 1
fi

echo "##### STARTING ALL SERVICES ##### "
for i in $(curl -s -u admin:4o12t0n -H "X-Requested-By: ambari" http://localhost:8080/api/v1/clusters/Sandbox/services/ | grep  -oP "[A-Z_0-9]{3,}" | grep -vi metrics| uniq); do
        curl  -s -u admin:4o12t0n -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo":{"context":"Turn Off Maintenance Mode"},"Body":{"ServiceInfo":{"maintenance_state":"OFF"}}}'  http://localhost:8080/api/v1/clusters/Sandbox/services/$i > /dev/null
        sleep 3
done
curl -u admin:4o12t0n -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo":{"context":"_PARSE_.START.ALL_SERVICES","operation_level":{"level":"CLUSTER","cluster_name":"Sandbox"}},"Body":{"ServiceInfo":{"state":"STARTED"}}}' http://localhost:8080/api/v1/clusters/Sandbox/services 


TO=0;
until curl -s -u admin:4o12t0n -i -H 'X-Requested-By: ambari' http://localhost:8080/api/v1/hosts/sandbox.hortonworks.com/ | grep host_status  | grep HEALTHY| grep -v UNHEALTHY &> /dev/null || [ $TO -eq 180 ] ; do sleep 1 $(( TO++ ));
if [ $TO -eq 180 ]; then
 echo "Starting all services failed. Exiting."
 exit 1
fi
done

echo '##### RESTARTING AMBARI-SERVER AND CHECKING FOR STALE AMBARI-AGENT #####'
export TERM=linux
sudo /usr/sbin/ambari-server restart
for i in {0..60}; do
        sudo /usr/sbin/ambari-agent status | grep -i stale
        if [ $? -eq 0  ]; then
                exit 1;
        fi
        sleep 1
        echo -n '.'
done
echo ' ' 
echo 'No stale ambari-agent process found'


