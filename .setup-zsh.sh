#!/bin/bash

# Function to install packages if not already installed
install_if_missing() {
    if ! command -v $1 &> /dev/null; then
        echo "Installing $1..."
        sudo apt update && sudo apt install -y $2
    else
        echo "$1 is already installed."
    fi
}

echo "Starting Zsh environment setup..."

# Install Zsh if not installed
install_if_missing zsh zsh

# Set Zsh as the default shell
chsh -s $(which zsh)

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Install FZF (Fuzzy Finder)
install_if_missing fzf fzf

# Install fd (Alternative to find)
install_if_missing fd fd-find

# Install bat (Alternative to cat)
install_if_missing bat bat

# Install eza (Alternative to ls)
install_if_missing eza eza

# Install zoxide (Smarter cd)
if ! command -v zoxide &> /dev/null; then
    echo "Installing zoxide..."
    curl -sS https://webinstall.dev/zoxide | bash
else
    echo "zoxide is already installed."
fi

# Install zsh-syntax-highlighting
install_if_missing zsh-syntax-highlighting zsh-syntax-highlighting

# Install starship prompt
if ! command -v starship &> /dev/null; then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh
else
    echo "Starship is already installed."
fi

# Install fnm (Fast Node Manager)
if ! command -v fnm &> /dev/null; then
    echo "Installing fnm..."
    curl -fsSL https://fnm.vercel.app/install | bash
else
    echo "fnm is already installed."
fi

# Install bun (JavaScript Runtime)
if ! command -v bun &> /dev/null; then
    echo "Installing bun..."
    curl -fsSL https://bun.sh/install | bash
else
    echo "bun is already installed."
fi

# Install pnpm (Package Manager)
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    curl -fsSL https://get.pnpm.io/install.sh | sh -
else
    echo "pnpm is already installed."
fi

# Export paths for bun, pnpm, and fnm
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/.local/share/pnpm"
export FNM_PATH="$HOME/.local/share/fnm"

export PATH="$BUN_INSTALL/bin:$PNPM_HOME:$FNM_PATH:$PATH"

# Source completions for bun and other commands
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

echo "All tools installed and paths configured."

# Source .zshrc file
if [ -f "$HOME/.zshrc" ]; then
    echo "Reloading .zshrc..."
    source "$HOME/.zshrc"
else
    echo ".zshrc not found! Please copy your .zshrc file and reload it using 'source ~/.zshrc'."
fi

echo "Zsh environment setup complete!"
