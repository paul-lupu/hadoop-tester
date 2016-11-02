#!/bin/bash
echo " ##### RUNNING ZEPPELIN NOTEBOOKS TEST ##### "
for i in 2B48PF7SN 2BFGYS3YT 2BJVW65WS 2BNDT63TY 2BEQE47HR; do 
	echo "Running notebook ID: $i ..."
	if [[ $(/bin/bash /opt/tests/zeppelin/zeptest.sh $i  | grep OK ) ]]; 
		then 
			echo "Run completed successfully!" 
			echo ""
	else
		echo "Zeppelin notebook ID: $i failed to execute! Aborting..."
		return 1;
	fi;
done
echo "All zeppelin tests successfull!"

