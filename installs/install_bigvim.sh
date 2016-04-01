echo " ********************************************************"
echo " ************ INFO: install bigvim **********************"
echo " ********************************************************"

####### install bigvim
echo " >>> start install nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash

echo " >>> start install node"
nvm install node

echo " >>> start install bigvim"
curl -o- https://raw.githubusercontent.com/ruanyl/bigvim/master/install.sh | bash
