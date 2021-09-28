#! /bin/bash

set -o nounset
set -o errexit

echo "[$(date +%Y%m%d-%H%M%S)] >>> Run '$0' at '$(hostname)', with account '$(id)' ..." >&2

if [ "root" != "$(id -ng)" ]; then
	echo "MUST run '$0' as root, account '$(id)' invalid!"
	exit -1
fi

mkdir -pv /vagrant/kubesphere/.work
pushd /vagrant/kubesphere/.work

export KKZONE=cn

#curl -sfL https://get-kk.kubesphere.io | VERSION=v1.1.1 sh -
curl -L https://get-kk.kubesphere.io -o get-kk.sh
cat get-kk.sh | VERSION=v1.1.1 sh -

chmod +x kk

_START="$(date +%Y%m%d-%H%M%S)"

echo "yes" | ./kk create cluster -f ../config-vagrant.yaml -

echo "[$(date +%Y%m%d-%H%M%S)] >>> Run '$0' success, from [$_START]."

popd
