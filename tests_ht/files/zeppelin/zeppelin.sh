#!/bin/bash
echo " ##### RUNNING ZEPPELIN NOTEBOOKS TEST ##### "
output=curl http://localhost:9995/api/notebook/import --data @notebook.js
id=$(echo $output | grep -oP \"body\":\".+\" | grep -oP [0-9A-Z]+)
for i in $id; do
  echo "";
  echo "Running parahraphs for note: $i":
  curl -s -XGET http://localhost:9995/api/interpreter/setting | jq '.body[] | .id'
  interpreter_settings_ids=`curl -s -XGET http://localhost:9995/api/interpreter/setting | jq '.body[] | .id'`
  id_array="["`echo ${interpreter_settings_ids} | tr ' ' ','`"]"
  curl -s -XPUT -d $id_array http://localhost:9995/api/notebook/interpreter/bind/$i&> /dev/null

  for y in $(curl  -s -XGET http://localhost:9995/api/notebook/job/$i | grep  -oP [0-9]+-[0-9]+_[0-9]+); do
    echo -n "Running paragraph $y:";
    if [[ $(curl -s -XPOST http://localhost:9995/api/notebook/job/$i/$y | grep OK) ]]; then
      echo -n "Waiting for results "; while curl  -s -XGET http://localhost:9995/api/notebook/job/$i | grep 'PENDING\|RUNNING' >/dev/null; do echo -n "."; sleep 1; done;
      if [[ $(curl  -s -XGET http://localhost:9995/api/notebook/job/$i | grep ERROR ) ]]; then
        echo "Failed! Exitting...";
        exit 1;
      fi
      echo -n "Complete! ";
    else
      echo "Couldn't run paragraph, exitting...";
      exit 1;
    fi
  done
  echo ""
done
echo "All zeppelin tests successfull!"

