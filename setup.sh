#!/bin/bash
# One-time setup script for Replit
# Run this manually after creating the Replit project
set -e

echo "=== OpenClaw Replit Setup ==="

# Install gog
echo "Installing gog CLI..."
go install github.com/steipete/gogcli@latest

# Install openclaw
echo "Installing openclaw..."
npm install -g openclaw

# Create gog config directory
mkdir -p "$HOME/.config/gogcli"

echo ""
echo "=== Next steps ==="
echo "1. Add these Replit Secrets:"
echo "   GOG_ACCOUNT=cwhitt@gmail.com"
echo ""
echo "2. Upload gog credentials (from your local machine):"
echo "   - Copy contents of credentials.json into Secret: GOG_CREDENTIALS_JSON"
echo "   - Copy contents of token-export.json into Secret: GOG_TOKEN_JSON"
echo ""
echo "3. Run: openclaw doctor"
echo "4. Configure openclaw.json for your setup"
echo "5. Hit Run to start the gateway"
