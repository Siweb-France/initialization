#!/bin/bash

set -euo pipefail

echo "Installing Database ..."

read -p "Username ? " username
read -sp "Password ?" password

echo "Configuring passwords for root account"

echo "mysql-server mysql-server/root_password password $password" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $password" | debconf-set-selections

echo "Installing mysql server"

apt-get install mysql-server -y

echo "Configuring remote Mysql access"
mysql -h localhost -u $username --password=$password -e "GRANT ALL PRIVILEGES ON *.* TO '$username'@'localhost' IDENTIFIED BY '$password' WITH GRANT OPTION;"
mysql -h localhost -u $username --password=$password -e "GRANT ALL PRIVILEGES ON *.* TO '$username'@'%' IDENTIFIED BY '$password' WITH GRANT OPTION;"

echo "Replacing default mysql configuration"

dir="$(dirname $0)"

mv /etc/mysql/my.cnf{,.origine}
cp $dir/default_config_mysql.cnf /etc/mysql/my.cnf
for file in "/var/lib/mysql/ibdata1" "/var/lib/mysql/ib_logfile0" "/var/lib/mysql/ib_logfile1";
do
    mv $file{,.origine}
done

echo "Restarting service"

service mysql restart
systemctl enable mysql
