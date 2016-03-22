#!/bin/bash
# https://docs.vagrantup.com/v2/provisioning/shell.html

source "/vagrant/scripts/common.sh"

function disableFirewall {
	echo "disabling firewall"
	sudo ufw disable
}

function setupHosts {
	echo "modifying /etc/hosts file"
	echo "127.0.0.1   localhost" >> /etc/nhosts
	echo "::1         localhost" >> /etc/nhosts
	echo "0.0.0.10  localhost" >> /etc/nhosts

	#cat /etc/hosts >> /etc/nhosts
	cp /etc/nhosts /etc/hosts
	rm -r /etc/nhosts
}

function installSSHPass {
	apt-get -y install sshpass
}

function overwriteSSHCopyId {
	cp -f $RES_SSH_COPYID_MODIFIED /usr/bin/ssh-copy-id
}

function createSSHKey {
	echo "generating ssh key"
	ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
	cp -f $RES_SSH_CONFIG ~/.ssh
}

function setupUtilities {
    # so the `locate` command works
    apt-get install -y mlocate
    updatedb
}

echo "setup ubuntu"
disableFirewall

echo "setup ubuntu hosts file"
setupHosts

echo "setup ssh"
installSSHPass
createSSHKey
overwriteSSHCopyId

echo "setup utilities"
setupUtilities

echo "ubuntu setup complete"
