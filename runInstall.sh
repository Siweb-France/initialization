#!/bin/bash

set -euxo pipefail

installPackages.sh
installUser.sh
installSsh.sh
installCrontab.sh
installBackups.sh
installApache.sh
