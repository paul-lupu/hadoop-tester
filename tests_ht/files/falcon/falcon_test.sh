#!/bin/bash
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License. See accompanying LICENSE file.
#

# resolve links - $0 may be a softlink
echo " ##### RUNNING FALCON OOZIE TEST #####"
exec_shell_command () {
   RETSTRING=$($1 2>&1)
   EXITVAL=$?
   if [[ $EXITVAL != 0 ]]; then
        echo "$RETSTRING"
        exit $EXITVAL
   fi
}

FALCON_DIR="${1}"

while [ -h "${FALCON_DIR}" ]; do
  ls=`ls -ld "${FALCON_DIR}"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    FALCON_DIR="$link"
  else
    FALCON_DIR=`dirname "${FALCON_DIR}"`/"$link"
  fi
done

if [ -d "$FALCON_DIR" ]; then
  cd "$FALCON_DIR"
else
  echo "Usage : ./falcon-verify.sh <falcon home dir>
Please provide valid falcon directory"
  exit 1;
fi

# create cluster and feed xml files
CLUSTER_XML="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>
<cluster name=\"primaryCluster\" description=\"this is primary cluster\" colo=\"primaryColo\" xmlns=\"uri:falcon:cluster:0.1\">
    <tags>primaryKey=primaryValue</tags>
    <interfaces>
        <interface type=\"readonly\" endpoint=\"hftp://sandbox.hortonworks.com:50070\" version=\"2.2.0\"/>
        <interface type=\"write\" endpoint=\"hdfs://sandbox.hortonworks.com:8020\" version=\"2.2.0\"/>
        <interface type=\"execute\" endpoint=\"sandbox.hortonworks.com:8050\" version=\"2.2.0\"/>
        <interface type=\"workflow\" endpoint=\"http://sandbox.hortonworks.com:11000/oozie/\" version=\"4.0.0\"/>
        <interface type=\"messaging\" endpoint=\"tcp://sandbox.hortonworks.com:61616?daemon=true\" version=\"5.1.6\"/>
    </interfaces>
    <locations>
        <location name=\"staging\" path=\"/apps/falcon/primaryCluster/staging\"/>
        <location name=\"temp\" path=\"/tmp\"/>
        <location name=\"working\" path=\"/apps/falcon/primaryCluster/working\"/>
    </locations>
    <ACL owner=\"ambari-qa\" group=\"users\" permission=\"0x755\"/>
    <properties>
        <property name=\"test\" value=\"value1\"/>
    </properties>
</cluster>"

FEED_XML="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>
<feed name=\"rawEmailFeed\" description=\"Raw customer email feed\" xmlns=\"uri:falcon:feed:0.1\">
    <tags>externalSystem=USWestEmailServers</tags>
    <groups>churnAnalysisDataPipeline</groups>
    <frequency>hours(1)</frequency>
    <timezone>UTC</timezone>
    <late-arrival cut-off=\"hours(1)\"/>
    <clusters>
        <cluster name=\"primaryCluster\" type=\"source\">
            <validity start=\"2015-10-30T01:00Z\" end=\"2015-10-30T10:00Z\"/>
            <retention limit=\"days(90)\" action=\"delete\"/>
        </cluster>
    </clusters>
    <locations>
        <location type=\"data\" path=\"/user/ambari-qa/falcon/demo/\${YEAR}-\${MONTH}-\${DAY}-\${HOUR}\"/>
        <location type=\"stats\" path=\"/\"/>
        <location type=\"meta\" path=\"/\"/>
    </locations>
    <ACL owner=\"ambari-qa\" group=\"users\" permission=\"0x755\"/>
    <schema location=\"/none\" provider=\"/none\"/>
</feed>"

CLUSTER_FILE="/tmp/falcon_verify_cluster.xml"
echo "Creating cluster entity XML"
if [ -e "${CLUSTER_FILE}" ]; then
    rm -rf "$CLUSTER_FILE"
fi
echo "$CLUSTER_XML" > $CLUSTER_FILE

echo "Creating feed entity XML"
FEED_FILE="/tmp/falcon_verify_feed.xml"
if [ -e "${FEED_FILE}" ]; then
    rm -rf "$FEED_FILE"
fi
echo "$FEED_XML" > $FEED_FILE

# Create dirs in HDFS
echo "Creating falcon working directories in HDFS"
exec_shell_command "sudo -u hdfs hadoop fs -mkdir -p /apps/falcon/primaryCluster/working"
exec_shell_command "sudo -u hdfs hadoop fs -mkdir -p /apps/falcon/primaryCluster/staging"
exec_shell_command "sudo -u hdfs hadoop fs -mkdir -p /user/ambari-qa/falcon/demo/"
exec_shell_command "sudo -u hdfs hadoop fs -chmod -R 777 /apps/falcon/primaryCluster /user/ambari-qa/falcon"
exec_shell_command "sudo -u hdfs hadoop fs -chown -R falcon /apps/falcon/primaryCluster"
exec_shell_command "sudo -u hdfs hadoop fs -chmod -R 755 /apps/falcon/primaryCluster/working"
exec_shell_command "sudo -u hdfs hadoop fs -chown -R ambari-qa /apps/falcon/primaryCluster/staging/falcon/workflows/feed/rawEmailFeed"

# Submit entities
echo "Submitting cluster entity XML"
SUBMIT_CLUSTER="sudo -u ambari-qa falcon entity -type cluster -submit -file ""$CLUSTER_FILE"
exec_shell_command "$SUBMIT_CLUSTER"

echo "Submitting feed entity XML"
SUBMIT_FEED="sudo -u ambari-qa falcon entity -type feed -submit -file ""$FEED_FILE"
exec_shell_command "$SUBMIT_FEED"

# Schedule entities
echo "Scheduling feed entity rawEmailFeed"
exec_shell_command "sudo -u ambari-qa falcon entity -type feed -schedule -name rawEmailFeed"

# Cleanup entities
echo "Cleaningup entities after verifying falcon setup"
exec_shell_command "sudo -u ambari-qa falcon entity -type feed -delete -name rawEmailFeed"
exec_shell_command "sudo -u ambari-qa falcon entity -type cluster -delete -name primaryCluster"


echo "Falcon setup is successfully verified on Sandbox"
exit 0


