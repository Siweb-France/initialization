#!/bin/bash


sed -i -e "s/PermitRootLogin yes/PermitRootLogin without-password/g" /etc/ssh/sshd_config

service ssh restart

