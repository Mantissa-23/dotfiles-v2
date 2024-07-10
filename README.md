# Dotfiles

Mantissa's Dotfiles. Apply KISS to rc.

## Installation

```sh
curl -sSf https://raw.githubusercontent.com/Mantissa-23/dotfiles-v2/main/.config/dotfile/bootstrap.sh | bash
```

## .config/nvim/init.lua

Simple. Has all the bells and whistles except for LSP/Debugger/Linter/Formatter features. No reliance on external language/package providers like Node, Python, Perl, Ruby, Cargo or Perl. The intention is that this can still be installed onto a server and it will just bootstrap itself and work without manual installation of external dependencies.

DOES have two common external dependencies, but will still function without them:
- ripgrep
- cmake

## VSCodium

Makes up for the relatively basic nvim/init.lua. Used for actual real-boy development work.

Basic settings.json and keybindings.json set up for use with neovim. Lacking a lot of the keybinds I like having in neovim- Will modify to suit in the future.

## .zshrc and antigen

Yes, I know antigen is deprecated. No, I do not care. It is still much simpler than a lot of its peers and it works fine because I don't have a big plugin list. Again, just the QoL stuff to make using a terminal suck less.
