#!/bin/bash
echo "##### TESTING SQOOP EXPORT #####"
mysql -u root -e 'use test; create table sample_07 (code text, description text, total_emp int, salary int);'
su - hdfs -c 'sqoop export --connect jdbc:mysql://127.0.0.1/test --username hive --password hive --table sample_07 --export-dir /apps/hive/warehouse/sa' 
mysql -u root -e 'use test; drop table sample_07;'
if [ $? -ne 0 ]; then
	exit 1
fi
exit 0
