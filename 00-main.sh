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

echo "Проверка версии ОС..."
     release=`lsb_release -r|awk '{print $2}'`
     if [ $release = "12.04" -o $release = "12.10" ]
          then
  		   echo "Проверка ОС успешна."
               
          else
               echo "Это не Ubuntu 12.04 или 12.10, скрипт не был протестирован на других платформах."
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

# Проверка соединения с интернетом
echo "Проверка соединения с интернетом (ping google.com)..."
     ping google.com -c1 2>&1 >> /dev/null
     if [ $? -eq 0 ]; then
          echo "Соединение с интернетом установлено!"
     else
          echo "При проверке связи не удалось обнаружить узел google.com. Пожалуйста проверьте соединение с интернетом или что исходящий ICMP разрешен."
   	  exit 1
     fi

# Проверка пользователя под которым запускался скрипт
echo "Проверка пользователя..."
     if [ $(whoami) != "root" ]
          then
               echo "Скрипт должен быть запущен с sudo или root правами, иначе не будет работать."
  	exit 1
          else
               echo "Есть полные права."
     fi

# Проверка службы sshd
echo "Проверяем если sshd работает..."

  if [ $(/bin/ps -ef |/bin/grep sshd |/usr/bin/wc -l) -gt 1 ]
		then
			echo "sshd работает "
		else
			echo "sshd не работает. Установку можно продолжать, но часто sshd требуется для удаленной настройки snort."
	fi

# Проверяем установку wget
/usr/bin/which wget 2>&1 >> /dev/null
		if [ $? -ne 0 ]; then
        		echo "wget не найден. Установить wget?"
         case $wget_install in
                                [yY] | [yY][Ee][Ss])
				install_packages wget
                                ;;
                                *)
                                echo "Wget необходим для продолжения. Выход."
                                exit 1
                                ;;
                                esac
		else
        		echo "wget найден."
		fi


echo "Запуск apt-get update и apt-get upgrade..."

apt-get update && apt-get -y upgrade 
if [ $? -eq 0 ]; then
  echo "Система полностью обновлена."
else
	echo "Сбой при обновлении системы."
fi

bash 00-ubuntu-base.sh
bash 01-ubuntu-ssh.sh

bash ubuntu-snort.sh
bash ubuntu-ossim.sh
bash ubuntu-nagios.sh
bash ubuntu-opsview.sh
