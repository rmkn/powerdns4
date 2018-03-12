#!/bin/sh

cat << EOS >> /usr/local/etc/pdns.conf
launch=gsqlite3
gsqlite3-database=/tmp/pdns.db
EOS
