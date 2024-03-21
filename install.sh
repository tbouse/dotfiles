#!/bin/bash


USERDIR=/home/$SUDO_USER

cd "$(dirname "$0")"
SCRIPTDIR="$(pwd)" 



if [[ "$(id -u)" -eq 0 ]]; then #checking if script is running with root permission
	echo "Script is running as root"
	if [[ -n "$(which apt)" ]]; then #checking if apt is installed
		echo "apt is installed"
	else
		echo "apt is not installed - exiting" 1>&2
		exit 1
	fi
else
	echo "Script is not running as root - exiting" 1>&2
	exit 1
fi

#installs necessary packages
apt_install() {
	echo "installing required packages"
	apt install -y \
		ninvaders \
		nmap \
		dnsutils \
		libgl1-mesa-glx \
		libegl1-mesa \
		libxrandr2 \
		libxss1 \
		libxcursor1 \
		libxcomposite1 \
		libasound2 \
		libxi6 \
		libxtst6
	}

# check if anaconda is installed, if not installs it
anaconda_install() {
	if [[ -d $USERDIR/anaconda3 ]]; then
		echo "Anaconda3 is already installed"
		return
	fi
	if [[ $(ls Anaconda3*.sh 2> /dev/null == head -1) ]]; then
		echo "installer found, running it..."
		bash Anaconda3-2024.02-1-Linux-x86_64.sh -b -p /home/tbouse/anaconda3
		echo "PATH=$PATH:$USERDIR/anaconda3/bin" >> $USERDIR/.profile
	else
		echo "downloading anaconda installer..."
		curl -O https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
		anaconda_install
	fi
}

apt_install
anaconda_install


bash $USERDIR/dotfiles/bashrc.sh
echo "EOF"