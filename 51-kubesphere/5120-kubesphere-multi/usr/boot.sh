#! /bin/bash

set -o nounset
set -o errexit

apt-get update -y
apt-get install -y conntrack
