#!/bin/bash

USAGE="Error: Missing Parameter.  Usage: $0 [node-number]"
TEMPLATE_FILE="./00-installer-config.template"
DATA_FILE="/etc/netplan/00-installer-config.yaml"

if [ "$EUID" -ne 0 ]; then
    echo "Please run using sudo"
    exit 1
fi

if [ -z ${1+x} ]; then
    echo $USAGE
    exit 1
else
    export NODE_NUMBER=$1
fi

if [ -f ${DATA_FILE} ]; then
    echo "Using source file ${DATA_FILE}"
else
    echo "Error: Missing expected netplan config at ${DATA_FILE}"
    exit 1
fi

if [ -f ${DATA_FILE} ]; then
    export CEPH_NET_DEVICE=`grep -i enxa0 ${DATA_FILE} | cut -d':' -f1 | xargs`
else
    echo "Unable to find expected file at ${DATA_FILE}"
    exit 1
fi

echo "Backing up old netplan"
BACKUP_FILE=${DATA_FILE}.backup

if [ -f ${BACKUP_FILE} ]; then
    rm ${BACKUP_FILE}
fi

mv ${DATA_FILE} ${BACKUP_FILE}

echo "Rendering template with node number [${NODE_NUMBER}] and network device [${CEPH_NET_DEVICE}"]
cat ${TEMPLATE_FILE} | envsubst > ${DATA_FILE}

