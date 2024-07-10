source $HOME/.config/dotfile/antigen.zsh

# Antigen plugins
antigen use oh-my-zsh
antigen bundle git
antigen bundle z
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Starship terminal prompt
eval "$(starship init zsh)"

source $HOME/.config/dotfile/commonrc.sh
