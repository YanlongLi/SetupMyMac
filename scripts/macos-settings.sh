#!/bin/bash
# macOS Settings Script
# Review and uncomment the settings you want to apply

set -e

echo "Applying macOS settings..."

# Finder: Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keyboard: Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Keyboard: Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Dock: Auto-hide
defaults write com.apple.dock autohide -bool true

# Dock: Set icon size (pixels)
defaults write com.apple.dock tilesize -int 48

# Restart affected applications
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true

echo "macOS settings applied!"
