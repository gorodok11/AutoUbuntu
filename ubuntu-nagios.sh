#!/bin/bash
sudo apt-get -y install nagios3
sudo sed -i "s/check\_external\_commands\=0/check\_external\_commands\=1/" /etc/nagios3/nagios.cfg
sudo service apache2 restart
#Редактировать файл /etc/group
#Строку nagios:x:114 (примерно) надо менять на nagios:x:114:www-data
#sudo sudo sed -i "s/nagios:x:119:/nagios:x:119:/" /etc/group

sudo chmod g+x /var/lib/nagios3/rw
sudo chmod g+x /var/lib/nagios3
sudo service nagios3 restart
