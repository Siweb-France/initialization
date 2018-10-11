#!/bin/bash

set -euo pipefail

read -p "Username ? " username
read -sp "Password ?" password

echo "mysql-server mysql-server/root_password password $password" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $password" | debconf-set-selections

apt-get install mysql-server -y
mysql -h localhost -u $username --password=$password -e "GRANT ALL PRIVILEGES ON *.* TO '$username'@'localhost' IDENTIFIED BY '$password' WITH GRANT OPTION;"
mysql -h localhost -u $username --password=$password -e "GRANT ALL PRIVILEGES ON *.* TO '$username'@'%' IDENTIFIED BY '$password' WITH GRANT OPTION;"

mv /etc/mysql/my.cnf{,.origine}
