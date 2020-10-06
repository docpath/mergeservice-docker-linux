#!/bin/bash

set -e

cd '/usr/local/docpath/licenseserver/licenseserver/Bin'
./startServer.sh

cd /usr/local/docpath/mergeservicepack/mergeservice/mergeservice/Bin
exec java -jar dpmergeservice.war -logmodeconsole



