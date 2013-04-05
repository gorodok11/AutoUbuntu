#!/bin/bash
# Gorodok11
# Часть кода заимствована с других открытых проектов которые указаны ниже
# AutoSnort: https://github.com/da667/Autosnort
# Triptych Security - Tony Robinson/da_667
# twitter: @da_667
# email: deusexmachina667@gmail.com

source 00-functions.sh

# Необходимо проверить OS на которой работаем, подключение к сети, пользователя под которым работаем, 
# удостоверимся что sshd работает и wget доступен.

# Проверяет версию ОС.
# Отображаем меню установки

tput clear

# Move cursor to screen location X,Y (top left is 0,0)
tput cup 1 0
# Created with http://patorjk.com/software/taag/

tput setaf 4
echo "       _         _        ____              _          "
echo "      / \  _   _| |_ ___ | __ ) _   _ _ __ | |_ _   _  "
echo "     / _ \| | | | __/ _ \|  _ \| | | | '_ \| __| | | | "
echo "    / ___ \ |_| | || (_) | |_) | |_| | | | | |_| |_| | "
echo "   /_/   \_\__,_|\__\___/|____/ \__,_|_| |_|\__|\__,_| "
echo "                                                       "
echo "             Igor Frunza gorodok11@gmail.com           "
echo "                          2013                         "
echo "_______________________________________________________"

tput sgr0

tput cup 12 0
# Set bold mode
tput bold
echo "Это скрипт автоматической установки набора программ под "
echo "Ubuntu Server 12.04 для использования в качестве шлюза  "
echo "интернет."

while true; do
     read -p "Приступить к установке? (y/n)" warncheck
     case $warncheck in
          [Yy]* ) break;;
          [Nn]* ) echo "Отмена."; exit;;
          * ) tput setaf 1;  echo "Пожалуйста ответьте да или нет."; tput sgr0;;
     esac
done

tput clear
tput sgr0
tput rc

tput cup 0 0
tput setaf 2
echo "Приступаем к установке..."
tput sgr0

tput clear
#_______________________________________________________________________

tput setaf 2
echo "Проверка версии ОС..."
tput sgr0
     release=`lsb_release -r|awk '{print $2}'`
     if [ $release = "12.04" -o $release = "12.10" ]
          then
                   tput setaf 2
  		   echo "Проверка ОС успешна."
                   tput sgr0
          else
               tput setaf 1
               echo "Это не Ubuntu 12.04 или 12.10, скрипт не был протестирован на других платформах."
               tput sgr0
               while true; do
                   read -p "Продолжить? (y/n)" warncheck
                   case $warncheck in
                       [Yy]* ) break;;
                       [Nn]* ) echo "Отмена."; exit;;
                       * ) echo "Пожалуйста ответьте да или нет.";;
                   esac
				done
		echo " "
     fi
tput clear
#_______________________________________________________________________

tput setaf 2
echo "Проверка соединения с интернетом (ping google.com)..."
tput sgr0
     ping google.com -c1 2>&1 >> /dev/null
     if [ $? -eq 0 ]; then
          tput setaf 2
          echo "Соединение с интернетом установлено!"
          tput sgr0
     else
          tput setaf 1
          echo "При проверке связи не удалось обнаружить узел google.com. Пожалуйста проверьте соединение с интернетом или что исходящий ICMP разрешен."
   	  tput sgr0
          exit 1
     fi

#_______________________________________________________________________

tput setaf 2
echo "Проверка пользователя..."
tput sgr0
        if [ $(whoami) != "root" ]
          then
              tput setaf 1 
              echo "Скрипт должен быть запущен с sudo или root правами, иначе не будет работать."
              tput sgr0
  	exit 1
          else
               tput setaf 2 
               echo "Есть полные права."
               tput sgr0
     fi

#_______________________________________________________________________

tput setaf 2 
echo "Проверяем если sshd работает..."
tput sgr0
  if [ $(/bin/ps -ef |/bin/grep sshd |/usr/bin/wc -l) -gt 1 ]
		then
                        tput setaf 2
			echo "sshd работает "
                        tput sgr0
		else
                        tput setaf 3
	 		echo "sshd не работает. Установку можно продолжать, но часто sshd требуется для удаленной настройки snort."
                        tput sgr0
	fi

#_______________________________________________________________________

tput setaf 2
echo  "Проверяем установку wget"
tput sgr0
/usr/bin/which wget 2>&1 >> /dev/null
		if [ $? -ne 0 ]; then

        		echo "wget не найден. Установить wget?"

         case $wget_install in
                                [yY] | [yY][Ee][Ss])
				install_packages wget
                                ;;
                                *)
                                tput setaf 1
                                echo "Wget необходим для продолжения. Выход."
                                tput sgr0
                                exit 1
                                ;;
                                esac
		else
                        tput setaf 2
        		echo "wget найден."
                        tput sgr0
		fi
#_______________________________________________________________________

tput setaf 2
echo "Запуск apt-get update и apt-get upgrade..."
tput sgr0
apt-get update && apt-get -y upgrade 
if [ $? -eq 0 ]; then
  tput setaf 2
  echo "Система полностью обновлена."
  tput sgr0
else
  tput setaf 1
  echo "Сбой при обновлении системы."
  tput sgr0
fi

#_______________________________________________________________________

#bash 00-ubuntu-base.sh
#bash 01-ubuntu-ssh.sh
#bash 02-ubuntu-lamp.sh
#bash 03-ubuntu-webmin.sh
#bash 05-ubuntu-snort.sh
#bash 06-ubuntu-ajenti.sh
