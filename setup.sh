#!/bin/bash


# Update May 4 2014 IMPORANT:
# You may find your .bashrc is not sourced when you create a new user on ubuntu
# This is because you have to set the user's default shell to bash!

cd ${HOME}

new_dir=dotfiles
old_dir=dotfiles.old

if [ -d ./${new_dir}/ ] ; then
    mv ${new_dir} ${old_dir}
else
    mkdir ${old_dir}
fi

git clone https://github.com/iven2/dotfiles

create_sym_link() {
# ln -sb original_file sym_link
# above will work on ubuntu but not on osx
# -s == --symbolic on ubuntu
# -b == --backup on ubuntu

# -f is testing file existence
# -d is testing directory existence
# -L is testing symbolic link existence
# see "man test" for detail
    if [ -f ${1} ] || [ -d ${1} ] || [ -L ${1} ]
    then
	mv ${1} ${old_dir}/${1}.old
    fi
    ln -s ${new_dir}/${1} .
}

create_sym_link .screenrc
create_sym_link .bash_profile
create_sym_link .bashrc
create_sym_link .bashrc_custom
create_sym_link .dir_colors
create_sym_link .emacs.d
create_sym_link .byobu

# purge old emacs (AVOIDING this due to fragile server setup of MicroFuge for now)
# sudo apt-get update
# sudo apt-get install
# sudo apt-get purge emacs emacs-snapshot-common emacs-snapshot-bin-common emacs-snapshot emacs-snapshot-el emacs-snapshot-gtk emacs23 emacs23-bin-common emacs23-common emacs23-el emacs23-nox emacs23-lucid auctex apel emacs24 emacs24-bin-common emacs24-common emacs24-common-non-dfsg

# Install emacs (This works for ubuntu version higher than 14.04)
sudo apt-get -y install emacs24

# Install emacs24 (OLD VERSION: Need this for ubuntu version lower than 14.04)
# https://launchpad.net/~cassou/+archive/emacs
# python-software-properties must be installed because add-apt-repository is provided by it
# sudo apt-get install python-software-properties
# sudo apt-get install software-properties-common
# sudo add-apt-repository -y ppa:cassou/emacs
# sudo apt-get -qq update
# sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg
