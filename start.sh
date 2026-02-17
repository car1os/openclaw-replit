#!/bin/bash
set -e

# Install gog if not present
if ! command -v gog &> /dev/null; then
  echo "Installing gog CLI..."
  go install github.com/steipete/gogcli/cmd/gog@latest
fi

# Configure gog: set keyring to file mode (no passphrase prompt on Linux)
mkdir -p "$HOME/.config/gogcli"
gog auth keyring file 2>/dev/null || true

# Write gog credentials from Replit Secrets to disk
if [ -n "$GOG_CREDENTIALS_JSON" ]; then
  echo "$GOG_CREDENTIALS_JSON" > "$HOME/.config/gogcli/credentials.json"
fi
if [ -n "$GOG_TOKEN_JSON" ]; then
  echo "$GOG_TOKEN_JSON" > /tmp/gog-token-import.json
  GOG_KEYRING_PASSPHRASE="" gog auth tokens import /tmp/gog-token-import.json --force 2>/dev/null || true
  rm -f /tmp/gog-token-import.json
fi

# Install openclaw if not present
if ! command -v openclaw &> /dev/null; then
  echo "Installing openclaw..."
  npm install -g openclaw
fi

# Clone/update clinker plugin
CLINKER_DIR="$HOME/clinker"
if [ ! -d "$CLINKER_DIR" ]; then
  echo "Cloning clinker plugin..."
  git clone git@github.com:car1os/clinker.git "$CLINKER_DIR"
  cd "$CLINKER_DIR" && npm install && cd -
elif [ -d "$CLINKER_DIR/.git" ]; then
  echo "Updating clinker plugin..."
  cd "$CLINKER_DIR" && git pull && npm install && cd -
fi

echo "Starting openclaw gateway..."
openclaw gateway
