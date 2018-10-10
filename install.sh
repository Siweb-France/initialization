#!/bin/bash

set -xeuo pipefail

main () {

    apt-get update
    apt-get upgrade -y
    apt-get install -y git

    gitRepo="/tmp/initialization"
    git clone git@github.com:Siweb-France/initialization.git $gitRepo
    export PATH="$PATH:$gitRepo"

    installPackages.sh
    installUser.sh
} 


main 2>&1 /tmp/initialization.log
