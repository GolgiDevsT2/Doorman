#!/bin/bash

# request a MySQL password from the user
cp scripts/createMySQLUser.sql.default /tmp
sed -i.bak s/PASSWD/`cat Doorman.mysql.passwd | tr -d ' '`/g /tmp/createMySQLUser.sql.default

mv /tmp/createMySQLUser.sql.default scripts/createMySQLUser.sql
rm /tmp/createMySQLUser.sql.default.bak


