# General macOS Settings

## System Preferences

### Trackpad
- [ ] Enable tap to click
- [ ] Increase tracking speed

### Keyboard
- [ ] Set key repeat rate to fast
- [ ] Set delay until repeat to short
- [ ] Disable auto-correct

### Dock
- [ ] Auto-hide the Dock
- [ ] Remove unused apps from Dock
- [ ] Set icon size

### Finder
- [ ] Show file extensions
- [ ] Show hidden files (`Cmd + Shift + .`)
- [ ] Set default view to list/column

### Security & Privacy
- [ ] Enable FileVault
- [ ] Enable Firewall
- [ ] Allow apps from identified developers

## Terminal Commands

```bash
# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Set fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Auto-hide Dock
defaults write com.apple.dock autohide -bool true

# Restart affected apps
killall Finder
killall Dock
```
