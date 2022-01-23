#! /bin/bash

set -o nounset
set -o errexit

apt-get update -y
/vagrant/mysql/install-mysql.sh
