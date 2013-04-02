#!/bin/bash
# Установка базовой системы с автоматической разметкой
# После перезагрузки заходим по Администатором системы
# Обновление базовой системы
sudo su
sudo apt-get update && apt-get upgrade
# Установка программ для легкой работы в консоли
sudo apt-get -y install htop mc aptitude zip unzip
# Установка OpenSSH-server
sudo apt-get -y install openssh-server && sudo /etc/init.d/ssh start

