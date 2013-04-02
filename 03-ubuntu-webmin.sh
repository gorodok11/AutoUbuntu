#!/bin/bash
# Установка WebMin
sudo apt-get -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl libdigest-md5-perl
echo '# Webmin' | sudo tee -a /etc/apt/sources.list
echo 'deb http://download.webmin.com/download/repository sarge contrib' | sudo tee -a /etc/apt/sources.list
cd /tmp
wget http://www.webmin.com/jcameron-key.asc
sudo apt-key add jcameron-key.asc
rm jcameron-key.asc
sudo apt-get install webmin
sudo apt-get update && apt-get -y install webmin
# Для входа в WebMin используйте адрес https://server_IP:10000
