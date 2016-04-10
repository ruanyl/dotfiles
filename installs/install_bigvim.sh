echo " ********************************************************"
echo " ************ INFO: install bigvim **********************"
echo " ********************************************************"

####### install bigvim
echo " >>> start install nvm"
brew install nvm

echo " >>> start install node"
nvm install node

echo " >>> start install bigvim"
curl -o- https://raw.githubusercontent.com/ruanyl/bigvim/master/install.sh | bash
