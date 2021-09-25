#! /bin/bash

set -o nounset
set -o errexit

function trySSHConnections(){
    rm -f ~/.ssh/known_hosts    #Avoid - WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
    for host in "$@"; do
        if [ "$host" != "$(hostname)" ]; then
            echo "Try connect to '$host' ..."
            echo "--------"
            set +o errexit
            ssh -o StrictHostKeyChecking=no "$host" "hostname"
            EXIT_CODE=$?
            set -o errexit
            echo "--------"
            if [ "$EXIT_CODE" != "0" ]; then
                echo "SSH Connect to '$host' fail: $EXIT_CODE ."
                return $EXIT_CODE
            else
                echo "SSH Connect to '$host' success ."
            fi
        fi
    done
    return 0
}

echo "[$(date +%Y%m%d-%H%M%S)] >>> Begin to build authorized_keys for: $@ ..."

#Copy all id_rsa.pub files together
if [ "root" != "$(id -ng)" ]; then
	# User "vagrant" - the first line is built by vagrant, for "vagrant ssh" command 
    head -n 1 ~/.ssh/authorized_keys > /tmp/authorized_keys
    cat /tmp/authorized_keys > ~/.ssh/authorized_keys
else
	rm -fv ~/.ssh/authorized_keys
fi
cat /vagrant/.vagrant/.config/ssh-keys/$(id -nu)-* >> ~/.ssh/authorized_keys

echo "~/.ssh/authorized_keys:"
cat ~/.ssh/authorized_keys

trySSHConnections $@
if [ "$?" == "0" ]; then
   echo "[$(date +%Y%m%d-%H%M%S)] >>> SSH connection testing success ."
   
   # Remove ssh_rebuild_publickeys.sh crontab task
   crontab -l | sed -e '/ssh_rebuild_publickeys\.sh/d' | crontab -
   
   # Mark cluster-ready
   echo "$@" > /tmp/$(id -nu)-cluster-ready
else
   echo "[$(date +%Y%m%d-%H%M%S)] >>> SSH connection testing fail, waiting next try ..."
fi

echo -e "\n\n"

