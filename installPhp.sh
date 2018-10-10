#!/bin/bash

set -euo pipefail

if test "$#" -lt 1; then
    >&2 echo "Usage $0 : phpversionname"
    exit 1;
fi

phpVersion="$1"
if test "$phpVersion" == "php7.0"
then
    phpIni="/etc/php/7.0/apache2/php.ini"
    cliIni="/etc/php/7.0/cli/php.ini"
else
    phpIni="/etc/$phpVersion/apache2/php.ini"
    cliIni="/etc/$phpVersion/cli/php.ini"
fi

replacements=();
replacements+=("s/short_open_tag = Off/short_open_tag = On/g")
replacements+=("s/display_errors = Off/display_errors = On/g")
replacements+=("s/memory_limit = 128M/memory_limit = 1024M/g")
replacements+=("s/upload_max_filesize = 2M/upload_max_filesize = 20M/g")
replacements+=("s/post_max_size = 8M/post_max_size = 20M/g")
replacements+=("s/display_startup_errors = Off/display_startup_errors = On/g")
replacements+=("s/error_reporting = E_ALL \& ~E_DEPRECATED \& ~E_STRICT/error_reporting = E_ALL \& ~E_NOTICE \& ~E_DEPRECATED \& ~E_STRICT \& ~E_WARNING/g")

phpReplacement=$(printf ";%s" "${replacements[@]}")
phpReplacement="${phpReplacement:1}"

sed -Ei "$phpReplacement" "$phpIni"
