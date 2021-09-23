#! /bin/bash

set -o nounset
set -o errexit

echo "******** THIS IS THE SAMPLE USER CLUSTER-READY SCRIPT ********"

# Cluster Ready always called in last VM Node, so call sth. with "ssh" is recommended
ssh "leader" "service nginx status"
