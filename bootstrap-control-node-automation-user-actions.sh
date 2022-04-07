#!/usr/bin/env sh

echo "configure automation user ssh key"
ansible localhost -uautomation -m openssh_keypair -a "path=files/automation_ssh_rsa"

echo "configure .vimrc file"
ansible localhost -uautomation -m copy -a 'content="autocmd FileType yaml setlocal ai ts=2 sw=2 et" dest="${HOME}/.vimrc"'

