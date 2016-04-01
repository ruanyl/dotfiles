#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
CURRENT_DIR=`pwd`

olddir=~/dotfiles_old
files="gitconfig tmux.conf zshrc bashrc bash_profile"    # list of files/folders to symlink in homedir

# create dotfiles_old in homedir
echo "INFO: Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $CURRENT_DIR/$file ~/.$file
done

# for git_diff_wrapper
ln -s $CURRENT_DIR/git_diff_wrapper /usr/local/bin/git_diff_wrapper

source $CURRENT_DIR/installs/install_homebrew.sh

source ~/.bash_profile

source $CURRENT_DIR/installs/install_ohmyzsh.sh

source $CURRENT_DIR/installs/install_bigvim.sh

source $CURRENT_DIR/installs/install_applications.sh

source $CURRENT_DIR/installs/install_phpmysql.sh

######## change login shell
sudo echo "/usr/local/bin/zsh" >> /etc/shells
sudo chsh -s /usr/local/bin/zsh
