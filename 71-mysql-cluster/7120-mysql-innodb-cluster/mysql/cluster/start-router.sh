#! /bin/bash

set -o nounset
set -o errexit
set -x

source /vagrant/mysql/install.conf

# Install MySQL Router
mysqlrouter --bootstrap root:${MYSQL_ROOT_PWD}@$(hostname):3306 --user=mysqlrouter --force
systemctl start mysqlrouter
