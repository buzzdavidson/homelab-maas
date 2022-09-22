#!/bin/bash

if [ -f ~/.ssh/id_rsa ]; then
    SOURCE_KEY=~/.ssh/id_rsa
else
    echo "Error: key missing.  Execute 'ssh-keygen' on leader node first."
    exit 1
fi

HOST_IP="10.50.0.20"

HOST_FILE=../network/hosts.txt

if [ -f ${HOST_FILE} ]; then
    echo "Host file found"
else
    echo "Error: execute script from directory containing the script"
    exit 1
fi

echo "Script will now copy the specified key to hosts; you may need to enter credentials!"
while IFS="" read -r p || [ -n "$p" ]
do
    ADDR=`echo $p | cut -d' ' -f1`
    if [ ${HOST_IP} == ${ADDR} ]; then
	echo "Skipping leader node ip ${ADDR}"
    else
	ssh-copy-id -i ${SOURCE_KEY} steve@${ADDR}
    fi
done < ${HOST_FILE}
