#!/bin/sh

cp /var/www/html/inc/config-me.inc.php /var/www/html/inc/config.inc.php
chmod 666 /var/www/html/inc/config.inc.php

cat << EOS >> /usr/local/etc/pdns.conf
launch=gsqlite3
gsqlite3-database=/tmp/pdns.db
EOS
