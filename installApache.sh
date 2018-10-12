#!/bin/bash

a2enmod rewrite
a2enmod expires
a2enmod ssl
a2enmod headers

sed -i -e "s/\/var\/www\/html/\/var\/www/g" /etc/apache2/sites-enabled/000-default.conf
sed -i -e "s/Options Indexes FollowSymLinks/Options -Indexes -FollowSymLinks/g" /etc/apache2/apache2.conf

service apache2 restart
systemctl enable apache2
