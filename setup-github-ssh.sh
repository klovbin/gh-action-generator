#!/bin/bash

set -e

KEY_PATH="$HOME/.ssh/github-actions"

if [[ ! -f $KEY_PATH ]]; then
  echo "🚀 Generating SSH key..."
  mkdir -p $HOME/.ssh
  ssh-keygen -t ed25519 -f $KEY_PATH -C "github-actions" -N "" >/dev/null
  echo "🔑 Adding public key to authorized_keys..."
  touch $HOME/.ssh/authorized_keys
  cat ${KEY_PATH}.pub >> $HOME/.ssh/authorized_keys
  chmod 700 $HOME/.ssh
  chmod 600 $HOME/.ssh/authorized_keys
  echo ""
  echo "=============================="
  echo "✅ SETUP COMPLETE"
  echo "=============================="
else
  echo "🔑 Using existing key..."
  echo ""
fi

# Get public IPv4 only
IP=$(curl -4 -s ifconfig.me 2>/dev/null || curl -4 -s icanhazip.com 2>/dev/null || hostname -I | tr ' ' '\n' | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | head -1)
USER=$(whoami)

echo ""
echo "=============================="
echo "  GitHub Secrets"
echo "=============================="
echo ""
printf "+----------------+-----------------------------------------------+\n"
printf "| %-14s | %-45s |\n" "Secret" "Value"
printf "+----------------+-----------------------------------------------+\n"
printf "| %-14s | %-45s |\n" "VPS_HOST" "$IP"
printf "| %-14s | %-45s |\n" "VPS_USER" "$USER"
printf "+----------------+-----------------------------------------------+\n"
echo ""
echo "VPS_SSH_KEY (copy block below):"
echo "+-----------------------------------------------------------------------+"
cat $KEY_PATH
echo "+-----------------------------------------------------------------------+"
