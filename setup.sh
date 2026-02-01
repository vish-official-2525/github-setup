#!/usr/bin/env bash
set -e

echo "🔐 GitHub SSH Setup (Linux - Non Interactive)"
echo "--------------------------------------------"

command_exists() { command -v "$1" >/dev/null 2>&1; }

# ------------------ Install Git ------------------
if ! command_exists git; then
  echo "📦 Installing Git..."
  if command_exists apt; then
    sudo apt update && sudo apt install -y git
  elif command_exists pacman; then
    sudo pacman -Sy --noconfirm git
  elif command_exists dnf; then
    sudo dnf install -y git
  else
    echo "❌ Unsupported distro"
    exit 1
  fi
fi

# ------------------ Git config (AUTO) ------------------
DEFAULT_NAME="$(whoami)"
DEFAULT_EMAIL="${DEFAULT_NAME}@users.noreply.github.com"

git config --global user.name  "${GIT_NAME:-$DEFAULT_NAME}"
git config --global user.email "${GIT_EMAIL:-$DEFAULT_EMAIL}"

echo "✔ Git identity set:"
git config --global --list | grep user.

# ------------------ SSH setup ------------------
mkdir -p ~/.ssh
chmod 700 ~/.ssh

KEY="$HOME/.ssh/id_ed25519"

if [[ ! -f "$KEY" ]]; then
  echo "🔑 Generating SSH key..."
  ssh-keygen -t ed25519 -C "$(git config --global user.email)" -f "$KEY" -N ""
else
  echo "✔ SSH key already exists"
fi

eval "$(ssh-agent -s)"
ssh-add "$KEY"

echo "📋 SSH public key:"
cat "$KEY.pub"

# ------------------ Test GitHub ------------------
echo "🔍 Testing GitHub SSH..."
ssh -T git@github.com || true

echo "✅ Linux setup complete"
