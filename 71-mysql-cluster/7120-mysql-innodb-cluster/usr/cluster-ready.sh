#! /bin/bash

set -o nounset
set -o errexit

ssh mysql-host1 "sudo /vagrant/mysql/cluster/create-cluster.sh"

ssh mysql-host1 "sudo /vagrant/mysql/cluster/start-router.sh"
ssh mysql-host2 "sudo /vagrant/mysql/cluster/start-router.sh"
sudo /vagrant/mysql/cluster/start-router.sh
