#!/bin/sh

install_emacs() {
    echo "Install emacs"
}

install_vim() {
    echo "Install vim"
}

install_zsh() {
    echo "Install zsh"
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

