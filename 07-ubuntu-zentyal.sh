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
apt-get update && apt-get -y install zentyal
