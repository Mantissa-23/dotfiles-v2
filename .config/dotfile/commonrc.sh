# Common rc file between both zsh and bash. Sticks to syntax that is compatible between both. Sourced by .zshrc and .bashrc

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Dotfile config alias
alias dotfile='/usr/bin/git --git-dir=$HOME/.git-dotfile/ --work-tree=$HOME'

# Disable askpass
[ -n "$SSH_CONNECTION" ] && unset SSH_ASKPASS
export GIT_ASKPASS=

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Rustup
. "$HOME/.cargo/env"

# Starship
eval "$(starship init $(basename $SHELL))"

# Vim alias
alias vim='nvim'
