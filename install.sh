#!/bin/bash

set -xeuo pipefail

{

    apt-get update
    apt-get upgrade -y
    apt-get install -y git

    gitRepo="/tmp/initialization"
    git clone git@github.com:Siweb-France/initialization.git $gitRepo
    PATH="$PATH:$gitRepo"

    installPackages.sh
} > /tmp/initialization.log 2>/tmp/initialization_error.log
