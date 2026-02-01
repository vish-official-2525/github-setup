Write-Host "🔐 GitHub SSH Setup (Windows - Non Interactive)"
Write-Host "---------------------------------------------"

# ------------------ Check Git ------------------
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git not installed. Install from https://git-scm.com/"
    exit 1
}

# ------------------ Git config (AUTO) ------------------
$user = $env:USERNAME
$email = "$user@users.noreply.github.com"

git config --global user.name  $env:GIT_NAME  ?? $user
git config --global user.email $env:GIT_EMAIL ?? $email

Write-Host "✔ Git identity configured"

# ------------------ SSH setup ------------------
$sshDir = "$env:USERPROFILE\.ssh"
$key = "$sshDir\id_ed25519"

if (!(Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir | Out-Null
}

if (!(Test-Path $key)) {
    Write-Host "🔑 Generating SSH key..."
    ssh-keygen -t ed25519 -C (git config --global user.email) -f $key -N ""
} else {
    Write-Host "✔ SSH key already exists"
}

Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent

ssh-add $key

Write-Host "📋 SSH public key:"
Get-Content "$key.pub" | Set-Clipboard
Write-Host "(Copied to clipboard)"

# ------------------ Test GitHub ------------------
Write-Host "🔍 Testing GitHub SSH..."
ssh -T git@github.com

Write-Host "✅ Windows setup complete"
