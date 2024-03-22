#!/bin/bash


USERDIR=/home/$SUDO_USER

cd "$(dirname "$0")"
SCRIPTDIR="$(pwd)" 

echo "USERDIR: $USERDIR"


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
		unzip \
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
		bash Anaconda3-2024.02-1-Linux-x86_64.sh -b -p $USERDIR/anaconda3
		echo "PATH=$PATH:$USERDIR/anaconda3/bin" >> $USERDIR/.profile
	else
		echo "downloading anaconda installer..."
		curl -O https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
		anaconda_install
	fi
}

#install AWS CLI
awscli_install() {
	# Check if AWS CLI is already installed
    if command -v aws &> /dev/null; then
        echo "[INFO] AWS CLI is already installed."
        return
    fi
	if [[ -e $(ls awsdl/awscliv2.zip 2> /dev/null | head -1) ]]; then
		echo "AWS CLI V2 installer found, running it"
		unzip ./awsdl/awscliv2.zip -d awsdl/
		sudo ./awsdl/aws/install
	else
		mkdir awsdl
		curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awsdl/awscliv2.zip"
		unzip ./awsdl/awscliv2.zip -d awsdl/
		sudo ./awsdl/aws/install
	fi 
}

#install vundle
vundle_get() {
	if [ ! -d ~/.vim ]; then
    	mkdir -p ~/.vim/bundle
    	# Clone Vundle repository
    	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	fi
    
    # Create a backup of existing .vimrc file
    if [ -f ~/.vimrc ]; then
        mv ~/.vimrc ~/.vimrc.backup
    fi
    
    
    vim +PluginInstall +qall
	ln -sfb ~/dotfiles/vimrc ~/.vimrc
}
ssh_setup() {
	if [ ! -d ~/.ssh ]; then
		mkdir -p ~/.ssh
		echo "creating .ssh directory"
	fi
	ln -sfb ~/dotfiles/authorized_keys ~/.ssh/authorized_keys
	ln -sfb ~/dotfiles/ssh_config ~/.ssh/config
}

apt_install
anaconda_install
awscli_install
su $SUDO_USER 

vundle_get
ssh_setup

# bashrc link
ln -sfb ~/dotfiles/bashrc ~/.bashrc
# gitconfig link
ln -sfb ~/dotfiles/gitconfig ~/.gitconfig

