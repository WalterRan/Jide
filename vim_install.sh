#!/bin/sh

yum install vim -y

git submodule init
git submodule update

rm -rf ~/.vim*

mkdir -p ~/.vim
mkdir -p ~/.vim/autoload

# Replace 'ln -sf' by 'cp -ri'
cp -ri `pwd`/vim/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim
cp -ri `pwd`/vim/bundle ~/.vim/bundle
cp -ri `pwd`/vim/after ~/.vim/after
cp -ri `pwd`/vim/plugin ~/.vim/plugin
cp -ri `pwd`/vim/vimrc ~/.vimrc


