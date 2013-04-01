#!/bin/bash
sudo apt-get -y install mrtg snmpd
sudo mkdir /var/www/mrtg
sudo cfgmaker --global 'WorkDir:/var/www/mrtg' --global 'Options[_]: bits,growright' --output /etc/mrtg.cfg public@localhost
sudo indexmaker --output=/var/www/mrtg/index.html /etc/mrtg.cfg
