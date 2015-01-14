#!/bin/bash

# source the config file
. ../Doorman.conf

# request a MySQL password from the user
cp scripts/createMySQLUser.sql.default /tmp
sed -i.bak s/PASSWD/$MYSQL_PWD/g /tmp/createMySQLUser.sql.default

mv /tmp/createMySQLUser.sql.default scripts/createMySQLUser.sql
rm /tmp/createMySQLUser.sql.default.bak


