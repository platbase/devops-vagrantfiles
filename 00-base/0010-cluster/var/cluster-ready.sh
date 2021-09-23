#! /bin/bash

set -o nounset
set -o errexit

echo "[$(date +%Y%m%d-%H%M%S)] >>> Waiting for Cluser Ready ..."

LOOP_COUNT=0
MAX_LOOP_COUNT=120
while [ ! -f /tmp/root-cluster-ready  ]; do
	printf " $LOOP_COUNT"
    sleep 1

    ((LOOP_COUNT=LOOP_COUNT+1))
    if [ ${LOOP_COUNT} -gt ${MAX_LOOP_COUNT} ]; then	#Waiting for 120 seconds
    	printf "\n"
    	echo "[$(date +%Y%m%d-%H%M%S)] >>> ERROR: Cluster Timeout - wating more then ${MAX_LOOP_COUNT} seconds."
    	exit -1
    fi
done
printf "\n"

USER_CR="/vagrant/usr/cluster-ready.sh"
if [ -f "${USER_CR}" ]; then
	echo "[$(date +%Y%m%d-%H%M%S)] >>> Begin to run user-cluser-ready script: '${USER_CR}' at host '$(hostname)' ..."
	${USER_CR}
fi

echo "[$(date +%Y%m%d-%H%M%S)] >>> Cluster Ready ."
