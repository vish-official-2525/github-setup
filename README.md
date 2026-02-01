# GitHub SSH Setup (Linux & Windows)

A **fully automated, cross-platform GitHub SSH setup** using shell and PowerShell scripts. This repository helps you install Git, generate SSH keys, add them to GitHub, and verify secure SSH access — **without passwords**.

---

## 📦 Repository Contents

| File        | Purpose                                          |
| ----------- | ------------------------------------------------ |
| `setup.sh`  | Automated setup for Linux (Ubuntu, Arch, Fedora) |
| `setup.ps1` | Automated setup for Windows (PowerShell)         |
| `README.md` | Complete usage and troubleshooting guide         |

---

## 🧰 Prerequisites

### Linux

* A supported package manager:

  * `apt` (Ubuntu / Debian)
  * `pacman` (Arch)
  * `dnf` (Fedora)
* `sudo` access
* Internet connection

### Windows

* Windows 10 / 11
* PowerShell 5.1+ or PowerShell 7+
* Git for Windows (downloaded if missing)

---

## 🚀 Linux Setup (setup.sh)

### 1️⃣ Make script executable

```bash
chmod +x setup.sh
```

### 2️⃣ Run the script

```bash
./setup.sh
```

### 3️⃣ What the script does

* Detects Linux distribution
* Installs Git (apt / pacman / dnf)
* Configures Git username & email
* Generates SSH key (`ed25519` or `rsa` fallback)
* Starts `ssh-agent`
* Adds SSH key automatically
* Copies SSH public key to clipboard (if supported)
* Tests GitHub SSH connection

---

## 🪟 Windows Setup (setup.ps1)

### 1️⃣ Allow script execution (one time)

Run PowerShell **as Administrator**:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 2️⃣ Run the script

```powershell
.\setup.ps1
```

### 3️⃣ What the script does

* Checks if Git is installed
* Configures Git username & email
* Generates SSH key
* Starts `ssh-agent`
* Adds SSH key to agent
* Displays public SSH key
* Tests GitHub SSH connection

---

## 🔑 Adding SSH Key to GitHub

1. Copy the public key output shown by the script
2. Go to: [https://github.com/settings/ssh/new](https://github.com/settings/ssh/new)
3. Paste the key
4. Set a title (e.g., `My Linux Laptop`)
5. Click **Add SSH key**

---

## ✅ Verify SSH Connection Manually

```bash
ssh -T git@github.com
```

Expected output:

```
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

---

## 🛠 Common Issues & Fixes

### ❌ Permission denied (publickey)

```bash
ssh-add ~/.ssh/id_ed25519
```

### ❌ ssh-agent not running

```bash
eval "$(ssh-agent -s)"
```

### ❌ Wrong Git email

```bash
git config --global user.email "your@email.com"
```

---

## 🔄 Switching HTTPS → SSH (Existing Repo)

```bash
git remote set-url origin git@github.com:USERNAME/REPO.git
```

Verify:

```bash
git remote -v
```

---

## 🧹 Uninstall / Cleanup

```bash
rm -rf ~/.ssh
```

⚠️ This removes **all SSH keys** — use carefully.

---

## 📌 Best Practices

* Use **one SSH key per device**
* Never share private keys
* Use `ed25519` keys when possible
* Protect keys with a passphrase

---

## 📜 License

MIT License

---

## ⭐ Notes

This setup is ideal for:

* Embedded / Linux developers
* CI/CD pipelines
* Secure GitHub workflows
* Passwordless Git operations

Happy hacking 🚀
