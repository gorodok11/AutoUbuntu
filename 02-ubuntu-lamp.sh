#!/bin/bash
tput setaf 2
echo "Установка LAMP server"
tput sgr0
tasksel install lamp-server
# Установка phpMyAdmin
apt-get -y install phpmyadmin
# Для входа в phpMyAdmin используйте адрес http://server_IP/phpmyadmin
