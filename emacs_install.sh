#!/bin/sh

yum -y install libXpm-devel libjpeg-turbo-devel openjpeg-devel openjpeg2-devel turbojpeg-devel giflib-devel libtiff-devel gnutls-devel libxml2-devel GConf2-devel dbus-devel wxGTK-devel gtk3-devel libselinux-devel gpm-devel librsvg2-devel ImageMagick-devel libncurses-dev ncurses-devel gcc

pushd

cd /tmp

curl -O http://ftp.gnu.org/gnu/emacs/emacs-25.1.tar.gz

tar -zxvf emacs-25.1.tar.gz

cd emacs-25.1

./configure

make

make install

rm ~/.emacs.d
ln -sf `pwd`/emacs ~/.emacs.d
