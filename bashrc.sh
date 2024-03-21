#!/bin/bash

bashrc() {
	#clear commands
	echo 'alias c="clear"' >> /home/$SUDO_USER/.bashrc
	echo 'alias cl="clear"' >> /home/$SUDO_USER/.bashrc
	echo 'alias ckear="clear"' >> /home/$SUDO_USER/.bashrc
	echo 'alias clr="clear"' >> /home/$SUDO_USER/.bashrc
	#history commands
	echo 'alias h="history"' >> /home/$SUDO_USER/.bashrc
	echo 'alias h1="history 10"' >> /home/$SUDO_USER/.bashrc
	echo 'alias h2="history 20"' >> /home/$SUDO_USER/.bashrc
	echo 'alias h3="history 30"' >> /home/$SUDO_USER/.bashrc
	echo 'alias hgrep='history | grep'' >> /home/$SUDO_USER/.bashrc
	#cd commands
	echo 'alias .="cd .."'  >> /home/$SUDO_USER/.bashrc
	echo 'alias ..="cd ../.."'  >> /home/$SUDO_USER/.bashrc
	echo 'alias ...="cd ../../.."'  >> /home/$SUDO_USER/.bashrc
	echo 'alias ....="cd ../../../.."'  >> /home/$SUDO_USER/.bashrc
	echo 'alias .....="cd ../../../../.."'  >> /home/$SUDO_USER/.bashrc
	#exit commands
	echo 'alias :q="exit"'  >> /home/$SUDO_USER/.bashrc
	echo 'alias ext="exit"'  >> /home/$SUDO_USER/.bashrc
	echo 'alias xt="exit"'  >> /home/$SUDO_USER/.bashrc
	echo 'alias by="exit"'  >> /home/$SUDO_USER/.bashrc
	echo 'alias bye="exit"'  >> /home/$SUDO_USER/.bashrc
	echo 'alias die="exit"'  >> /home/$SUDO_USER/.bashrc
	echo 'alias quit="exit"'  >> /home/$SUDO_USER/.bashrc

	# Expand the history size
	export HISTFILESIZE=10000
	export HISTSIZE=500

	# Set the default editor
	export EDITOR=vim
	export VISUAL=vim
}

bashrc
