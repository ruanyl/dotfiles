#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################
CURRENT_DIR=`pwd`
BASEDIR=$(dirname $0)

############# install requirements
if [ "$(uname)" == "Darwin" ]; then
    ############# install homebrew
    echo "############# install homebrew #############"
    if command -v brew &>/dev/null
    then
        echo "**********homebrew already installed, skip**********"
    else
        ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    fi
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev
    ruby -e "$(wget -O- https://raw.github.com/Homebrew/linuxbrew/go/install)"
    echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >> $HOME/.bashrc
    echo 'export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"' >> $HOME/.bashrc
    source $HOME/.bashrc
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
cd $HOME/.oh-my-zsh/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting

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
    ln -s $dir/$file ~/.$file
done

# for git_diff_wrapper
ln -s $dir/git_diff_wrapper /usr/local/bin/git_diff_wrapper

######## change login shell
if [ "$(uname)" == "Darwin" ]; then
    sudo echo "/usr/local/bin/zsh" >> /etc/shells
    sudo chsh -s /usr/local/bin/zsh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo echo  $HOME/.linuxbrew/bin/zsh >> /etc/shells
    sudo chsh -s $HOME/.linuxbrew/bin/zsh
fi
