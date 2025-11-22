# Common rc file between both zsh and bash. Sticks to syntax that is compatible between both. Sourced by .zshrc and .bashrc

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Dotfile config alias
alias dotfile='/usr/bin/git --git-dir=$HOME/.git-dotfile/ --work-tree=$HOME'

# Set askpass to kde wallet
export SSH_ASKPASS=ksshaskpass
export GIT_ASKPASS=ksshaskpass

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

# Homebrew
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; fi

# Godot Version Manager (gdvm)
export PATH="/home/dylan/.gdvm/bin/current_godot:/home/dylan/.gdvm/bin:$PATH"
