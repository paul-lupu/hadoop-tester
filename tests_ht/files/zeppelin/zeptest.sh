#!/bin/bash

node_id=$1

curl -s -XGET http://localhost:9995/api/interpreter/setting | jq '.body[] | .id'

interpreter_settings_ids=`curl -s -XGET http://localhost:9995/api/interpreter/setting | jq '.body[] | .id'`

id_array="["`echo ${interpreter_settings_ids} | tr ' ' ','`"]"

curl -s -XPUT -d $id_array http://localhost:9995/api/notebook/interpreter/bind/$1 &> /dev/null

curl -s -XPOST http://localhost:9995/api/notebook/job/$1

