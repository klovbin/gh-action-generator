# 🔑 GitHub Actions VPS Setup

One-command SSH key setup for deploying with GitHub Actions.

## Quick start

Run on your VPS with a single command:

```bash
curl -sSL https://raw.githubusercontent.com/klovbin/gh-action-generator/main/setup-github-ssh.sh -o /tmp/setup.sh && bash /tmp/setup.sh && rm -f /tmp/setup.sh
```

## What it does

- Generates ed25519 SSH key
- Adds public key to `~/.ssh/authorized_keys`
- Outputs data for GitHub Secrets: `VPS_HOST`, `VPS_USER`, `VPS_SSH_KEY`
