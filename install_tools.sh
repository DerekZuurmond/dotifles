#!/bin/bash

# Update package lists and upgrade system
sudo apt update -y && sudo apt upgrade -y

# Install common packages
sudo apt install -y \
    duckdb \
    fzf \
    neovim \
    nodejs npm \
    python3 python3-pip python3.13 python3.13-venv python3.13-dev \
    ripgrep \
    rustup \
    tmux \
    vim \
    zsh \
    build-essential curl file 

# Install additional Python tools
pip3 install dbt pytest

# Install Rust tools
cargo install cargo

# Install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Install Homebrew (Linux)
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add Homebrew to PATH (for immediate use)
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Set up zsh as the default shell
chsh -s $(which zsh)

echo "Installation complete. You may need to restart your terminal."


