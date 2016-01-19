#!/bin/bash
echo "##### TESTING SQOOP EXPORT #####"
mysql -u root -e 'use test; create table sample_07 (code text, description text, total_emp long, salary long);'
sqoop export --connect jdbc:mysql://127.0.0.1/test --username hive --password hive --table sample_07 --export-dir /apps/hive/warehouse/sample_07 --driver com.mysql.jdbc.Driver
if [ $? -ne 0 ]; then
	exit 1
fi
exit 0
