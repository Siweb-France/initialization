#!/bin/bash

set -xeuo pipefail

main () {

    apt-get update
    apt-get upgrade -y
    apt-get install -y git apt-utils

    cd /usr/local/bin
    git clone https://github.com/Siweb-France/initialization.git
    git clone https://github.com/Siweb-France/migrate.git
    git clone https://github.com/Siweb-France/maintain.git
    export PATH="$PATH:/usr/local/bin/initialization"

    runInstall.sh
} 


main 2>&1 | tee /tmp/initialization.log


# apt-get update && apt-get upgrade -y && apt-get install curl -y && curl https://raw.githubusercontent.com/Siweb-France/initialization/master/install.sh | bash

