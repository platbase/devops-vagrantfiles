#! /bin/bash

set -o nounset
#set -o errexit

echo "[$(date +%Y%m%d-%H%M%S)] >>> Waiting for Cluser Ready ..."

LOOP_COUNT=1
MAX_LOOP_COUNT=180
while [ ! -f /tmp/root-cluster-ready  ]; do
	printf "..$LOOP_COUNT"
	
	((_EVERY10LOOP=LOOP_COUNT%10))
	if [ ${_EVERY10LOOP} -eq 0 ]; then
		printf "\n"
	fi
	
    sleep 1

    if [ ${LOOP_COUNT} -gt ${MAX_LOOP_COUNT} ]; then	#Waiting for 120 seconds
    	printf "\n"
    	echo "[$(date +%Y%m%d-%H%M%S)] >>> ERROR: Cluster Timeout - wating more then ${MAX_LOOP_COUNT} seconds."
    	exit -1
    fi
    
    ((LOOP_COUNT=LOOP_COUNT+1))
done
printf "\n"

USER_CR="/vagrant/usr/cluster-ready.sh"
if [ -f "${USER_CR}" ]; then
	echo "[$(date +%Y%m%d-%H%M%S)] >>> Begin to run user-cluser-ready script: '${USER_CR}' at host '$(hostname)' ..."
	${USER_CR}
fi

echo "[$(date +%Y%m%d-%H%M%S)] >>> Cluster Ready ."
