#!/bin/sh

    rm ~/.zshrc -rf

    # Replace 'ln -sf' by 'cp -ri'
    cp -ri `pwd`/zsh/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    cp -ri `pwd`/zsh/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    cp -ri `pwd`/zsh/autojump ~/.oh-my-zsh/custom/plugins/autojump

    rm -rf ~/.zshrc
    cp -ri $(realpath zsh/zshrc) ~/.zshrc

    cd zsh/autojump
    ./install.py


