#! /bin/bash

set -o nounset
set -o errexit

timedatectl set-timezone Asia/Shanghai
timedatectl

rm -fv /tmp/*-cluster-ready

# remove "127.0.2.1 hostname hostname", which is conflict with hostmanager
sed -i '/127\.0\.2\.1/d' /etc/hosts

USER_BOOT="/vagrant/usr/boot.sh"
if [ -f "${USER_BOOT}" ]; then
	echo "[$(date +%Y%m%d-%H%M%S)] >>> Begin to run user-boot script: '${USER_BOOT}' at host '$(hostname)' ..."
	${USER_BOOT}
fi
