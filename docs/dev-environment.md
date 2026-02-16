# Development Environment Setup

## Homebrew

Homebrew is the package manager for macOS.

### Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Add Homebrew to PATH (Apple Silicon Macs)

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Git

### Install

```bash
brew install git
```

### Configure

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
git config --global pull.rebase true
```

### SSH Key Setup

```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"

# Start ssh-agent
eval "$(ssh-agent -s)"

# Add key to agent
ssh-add ~/.ssh/id_ed25519

# Copy public key to clipboard
pbcopy < ~/.ssh/id_ed25519.pub
```

Then add the key to GitHub/GitLab.

## Essential CLI Tools

```bash
brew install \
  wget \
  curl \
  jq \
  tree \
  htop \
  ripgrep \
  fzf \
  tldr
```

## Programming Languages

### Node.js (via nvm)

```bash
brew install nvm
mkdir ~/.nvm

# Add to ~/.zshrc
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# Install latest LTS
nvm install --lts
```

### Python (via pyenv)

```bash
brew install pyenv

# Add to ~/.zshrc
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Install Python
pyenv install 3.12
pyenv global 3.12
```

## Applications via Homebrew Cask

```bash
brew install --cask \
  visual-studio-code \
  iterm2 \
  docker \
  rectangle \
  1password
```

## Shell Configuration

### Oh My Zsh (optional)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
