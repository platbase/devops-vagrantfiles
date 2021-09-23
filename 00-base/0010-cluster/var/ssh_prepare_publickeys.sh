#! /bin/bash

set -o nounset
set -o errexit

echo "[$(date +%Y%m%d-%H%M%S)] >>> Preparing SSH Public Keys: Node='$(hostname)', All Nodes='$@', Account='$(id)' ..."

# Build ssh public key of current VM Node
rm -rfv ~/.ssh/id_rsa*
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
mkdir -p /vagrant/.vagrant/.config/ssh-keys
cp ~/.ssh/id_rsa.pub /vagrant/.vagrant/.config/ssh-keys/$(id -nu)-$(hostname).id_rsa.pub

# Test if crontab exists already
set +o errexit
crontab -l > /dev/null
if [ $? -ne 0 ]; then
    echo -e "#Create by '$0' at [$(date)]\n# m h  dom mon dow   command\n" | crontab -
fi
set -o errexit

# Insert "~/ssh_rebuild_publickeys.sh" as cron task
if [ $(crontab -l | grep "ssh_rebuild_publickeys.sh" | wc -l) -eq 0 ]; then
    CRON_JOB="* * * * * /vagrant-var/ssh_rebuild_publickeys.sh $@ >> /tmp/$(id -nu)-ssh_rebuild_publickeys.log #Add by $0"
    crontab -l | sed -e "\$a ${CRON_JOB}" | crontab -
fi

