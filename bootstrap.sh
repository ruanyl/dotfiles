#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################
CURRENT_DIR=`pwd`
BASEDIR=$(dirname $0)

############# check requirements
REQUIRE="ruby git"
for i in $REQUIRE
do
    command -v $i >/dev/null && continue || { echo "$i command not found."; exit 1; }
done

############# install homebrew
echo "############# install homebrew #############"
if command -v brew &>/dev/null
then
    echo "**********homebrew already installed, skip**********"
else
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

############# install dependences
echo "############# install curl #############"
brew install curl

############# install zsh
echo "############# install zsh #############"
brew install zsh

############# install oh-my-zsh
echo "############# install oh-my-zsh #############"
curl -L http://install.ohmyz.sh | sh

############# install zsh-syntax-highlighting
cd $HOME/.oh-my-zsh/plugins git clone https://github.com/zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting

# Variables
dir=~/.dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="gitconfig tmux.conf zsh-autosuggestions zshrc"    # list of files/folders to symlink in homedir

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/.$file ~/.$file
done
