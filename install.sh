#!/bin/sh

# Exit the script if an error happens
set -e
PWD=$(pwd)

run_with_error_check() {
    if ! $@; then
        echo "Error executing command: $@"
        exit 1
    fi
}

check_software_installed() {
    local software_name=$1
    if ! command -v "$software_name" >/dev/null 2>&1; then
        echo "Error: $software_name is not installed."
        exit 1
    fi
}

function safe_delete() {
    item="$1"
    if [ -L "$item" ]; then
        echo "Removing symbolic link: $item"
        rm -f "$item" || handle_error
    else
        echo "Deleting file/directory: $item"
        rm -rf "$item" || handle_error
    fi
}

install_emacs() {
    echo "Install emacs"

    current_path=$(pwd)

    yum -y install libXpm-devel libjpeg-turbo-devel openjpeg-devel openjpeg2-devel turbojpeg-devel giflib-devel libtiff-devel gnutls-devel libxml2-devel GConf2-devel dbus-devel wxGTK-devel gtk3-devel libselinux-devel gpm-devel librsvg2-devel ImageMagick-devel libncurses-dev ncurses-devel gcc global

    # Install emacs
    cd /tmp

    curl -O http://ftp.gnu.org/gnu/emacs/emacs-27.1.tar.gz

    tar -zxvf emacs-27.1.tar.gz

    cd emacs-27.1

    ./configure

    make

    make install

    rm -rf ~/.emacs.d

    # Install python lsp for emacs
    yum -y install python3 python3-devel python3-pip

    pip3 install pipenv

    pipenv install 'python-language-server[all]'

    # Update configrations
    cd $current_path
    cp -ri ./emacs ~/.emacs.d

    echo "TODO: Get plantuml.jar and put to ~/.emacs.d/"
}

install_vim() {
    check_software_installed vim

    if [ -n "$(find ~ -maxdepth 1 -name '.vim*' -print -quit)" ]; then
        find ~/.vim* -print
        read -p "Are you sure you want to delete these files and directories? (y/N) " confirm
        if [ "$confirm" = "y" ]; then
            # For each match, check if it is a symbolic link and handle appropriately
            for item in ~/.vim*; do
                safe_delete "$item"
            done
            echo "All matches of ~/.vim* have been deleted."
        else
            echo "Canceling deletion operation."
            exit 1
        fi
    fi
    echo "Starting to install..."

    run_with_error_check git submodule init vim/bundle/Vundle.vim
    run_with_error_check git submodule update vim/bundle/Vundle.vim

    mkdir -p ~/.vim
    cp -r "$PWD"/vim/bundle ~/.vim/bundle
    cp "$PWD"/vim/vimrc ~/.vimrc
    vim +PluginInstall +qall || echo "Fail to install vim plugins, try run 'vim +PluginInstall +qall' manually."

    cd "$PWD"
}

install_zsh() {
    echo "Install zsh"
    current_path=$(pwd)

    yum install zsh -y

    git submodule init
    git submodule update

    rm ~/.oh-my-zsh -rf

    sh -c "$(curl -fsSL https://install.ohmyz.sh/)"

    rm ~/.zshrc -rf

    # Replace 'ln -sf' by 'cp -ri'
    cp -ri `pwd`/zsh/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    cp -ri `pwd`/zsh/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    cp -ri `pwd`/zsh/autojump ~/.oh-my-zsh/custom/plugins/autojump

    rm -rf ~/.zshrc
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
        install_vim
        install_emacs
        install_zsh
        ;;

    *)
        echo "Usage: $0 {emacs|vim|zsh|all} 1>&2"
        exit 1
esac

