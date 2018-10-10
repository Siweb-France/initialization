#!/bin/bash

set -euxo pipefail

defaultUser="it-siweb"

useradd -m "$defaultUser" -s /bin/bash -p '*'

home="/home/$defaultUser"
sshLocal="$home/.ssh"
mkdir "$sshLocal"
chmod 0700 "$sshLocal"

defaultGithubUser="admin-siweb"
curl "https://api.github.com/users/$defaultGithubUser/keys" | jq -r .[].key >> $sshLocal/authorized_keys
chown -R $defaultUser:$defaultUser $sshLocal

usermod -a -G www-data it-siweb
echo "export CVSROOT=client@cvs.siweb.fr/usr/local/cvs-root" >> $home/.bashrc
echo "export PATH=\"\$PATH:/var/scripts\"" >> $home/.bashrc

sed -i -e 's/#alias ll/alias ll/g;s/#alias la/alias la/g;s/#alias l=/alias l=/g' $home/.bashrc
sed -i -e 's/# alias ls=/alias ls=/g' $home/.bashrc
sed -i -e 's/# alias ll=/alias ll=/g' $home/.bashrc
sed -i -e 's/# alias l=/alias l=/g' $home/.bashrc
sed -i -e "s/#force_color_prompt=yes/force_color_prompt=yes/g" $home/.bashrc

chown it-siweb:www-data /var/www

ln -s /var/www $home/www
ln -s /var $home/var
ln -s /var /data


