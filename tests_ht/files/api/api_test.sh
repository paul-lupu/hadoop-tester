#!/bin/bash 
echo "##### TESTING APIs ######"
cd api && jasmine-node api_spec.js
if [ $? -eq 0 ]; then
	echo "API tests completed successfully."
	exit 0
else
	echo "API tests failed."
	exit 1
fi
