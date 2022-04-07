#!/usr/bin/env sh

echo "copy root user ssh key to the target nodes"
ansible all -uroot -k -m authorized_key -a'user=root key="{{ lookup("file", "files/root_ssh_rsa.pub") }}"'

echo "rhsm register node"
for host in ansible2 ansible3 ansible4 ansible5 ; do subscription-manager register --username ppacific@redhat.com --force ; done

echo "create automation user at target node"
ansible all -uroot -k -m user -a'name=automation group=wheel password="{{ "devops" | password_hash("sha512") }}"'

echo "configure privilege escaltion without password to the wheel group"
ansible all -uroot -k -m copy -a'content="%wheel ALL=(ALL) NOPASSWD: ALL" dest=/etc/sudoers.d/wheel validate="/usr/sbin/visudo -cf %s"'


