#!/bin/sh

yum install zsh -y

git submodule init
git submodule update

rm ~/.oh-my-zsh -rf

curl -Lo /tmp/install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh /tmp/install.sh

rm ~/.zshrc -rf

ln -sf `pwd`/zsh/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ln -sf `pwd`/zsh/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
ln -sf `pwd`/zsh/autojump ~/.oh-my-zsh/custom/plugins/autojump

ln -s $(realpath zsh/zshrc) ~/.zshrc

cd zsh/autojump
./install.py

