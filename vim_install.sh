#!/bin/sh

yum install vim -y

git submodule init
git submodule update

rm -rf ~/.vim
rm -rf ~/.vimrc

mkdir -p ~/.vim
mkdir -p ~/.vim/autoload


ln -sf `pwd`/vim/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim
ln -sf `pwd`/vim/bundle ~/.vim/bundle
ln -sf `pwd`/vim/after ~/.vim/after
ln -sf `pwd`/vim/plugin ~/.vim/plugin
ln -sf `pwd`/vim/vimrc ~/.vimrc


