#!/bin/bash

tput setaf 2
echo "Установка Zentyal"
tput sgr0

apt-get install -y python-software-properties

deb http://ppa.launchpad.net/zentyal/3.0/ubuntu precise main 
deb-src http://ppa.launchpad.net/zentyal/3.0/ubuntu precise main 

echo '# Zentyal' | sudo tee -a /etc/apt/sources.list
echo 'deb http://ppa.launchpad.net/zentyal/3.0/ubuntu precise main' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://ppa.launchpad.net/zentyal/3.0/ubuntu precise main' | sudo tee -a /etc/apt/sources.list
echo 'deb http://archive.zentyal.org/zentyal 3.0 main extra' | sudo tee -a /etc/apt/sources.list

cd /tmp
wget -q http://keys.zentyal.org/zentyal-3.0-archive.asc -O- | sudo apt-key add -
apt-get update
# Форсируем установку так как не нашел подходящий ключ для zentyal
apt-get -y install zentyal
#Установить эти пакеты прежде чем запустить WEB интерфейс
apt-get -y install zentyal-software zentyal-network zentyal-firewall
#Остальные модули устанавливаем тоже из консоли так как нет рабочего ключа
apt-get -y install zentyal-antivirus zentyal-ebackup zentyal-dns zentyal-bwmonitor zentyal-webserver

