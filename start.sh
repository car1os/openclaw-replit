#!/bin/bash
set -e

# Install gog if not present
if ! command -v gog &> /dev/null; then
  echo "Installing gog CLI..."
  go install github.com/steipete/gogcli@latest
fi

# Write gog credentials from Replit Secrets to disk
mkdir -p "$HOME/.config/gogcli"
if [ -n "$GOG_CREDENTIALS_JSON" ]; then
  echo "$GOG_CREDENTIALS_JSON" > "$HOME/.config/gogcli/credentials.json"
fi
if [ -n "$GOG_TOKEN_JSON" ]; then
  echo "$GOG_TOKEN_JSON" > /tmp/gog-token-import.json
  gog auth tokens import /tmp/gog-token-import.json 2>/dev/null || true
  rm -f /tmp/gog-token-import.json
fi

# Install openclaw if not present
if ! command -v openclaw &> /dev/null; then
  echo "Installing openclaw..."
  npm install -g openclaw
fi

echo "Starting openclaw gateway..."
openclaw gateway
