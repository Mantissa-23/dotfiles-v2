#!/usr/bin/bash

# UTILITIES
confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

echo 'Have you manually installed the prerequisite packages you want on this system?'
echo '- Nerd Font: Ideally JetBrainsMono'
echo '- zsh'
echo '- Vscodium'
echo
! confirm "Continue..." && exit 1

# INITIAL SETUP
GIT_DIRNAME=.git-dotfile
alias dotfile='/usr/bin/git --git-dir=$HOME/'"$GIT_DIRNAME"'/ --work-tree=$HOME'
echo $GIT_DIRNAME >> $HOME/.gitignore
git clone --bare <repo_url> $HOME/$GIT_DIRNAME

# Back up conflicting files to .bak
dotfile checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} {}.bak
dotifle checkout

# Disable untracked files so dotfile status doesn't explode
dotfile config --local status.showUntrackedFiles no

# INSTALL USERSPACE PROGRAMS AND UTILITIES
echo 'Installing userspace stuff...'
echo

confirm "Install Starship?" && curl -sS https://starship.rs/install.sh | sh

confirm "Install nvm?" && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

confirm "Install rustup (cargo, rust)?" && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# CHANGE SHELL
echo
confirm 'Change shell to zsh?' && chsh -s $(which zsh)
