echo " ********************************************************"
echo " ************ INFO: install applications ****************"
echo " ********************************************************"

echo ' >>> Install brew cask'
brew cask

echo ' >>> Install Applications'
brew tap caskroom/versions
brew cask install google-chrome
brew cask install sequel-pro
brew cask install licecap
brew cask install iterm2-beta
brew cask install dockertoolbox
brew cask install slack
brew cask install flux
