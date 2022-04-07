#!/usr/bin/env sh

echo "configure automation user ssh key"
ansible localhost -uautomation -m openssh_keypair -a "path=files/automation_ssh_rsa"

