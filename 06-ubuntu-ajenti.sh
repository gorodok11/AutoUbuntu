#!/bin/bash

tput setaf 2
echo "Установка Ajenti"
tput sgr0

apt-get install sysstat python-psutil

echo '# Ajenti' | sudo tee -a /etc/apt/sources.list
echo 'deb http://repo.ajenti.org/debian main main' | sudo tee -a /etc/apt/sources.list

cd /tmp
wget http://repo.ajenti.org/debian/key -O- | sudo apt-key add -
apt-get update && apt-get -y install ajenti

# Defaults:
# port:8000
# User = admin
# Password = admin
 
