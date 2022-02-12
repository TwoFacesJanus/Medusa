#!/bin/bash
set -e

ARCH_PACKAGES="python python-pip git"
DEB_PACKAGES="python3 python3-pip git"
CENT_PACKAGES="python3 python3-pip git"
GREEN='\033[1;32m'
NORMAL='\033[0m'

echo -en "==============$GREEN MEDUSA $NORMAL==============\n"

if cat /etc/*release | grep ^NAME | grep CentOS &>/dev/null; then
    echo -en "Packages: $CENT_PACKAGES"
    echo -en "\n==================================\n"
    echo -en "[ INFO ]=> Installing packages..." 

elif cat /etc/*release | grep ^NAME | grep Garuda &>/dev/null; then
    echo -en "Packages: $ARCH_PACKAGES"
    echo -en "\n==================================\n"
    echo -en "[ INFO ]=> Installing packages..." 
    sudo pacman -Sy $ARCH_PACKAGES --noconfirm &>/dev/null
    

elif cat /etc/*release | grep ^NAME | grep Arch &>/dev/null; then
    echo -en "Packages: $ARCH_PACKAGES"
    echo -en "\n==================================\n"
    echo -en "[ INFO ]=> Installing packages..." 
    sudo pacman -Sy $ARCH_PACKAGES --noconfirm &>/dev/null


elif cat /etc/*release | grep ^NAME | grep Debian &>/dev/null; then
    echo -en "Packages: $DEB_PACKAGES"
    echo -en "\n==================================\n"
    echo -en "[ \033[32mINFO ]=> Installing packages..." s
    udo apt-get update -y
    sudo apt-get install $DEB_PACKAGES -y &>/dev/null

elif cat /etc/*release | grep ^NAME | grep Ubuntu &>/dev/null; then
    echo -en "Packages: $DEB_PACKAGES"
    echo -en "\n=================================\n"
    echo -en "[ INFO ]=> Installing packages..." 
    sudo apt-get update -y &>/dev/null
    sudo apt-get install $DEB_PACKAGES -y &>/dev/null

elif cat /etc/*release | grep ^NAME | grep Fedora &>/dev/null; then
    echo -en "Packages: $CENT_PACKAGES"
    echo -en "\n==================================\n"
    echo -en "[ INFO ]=> Installing packages..." 
    sudo dnf update -y &>/dev/null

else 
    echo "Whoops..."
    exit 1;
fi

echo -en "\n[$GREEN INFO $NORMAL]=> Done.\n"

echo -en "[ INFO ]=> Downloading repository...\n"
git clone https://github.com/TwoFacesJanus/Medusa.git &>/dev/null
echo -en "[$GREEN INFO $NORMAL]=> Done.\n"

echo -en "[ INFO ]=> Installing requirements...\n"
pip3 install -r Medusa/requirements.txt &>/dev/null
echo -en "[$GREEN INFO $NORMAL]=> Done.\n"


exit 0