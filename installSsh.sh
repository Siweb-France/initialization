#!/bin/bash


sed -i -e "s/PermitRootLogin yes/PermitRootLogin without-password/g" /etc/ssh/sshd_config
sed -i -E "s/(MAC .*)/\0,hmac-ripemd160/g" /etc/ssh/sshd_config

service ssh restart

