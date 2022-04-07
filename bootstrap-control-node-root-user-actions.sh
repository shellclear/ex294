#!/usr/bin/env sh

echo "rhsm register node"
subscription-manager register --username ppacific@redhat.com --force

echo "enable ansible repo"
subscription-manager repos --enable ansible-2-for-rhel-8-x86_64-rpms 

echo "install ansible"
yum install -y ansible

echo" install basic packages"
ansible localhost -uroot -k -m yum -a "name=git,vim,tmux state=latest"

echo "configure root user ssh key"
ansible localhost -uroot -k -m openssh_keypair -a "path=files/root_ssh_rsa"

echo "create ansible log dir at control node"
ansible localhost -uroot -k -m file -a 'path=/var/log/ansible state=directory owner=root group=wheel mode=0775'

echo "create automation user at control node"
ansible localhost -uroot -k -m user -a'name=automation group=wheel password="{{ "devops" | password_hash("sha512") }}"'

echo "configure privilege escaltion without password to the wheel group"
ansible localhost -uroot -k -m copy -a'content="%wheel ALL=(ALL) NOPASSWD: ALL" dest=/etc/sudoers.d/wheel validate="/usr/sbin/visudo -cf %s"'

