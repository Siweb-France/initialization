#!/bin/bash

set -euo pipefail

if test "$#" -lt 2;
then
    >&2 echo "Error: Usage: $0 username password"
    exit 1;
fi

username="$1"
password="$2"

echo "mysql-server mysql-server/root_password password $password" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $password" | debconf-set-selections

apt-get install mysql-server -y
mysql -h localhost -u $username --password=$password -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$password' WITH GRANT OPTION;"
mysql -h localhost -u $username --password=$password -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$password' WITH GRANT OPTION;"

mv /etc/mysql/my.cnf{,.origine}
