#! /bin/bash

set -o nounset
set -o errexit

timedatectl set-timezone Asia/Shanghai
timedatectl

USER_BOOT="/vagrant/usr/boot.sh"
if [ -f "${USER_BOOT}" ]; then
	echo "[$(date +%Y%m%d-%H%M%S)] >>> Begin to run user-boot script: '${USER_BOOT}' at host '$(hostname)' ..."
	${USER_BOOT}
fi
