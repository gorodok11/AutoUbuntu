#!/bin/bash
#Для начала нам нужно скачать пакет, соответствующий нашей архитектуре. Для этого перейдем на страницу скачивания.
#http://www.tenable.com/products/nessus/select-your-operating-system
#Сохраняем пакет в директорию /root

sudo apt-get -y install libqt4-core libqt4-gui libqtcore4 libqt4-network libqt4-script libqt4-xml libqt4-dbus libqt4-test libqtgui4 libqt4-svg libqt4-opengl libqt4-designer libqt4-assistant
#Заходим в каталог /root где сохранили установочный пакет nessus
cd /root
sudo dpkg -i Nessus-*amd64.deb
sudo /etc/init.d/nessusd start

#Регистрируемся на сайте http://www.nessus.org/plugins/index.php?view=register
#После получения кода активации, регистрируем nessus следующей командой:
# sudo /opt/nessus/bin/nessus-fetch --register x1xx-9xx1-9x8x-xxxx-6x3x
# /opt/nessus/sbin/nessus-update-plugins
# Создаем сертификат
# /opt/nessus/sbin/nessus-mkcert
# Добавим нового пользователя 
# /opt/nessus/sbin/nessus-adduser
# Перезапускаем службу
# /etc/init.d/nessusd restart
# Запускаем клиент
# /opt/nessus/bin/NessusClient
