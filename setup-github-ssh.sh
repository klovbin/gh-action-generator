#!/bin/bash

set -e

KEY_PATH="$HOME/.ssh/github-actions"

echo "🚀 Generating SSH key..."

# Generate SSH key (no passphrase)
ssh-keygen -t ed25519 -f $KEY_PATH -C "github-actions" -N "" >/dev/null

echo "🔑 Adding public key to authorized_keys..."
cat ${KEY_PATH}.pub >> $HOME/.ssh/authorized_keys

# Fix permissions (important for SSH)
chmod 700 $HOME/.ssh
chmod 600 $HOME/.ssh/authorized_keys

echo ""
echo "=============================="
echo "✅ SETUP COMPLETE"
echo "=============================="

# Get public IP
IP=$(curl -s ifconfig.me || hostname -I | awk '{print $1}')
USER=$(whoami)

# Fixed-width table (колонки 14 + 2 + 45 = 61 символ)
W="%-14s"
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
