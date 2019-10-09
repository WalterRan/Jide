#!/bin/sh

yum install zsh -y

git submodule init
git submodule update

rm ~/.oh-my-zsh -rf

curl -Lo /tmp/install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh /tmp/install.sh

rm ~/.zshrc -rf

# Replace 'ln -sf' by 'cp -ri'
cp -ri `pwd`/zsh/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
cp -ri `pwd`/zsh/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
cp -ri `pwd`/zsh/autojump ~/.oh-my-zsh/custom/plugins/autojump

cp -ri $(realpath zsh/zshrc) ~/.zshrc

cd zsh/autojump
./install.py

