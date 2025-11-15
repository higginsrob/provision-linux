#!/usr/bin/env bash

root="$PWD"
forceconfirm="$1"

if ! [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Install oh-my-zsh?: (y/N) " confirm
    read -r confirm
    if [ "$confirm" = "y" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "* Skipping oh-my-zsh install"
    fi
    echo "Install zsh-syntax-highlighting?: (y/N) " confirm
    read -r confirm
    if [ "$confirm" = "y" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    else
        echo "* Skipping zsh-syntax-highlighting install"
    fi
    echo "Install zsh-autosuggestions?: (y/N) " confirm
    read -r confirm
    if [ "$confirm" = "y" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    else
        echo "* Skipping zsh-autosuggestions install"
    fi
else
    echo "* oh-my-zsh is already installed"
fi

if ! [ -d "$HOME/.nvm" ]; then
    read -p "Install NVM (Node Version Manager)?: (y/N) " confirm
    if [ "$confirm" = "y" ]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    else
        echo "* Skipping NVM install"
    fi
else
    echo "* NVM is already installed"
fi

if ! command -v ollama &> /dev/null; then
    read -p "Install Ollama?: (y/N) " confirm
    if [ "$confirm" = "y" ]; then
        curl -fsSL https://ollama.com/install.sh | sh
    else
        echo "* Skipping Ollama install"
    fi
else
    echo "* Ollama is already installed"
fi

additionspath="$root/shell-additions"

if [ -f "$HOME/.zshrc" ] && ! grep -q "$additionspath" "$HOME/.zshrc"; then
    read -p "Install ZSH shell-additions?: (y/N) " confirm
    if [ "$confirm" = "y" ]; then
        echo "" >>"$HOME/.zshrc"
        echo "# Shell Additions by Freshstack" >>"$HOME/.zshrc"
        echo "for f in $additionspath/*; do source \$f; done" >>"$HOME/.zshrc"
    else
        echo "shell-additions not installed"
    fi
else
    echo "* shell-additions already sourced"
fi
