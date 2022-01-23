#! /bin/bash

set -o nounset
set -o errexit

source /vagrant/mysql/install.conf

mkdir -p /tmp/install-mysql
pushd /tmp/install-mysql

cat << EOF > init_cluster.js
shell.connect('root@localhost:3306', '${MYSQL_ROOT_PWD}')
dba.createCluster('${MYSQL_CLUSTER_NAME}', {'localAddress': '${CLUSTER_HOSTS[0]}'})
var cluster=dba.getCluster('${MYSQL_CLUSTER_NAME}')
cluster.addInstance('root@${CLUSTER_HOSTS[1]}:3306', {'localAddress': '${CLUSTER_HOSTS[1]}', 'password': '${MYSQL_ROOT_PWD}', 'recoveryMethod': 'clone'})
cluster.addInstance('root@${CLUSTER_HOSTS[2]}:3306', {'localAddress': '${CLUSTER_HOSTS[2]}', 'password': '${MYSQL_ROOT_PWD}', 'recoveryMethod': 'clone'})
EOF
mysqlsh --no-password --js --file=init_cluster.js
