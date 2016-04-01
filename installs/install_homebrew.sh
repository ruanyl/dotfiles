echo " ********************************************************"
echo " ************ INFO: start install homebrew **************"
echo " ********************************************************"

if command -v brew &>/dev/null
then
    echo "INFO: homebrew already installed, SKIP"
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install dependences
brew tap homebrew/dupes
brew tap homebrew/versions

brew install cmake
brew install ctags
brew install ag
brew install curl
brew install zsh
brew install vim --with-lua
brew install nvm
