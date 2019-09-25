#!/bin/sh

yum install vim -y

git submodule init
git submodule update


mkdir -p ~/.vim
mkdir -p ~/.vim/autoload


ln -sf `pwd`/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim
ln -sf `pwd`/bundle ~/.vim/bundle
ln -sf `pwd`/after ~/.vim/after
ln -sf `pwd`/plugin ~/.vim/plugin
ln -sf `pwd`/vimrc ~/.vimrc


