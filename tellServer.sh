#!/bin/bash
set -euo pipefail

if test "$#" -lt 1;
then
    echo "Usage $0 servername" > /dev/stderr
    exit 1;
fi

remoteServer="$1"

curl -H "Content-Type: application/json" \
    --request POST \
    -d "{\"hostname\":\"$(hostname)\",\"fingerprint\":\"$(ssh-keygen -l -f /etc/ssh/ssh_host_ecdsa_key.pub | cut -d' ' -f2)\"}" \
    "$remoteServer"

