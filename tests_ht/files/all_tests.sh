#!/bin/bash

cd /opt/tests
/bin/bash ./system/system_tests.sh
    if [ $? -ne 0 ]; then echo '!!!!! INTEGRATION TEST FAILED. EXITING...'; exit 1; fi;
/bin/bash ./api_tests.sh
    if [ $? -ne 0 ]; then echo '!!!!! INTEGRATION TEST FAILED. EXITING...'; exit 1; fi;
/bin/bash ./service_tests.sh
    if [ $? -ne 0 ]; then echo '!!!!! INTEGRATION TEST FAILED. EXITING...'; exit 1; fi;


