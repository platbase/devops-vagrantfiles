#! /bin/bash

set -o nounset
set -o errexit

source /vagrant/mysql/install.conf

mkdir -p /tmp/install-mysql
pushd /tmp/install-mysql

cat << EOF > cluster_status.js
shell.connect('root@localhost:3306', '${MYSQL_ROOT_PWD}')
var cluster=dba.getCluster('${MYSQL_CLUSTER_NAME}')
print(cluster.status(), '\n')
EOF
mysqlsh --no-password --js --file=cluster_status.js
