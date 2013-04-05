#!/bin/bash
tput setaf 2
echo "Установка Zabbix"
tput sgr0

echo '# Zabbix' | sudo tee -a /etc/apt/sources.list
echo 'deb http://ppa.launchpad.net/tbfr/zabbix/ubuntu precise main' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://ppa.launchpad.net/tbfr/zabbix/ubuntu precise main' | sudo tee -a /etc/apt/sources.list
cd /tmp
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C407E17D5F76A32B
sudo apt-get update
apt-get install zabbix-server-mysql zabbix-frontend-php

while true; do
  echo "Please enter a password for the zabbix database user."
	read -s -p "Please enter the zabbix database user password:" MYSQL_PASS_1
	echo ""
	read -s -p "Confirm:" mysql_pass_2
	echo ""
	if [ "$MYSQL_PASS_1" == "$mysql_pass_2" ]; then
		echo "password confirmed."
		echo ""
		export MYSQL_PASS_1
		break
	else
		echo ""
		echo -e "Passwords do not match. Please try again."
		continue
	fi
done

echo "the next several steps will need you to enter the mysql root user password more than once."
echo ""

#1. create the database.

while true; do
  echo "enter the mysql root user password to create the zabbix database."
	mysql -u root -p -e "create database zabbix;"
	if [ $? != 0 ]; then
		echo "the command did NOT complete successfully. (bad password?) Please try again."
		continue
	else
		echo "zabbix database created!"
		break
	fi
done

#2. Add the schema
cd /usr/share/zabbix-server-mysql/
gunzip *.gz

while true; do
  echo "enter the mysql root user password again to create the zabbix database schema"
	mysql -u root -p -D zabbix < schema.sql
  mysql -u root -p -D zabbix < images.sql
	mysql -u root -p -D zabbix < data.sql
  if [ $? != 0 ]; then
		echo "the command did NOT complete successfully. (bad password?) Please try again."
		continue
	else
		echo "zabbix database schema created!"
		break
	fi
done

cd /root

#3. Grant the snort database user permissions to do what is necessary to maintain the database.

while true; do
  echo "you'll need to enter the mysql root user password one more time to create the zabbix database user and grant it permissions to the snort database."
	mysql -u root -p -e "grant create, insert, select, delete, update on zabbix.* to zabbix@localhost identified by '$MYSQL_PASS_1';"
	if [ $? != 0 ]; then
		echo "the command did NOT complete successfully. (bad password?) Please try again."
		continue
	else
		echo "zabbix database user created!"
		break
	fi
done













