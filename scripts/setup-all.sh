#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== SetupMyMac ==="
echo "This will set up your Mac development environment."
echo ""

read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

echo ""
echo "==> Applying macOS settings..."
"$SCRIPT_DIR/macos-settings.sh"

echo ""
echo "==> Setting up development environment..."
"$SCRIPT_DIR/dev-setup.sh"

echo ""
echo "=== Setup complete! ==="
echo "Please restart your terminal (or run 'source ~/.zshrc') for all changes to take effect."
