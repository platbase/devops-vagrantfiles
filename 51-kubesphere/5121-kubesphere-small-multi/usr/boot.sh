#! /bin/bash

set -o nounset
set -o errexit

# register vagrant-host for ElasticSearch Connection
cat /etc/hosts | grep "vagrant-host"
if [ $? > 0 ]; then
    echo "# Add vagrant host's IP address(The same as the default gateway)"    >> /etc/hosts
    echo "$(/sbin/ip route|awk '/default/ { print $3 }')     vagrant-host"     >> /etc/hosts
fi

# apt-get update -y
apt-get install -y conntrack socat
