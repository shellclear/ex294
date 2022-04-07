#!/usr/bin/env sh

echo "copy automation user ssh key to the target nodes"
ansible all -uautomation -b -m authorized_key -a'user=automation key="{{ lookup("file", "files/automation_ssh_rsa.pub") }}"'

