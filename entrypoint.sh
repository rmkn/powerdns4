#!/bin/sh

echo "select * from domains limit 1;" | sqlite3 /tmp/pdns.db
if [ $? -ne 0 ]; then
	sqlite3 /tmp/pdns.db < /usr/local/src/pdns-${PDNS_VERSION}/modules/gsqlite3backend/schema.sqlite3.sql
	chmod 666 /tmp/pdns.db
fi

/usr/sbin/httpd

exec "$@"
