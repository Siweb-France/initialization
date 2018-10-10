#!/bin/bash

set -euo pipefail

packages=(
cvs mailutils postfix
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
    phpVersion="php5"
else
    packagesPhp=("${packagesPhp7[@]}")
    phpVersion="php7"
fi

targetPackages=( "${packages[@]}" "${packagesPhp[@]}")

apt-get install -y "$targetPackages"


configurePhp.sh "$phpVersion"
installFirewalld.sh
installDb.sh
