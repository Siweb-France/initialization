#!/bin/bash

set -euo pipefail

apt-get update
apt-get upgrade -y
apt-get install git

gitRepo="/tmp/initialization"
git clone git@github.com:Siweb-France/initialization.git $gitRepo
PATH="$PATH:$gitRepo"

cleanup(){
    rm -rf $gitRepo
}

trap cleanup EXIT;

installPackages.sh

mv /etc/mysql/my.cnf{,.origine}


