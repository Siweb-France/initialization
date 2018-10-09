#!/bin/bash

set -euo pipefail

packages=(
cvs git mailutils postfix
htop iftop vim screen colordiff
build-essential markdown firewall-applet pureftpd
libaprutil1{,-dev} apache2 mysql-server
silversearcher-ag augeas jq curl wget
)

packagesPhp5=(
php5 libapache2-mod-php5
php5-curl php5-mcrypt 
php5-mysqlnd php5-gd php5-xmlrpc
php5-apcu php5-ssh2
)

packagesPhp7=(
php7.0 libapache2-mod-php7.0
php7.0-curl php7.0-mcrypt 
php7.0-mysql php7.0-gd 
php7.0-xml php7.0-xml-rpc
php7.0-mbstring php7.0-apcu php7.0-ssh2
)


if dpkg --compare-versions "$(cat /etc/debian_version)" "lt" "9.0"
then
    packagesPhp=("${packagesPhp5[@]}")
else
    packagesPhp=("${packagesPhp7[@]}")
fi

targetPackages=( "${packages[@]}" "${packagesPhp[@]}")

apt-get update
apt-get upgrade -y
apt-get install -y "$targetPackages"

mv /etc/mysql/my.cnf{,.origine}

phpIni="/etc/$phpVersion/apache2/php.ini"
cliIni="/etc/$phpVersion/cli/php.ini"

replacements=();
replacements+=("s/short_open_tag = Off/short_open_tag = On/g")
replacements+=("s/display_errors = Off/display_errors = On/g")
replacements+=("s/memory_limit = 128M/memory_limit = 1024M/g")
replacements+=("s/upload_max_filesize = 2M/upload_max_filesize = 20M/g")
replacements+=("s/post_max_size = 8M/post_max_size = 20M/g")
replacements+=("s/display_startup_errors = Off/display_startup_errors = On/g")
replacements+=("s/error_reporting = E_ALL \& ~E_DEPRECATED \& ~E_STRICT/error_reporting = E_ALL \& ~E_NOTICE \& ~E_DEPRECATED \& ~E_STRICT \& ~E_WARNING/g")

mysqlReplacement=$(printf ";%s" "${replacements[@]}")
mysqlReplacement="${mysqlReplacement:1}"

sed -Ei "$mysqlReplacement" "$phpIni"


defaultUser="it-siweb"
useradd -m "$defaultUser"
sshLocal="/home/$defaultUser/.ssh"
mkdir "$sshLocal"
chmod 0700 "$sshLocal"

defaultGithubUser="admin-siweb"
curl "https://api.github.com/usrs/$defaultGithubUser/keys" | jq -r .[].key >> $sshLocal/authorized_keys

chown -R $defaultUser:$defaultUser $sshLocal

