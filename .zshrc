source $HOME/.config/dotfile/antigen.zsh

# Antigen plugins
antigen use oh-my-zsh
antigen bundle git
antigen bundle z
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

# User specific environment

source $HOME/.config/dotfile/commonrc.sh

#source ./.env.mvcr
