#!/bin/bash

vundle_get() {
    mkdir -p ~/.vim/bundle
    # Clone Vundle repository
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    
    # Create a backup of existing .vimrc file
    if [ -f ~/.vimrc ]; then
        mv ~/.vimrc ~/.vimrc.backup
    fi
    
    ln -s ~/dotfiles/vimrc ~/.vimrc
    vim +PluginInstall +qall
}

vundle_get