#! /bin/bash

set -o nounset
set -o errexit
set -x

source /vagrant/mysql/install.conf

mkdir -p /tmp/install-mysql
pushd /tmp/install-mysql

# Install mysql-community-server mysql-shell mysql-router
wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb
export DEBIAN_FRONTEND=noninteractive
dpkg -i mysql-apt-config_0.8.22-1_all.deb
apt-get update
apt-get install -y mysql-community-server mysql-shell mysql-router

#systemctl restart mysqld
service mysql restart

# Default root password is BLANK
mysql --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PWD}';"
export MYSQL_PWD="${MYSQL_ROOT_PWD}"
mysql --connect-expired-password -e "CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PWD}';"
#mysql --connect-expired-password -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PWD}';"
mysql --connect-expired-password -e "GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# Avoid mysqlsh - Dba.configureLocalInstance: Invalid host/IP 'mysql-host2' resolves to '127.0.2.1' which is not supported. (RuntimeError)
sed -i '/127\.0\.2\.1/d' /etc/hosts

# Config local instance with mysqlsh
cat << EOF > config_local_instance.js
dba.configureLocalInstance('root@localhost:3306', {'password': '${MYSQL_ROOT_PWD}', 'interactive': false})
EOF
mysqlsh --no-password --js --file=config_local_instance.js

#systemctl restart mysqld
service mysql restart

# Check local instance configuratin
cat << EOF > check_local_instance.js
dba.checkInstanceConfiguration('root@localhost:3306', {'password': '${MYSQL_ROOT_PWD}', 'interactive': false})
EOF
mysqlsh --no-password --js --file=check_local_instance.js
