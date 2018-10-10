#!/bin/bash
defaultUser="it-siweb"
adduser "$defaultUser" --shell /bin/bash -p '*' -gecos
sshLocal="/home/$defaultUser/.ssh"
mkdir "$sshLocal"
chmod 0700 "$sshLocal"

defaultGithubUser="admin-siweb"
curl "https://api.github.com/usrs/$defaultGithubUser/keys" | jq -r .[].key >> $sshLocal/authorized_keys
chown -R $defaultUser:$defaultUser $sshLocal
