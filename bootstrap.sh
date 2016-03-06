#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
CURRENT_DIR=`pwd`
BASEDIR=$(dirname $0)

echo "INFO: start install homebrew #############"
if [ "$(uname)" == "Darwin" ]; then
    if command -v brew &>/dev/null
    then
        echo "INFO: homebrew already installed, SKIP"
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

# install dependences
brew install curl
brew install zsh
curl -L http://install.ohmyz.sh | sh

# install zsh-syntax-highlighting
cd $HOME/.oh-my-zsh/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting

dir=$CURRENT_DIR
olddir=~/dotfiles_old
files="gitconfig tmux.conf zsh-autosuggestions zshrc"    # list of files/folders to symlink in homedir

# create dotfiles_old in homedir
echo "INFO: Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "INFO: Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir
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
