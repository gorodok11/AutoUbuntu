#!/bin/bash

# Чистим экран
tput clear

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
echo "_______________________________________________________"

#tput sgr0
 
tput cup 12 17
# Set reverse video mode
tput rev
echo "M A I N - M E N U"
tput sgr0
 
tput cup 14 15
echo "1. Autoinstall Ubuntu."
 
tput cup 15 15
echo "2. Exit."
 
# Set bold mode
tput bold
tput cup 17 15
read -p "Enter your choice [1-2] " choice
 
tput clear
tput sgr0
tput rc
