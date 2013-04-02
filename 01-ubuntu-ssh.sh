#!/bin/bash
# Установка OpenSSH-server
sudo apt-get -y install openssh-server 

# Просмотр настроек, убрав пустые строки и комментарии:
# egrep -v '^#' /etc/ssh/sshd_config | egrep -v '^$'

# Добавляем группу для пользователей ssh
sudo addgroup --gid 450 sshlogin

#echo $(date) $SSH_CONNECTION $USER $SSH_TTY >> /var/log/sshd_connect
sudo /etc/init.d/ssh start
