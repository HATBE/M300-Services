#!/bin/bash

# Aaron Gensetter M300

# TODO: make shared folder with config ".env?" with all Pws and Installation settings
MYSQL_ROOT_PW="Password123"
MYSQL_NEXTCLOUD_PW="Password123"
MYSQL_NEXTCLOUD_USER="ncuser"
MYSQL_NEXTCLOUD_DB="nextcloud"

apt update -y
apt upgrade -y

apt install mariadb-server mariadb-client -y

sed -e '/bind-address            = 127.0.0.1/ s/^#*/#/' -i /etc/mysql/mariadb.conf.d/50-server.cnf # comment out the bind adress, to open it to public
systemctl restart mariadb

## Install / Configure MariaDB
mysql -e "UPDATE mysql.user SET plugin='mysql_native_password' WHERE User='root';" # make shure the user can login, with the right plugin
mysql -e "UPDATE mysql.user SET Password = PASSWORD('${MYSQL_ROOT_PW}') WHERE User = 'root';" # Set a password for The root user
mysql -e "DROP USER IF EXISTS ''@'localhost';" # Remove the Anonymous User
mysql -e "DROP USER IF EXISTS ''@'$(hostname)';"
mysql -e "DROP DATABASE IF EXISTS test;" # Remove the Demo database

## Nextcloud DB
mysql -e "CREATE DATABASE ${MYSQL_NEXTCLOUD_DB};"
mysql -e "CREATE USER '${MYSQL_NEXTCLOUD_USER}'@'%' IDENTIFIED BY '${MYSQL_NEXTCLOUD_PW}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_NEXTCLOUD_DB}.* to '${MYSQL_NEXTCLOUD_USER}'@'%';"

mysql -e "FLUSH PRIVILEGES;"
