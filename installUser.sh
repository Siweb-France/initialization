#!/bin/bash

set -euxo pipefail

defaultUser="it-siweb"

useradd -m "$defaultUser" -s /bin/bash -p '*'

sshLocal="/home/$defaultUser/.ssh"
mkdir "$sshLocal"
chmod 0700 "$sshLocal"

defaultGithubUser="admin-siweb"
curl "https://api.github.com/users/$defaultGithubUser/keys" | jq -r .[].key >> $sshLocal/authorized_keys
chown -R $defaultUser:$defaultUser $sshLocal

usermod -a -G www-data it-siweb
