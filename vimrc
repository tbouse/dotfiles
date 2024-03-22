set nocompatible              " be iMproved, required
filetype off                  " required

" Vundle settings
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Add your plugins here
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'valloric/youcompleteme'
Plugin 'nanotech/jellybeans.vim'

call vundle#end()
filetype plugin indent on    " required

colorscheme morning