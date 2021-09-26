#! /bin/bash

set -o nounset
set -o errexit

ssh main1 "/vagrant/kubesphere/install.sh"
