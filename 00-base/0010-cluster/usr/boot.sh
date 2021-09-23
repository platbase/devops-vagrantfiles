#! /bin/bash

set -o nounset
set -o errexit

echo "******** THIS IS THE SAMPLE USER BOOT SCRIPT ********"

# To test port forwarding, install nginx here
if [ "$(hostname)" == "leader" ]; then
	apt-get update -y
	apt-get install -y nginx
fi
