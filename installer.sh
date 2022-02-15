#!/bin/bash
set -e

PACKAGES=NONE
GIT_REPOSITORY="https://github.com/TwoFacesJanus/Medusa.git"
DEPENDENCIES="google-cloud-dialogflow\n  |               configparser\n  |               pyttsx3\n"
GREEN='\033[1;32m'
NORMAL='\033[0m'

DISTRO=NONE
clear

function banner(){
    echo -en "<========$GREEN MEDUSA $NORMAL========>\n"
    echo -en "  | Author: TwoFacesJanus\n"
    echo -en "  | Github: https://github.com/TwoFacesJanus/Medusa\n"
    echo -en "  | License: MIT\n"
    echo -en "  | -------------------------\n" 
}




function CurrentDistro(){

    if cat /etc/*release | grep ^NAME | grep CentOS &>/dev/null; then
        DISTRO="cent"
        PACKAGES="python3 python3-pip git"

    elif cat /etc/*release | grep ^NAME | grep Garuda &>/dev/null; then
        DISTRO="arch"
        PACKAGES="python python-pip git"
        
    elif cat /etc/*release | grep ^NAME | grep Arch &>/dev/null; then
        DISTRO="arch"
        PACKAGES="python python-pip git"

    elif cat /etc/*release | grep ^NAME | grep Debian &>/dev/null; then
        DISTRO="debian"
        PACKAGES="python3 python3-pip git"

    elif cat /etc/*release | grep ^NAME | grep Ubuntu &>/dev/null; then
        DISTRO="debian"
        PACKAGES="python3 python3-pip git"

    elif cat /etc/*release | grep ^NAME | grep Fedora &>/dev/null; then
        DISTRO="cent"
        PACKAGES="python3 python3-pip git"


    else 
        echo "Whoops..."
        exit 1;
    fi
}

banner
CurrentDistro

echo "  | Distro: $DISTRO" 
echo "  | Packages: $PACKAGES"
echo -en "  | Dependencies: $DEPENDENCIES"
echo "  |"
echo -en "  | [$GREEN INFO $NORMAL]=> Installing packages...\n"
echo -en "  | "

case $DISTRO in

    "cent")
        echo "cent"
        sudo dnf update -y $PACKAGES &>/dev/null
        ;;
    
    "arch")
        sudo pacman -Sy $PACKAGES --noconfirm &>/dev/null
        ;;
esac

echo -en "\n  | [$GREEN INFO $NORMAL]=> Downloading repository..."
git clone $GIT_REPOSITORY &>/dev/null

echo -en "\n  | [$GREEN INFO $NORMAL]=> Installing Dependencies..."
pip3 install -r Medusa/requirements.txt &>/dev/null
echo -en "\n  | [$GREEN INFO $NORMAL]=> Done\n"

echo -en "\n  | [$GREEN INFO $NORMAL]=> Testing Libraries..."
python3 Medusa/tests/dependencies.py
echo -en "\n  | [$GREEN INFO $NORMAL]=> Done\n"
echo -en "<=========================>\n"



