#!/bin/bash

license_address="${LICENSE_ADDRESS}"
license_port="${LICENSE_PORT}"
transaction_id="${TRANSACTION_ID}"
shutdown_session="${SHUTDOWN_SESSION}"

cd '/usr/local/docpath/licenseserver/licenseserver/Bin'
exec java -jar dplicenseserver.jar -start -logmodeconsole &
sleep 5

cd /usr/local/docpath/mergeservicepack/mergeservice/Bin

if [[ -n $transaction_id ]]
then
    exec java -jar dpmergeservice.war -logmodeconsole -licensetransactionid$transaction_id -licenseaddr$license_address -licenseport$license_port -licenseshutdownsession$shutdown_session
else
    exec java -jar dpmergeservice.war -logmodeconsole 
fi