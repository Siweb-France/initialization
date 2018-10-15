#!/bin/bash


sed -i -e "s/\/var\/www\/html/\/var\/www/g" /etc/apache2/sites-enabled/000-default.conf
sed -i -e "s/Options Indexes FollowSymLinks/Options -Indexes -FollowSymLinks/g" /etc/apache2/apache2.conf


wget "https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_${ARCH}.deb" \
  --output-document="/tmp/mod-pagespeed-stable_current_${ARCH}.deb"

dpkg -i "/tmp/mod-pagespeed-stable_current_${ARCH}.deb"

a2enmod rewrite
a2enmod expires
a2enmod ssl
a2enmod headers
a2enmod pagespeed

echo "# Pagespeed local defaults.
<IfModule pagespeed_module>
  ModPagespeed off
  ModPagespeedFileCachePath /var/mod_pagespeed/cache/
</IfModule>" \
  > "/etc/apache2/conf-available/pagespeed.conf"

a2enconf pagespeed

service apache2 restart
systemctl enable apache2
