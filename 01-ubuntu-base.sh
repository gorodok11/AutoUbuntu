#!/bin/bash
# Установка базовой системы с автоматической разметкой
# После перезагрузки заходим по Администатором системы
# Обновление базовой системы
sudo su
sudo apt-get update && apt-get upgrade

# Установка программ для легкой работы в консоли
sudo apt-get -y install htop mc aptitude zip unzip

# Установка OpenSSH-server
sudo apt-get -y install openssh-server 

# Просмотр настроек, убрав пустые строки и комментарии:
# egrep -v '^#' /etc/ssh/sshd_config | egrep -v '^$'

#echo $(date) $SSH_CONNECTION $USER $SSH_TTY >> /var/log/sshd_connect
sudo /etc/init.d/ssh start

