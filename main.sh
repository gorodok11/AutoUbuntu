#!/bin/bash
sudo su
sudo apt-get update
sudo apt-get upgrade
bash ubuntu-base.sh
bash ubuntu-snort.sh
bash ubuntu-ossim.sh
