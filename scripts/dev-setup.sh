#!/bin/bash
# Development Environment Setup Script
set -e

echo "Setting up development environment..."

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add to PATH for Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed, updating..."
    brew update
fi

# Install Git
echo "Installing Git..."
brew install git

# Install essential CLI tools
echo "Installing CLI tools..."
brew install \
    wget \
    curl \
    jq \
    tree \
    htop \
    ripgrep \
    fzf \
    tldr

# Install nvm for Node.js
echo "Installing nvm..."
brew install nvm
mkdir -p ~/.nvm

# Install pyenv for Python
echo "Installing pyenv..."
brew install pyenv

# Add shell configuration if not present
ZSHRC="$HOME/.zshrc"
if ! grep -q "NVM_DIR" "$ZSHRC" 2>/dev/null; then
    echo "" >> "$ZSHRC"
    echo "# NVM" >> "$ZSHRC"
    echo 'export NVM_DIR="$HOME/.nvm"' >> "$ZSHRC"
    echo '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"' >> "$ZSHRC"
fi

if ! grep -q "PYENV_ROOT" "$ZSHRC" 2>/dev/null; then
    echo "" >> "$ZSHRC"
    echo "# Pyenv" >> "$ZSHRC"
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> "$ZSHRC"
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> "$ZSHRC"
    echo 'eval "$(pyenv init -)"' >> "$ZSHRC"
fi

echo "Development environment setup complete!"
echo "Run 'source ~/.zshrc' to reload your shell configuration."
