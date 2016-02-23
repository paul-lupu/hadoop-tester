#!/bin/bash

cd /opt/tests
/bin/bash ./system/system_tests.sh
/bin/bash ./api_tests.sh
/bin/bash ./service_tests.sh

