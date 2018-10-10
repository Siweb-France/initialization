#!/bin/bash

set -xeuo pipefail

main () {

    apt-get update
    apt-get upgrade -y
    apt-get install -y git apt-utils

    gitRepo="/tmp/initialization"
    git clone https://github.com/Siweb-France/initialization.git $gitRepo
    export PATH="$PATH:$gitRepo"

    runInstall.sh
} 


main 2>&1 | tee /tmp/initialization.log
