#!/bin/sh

install_emacs() {
    echo "Install emacs"

    current_path=$(pwd)

    yum -y install libXpm-devel libjpeg-turbo-devel openjpeg-devel openjpeg2-devel turbojpeg-devel giflib-devel libtiff-devel gnutls-devel libxml2-devel GConf2-devel dbus-devel wxGTK-devel gtk3-devel libselinux-devel gpm-devel librsvg2-devel ImageMagick-devel libncurses-dev ncurses-devel gcc

    cd /tmp

    curl -O http://ftp.gnu.org/gnu/emacs/emacs-25.1.tar.gz

    tar -zxvf emacs-25.1.tar.gz

    cd emacs-25.1

    ./configure

    make

    make install

    rm -rf ~/.emacs.d

    cd $current_path
    cp -ri ./emacs ~/.emacs.d
}

install_vim() {
    echo "Install vim"
    current_path=$(pwd)

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

    cd $current_path
}

install_zsh() {
    echo "Install zsh"
    current_path=$(pwd)

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

    cd $current_path
}

case "$1" in
    emacs)
        install_emacs
        ;;

    vim)
        install_vim
        ;;

    zsh)
        install_zsh
        ;;

    all)
        install_zsh
        install_vim
        install_emacs
        ;;

    *)
        echo "Usage: $0 {emacs|vim|zsh|all} 1>&2"
        exit 1
esac

