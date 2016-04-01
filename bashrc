alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim'

export PATH="/usr/local/bin:$HOME/.composer/vendor/bin:$PATH"
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

eval "$(docker-machine env default)"
