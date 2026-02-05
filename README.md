# 🌿 Branch Setup & Main Branch Restore Guide

This document covers:

1. Creating a new branch named `branch-setup`
2. Removing files from a branch
3. Restoring the `main` branch after an accidental merge

Repository:

```
https://github.com/vish-official-2525/github-setup.git
```

---

# 📁 Part 1 — Create New Branch (`branch-setup`)

## Step 1 — Go to Project Folder

```bash
cd github-setup
```

## Step 2 — Switch to Main Branch

```bash
git checkout main
```

## Step 3 — Pull Latest Code

```bash
git pull origin main
```

## Step 4 — Create New Branch

```bash
git checkout -b branch-setup
```

## Step 5 — Push Branch to GitHub

```bash
git push -u origin branch-setup
```

This will:

* Create `branch-setup`
* Switch to it
* Upload it to GitHub

## Verify Branch

```bash
git branch
git branch -r
```

---

# 🗑️ Part 2 — Remove a File from `branch-setup`

## Switch to Branch

```bash
git checkout branch-setup
```

## Remove File

```bash
git rm filename.ext
```

## Commit Changes

```bash
git commit -m "Removed file from branch-setup"
```

## Push Changes

```bash
git push origin branch-setup
```

### Keep File Locally but Remove from Git

```bash
git rm --cached filename.ext
git commit -m "Removed from tracking"
git push
```

---

# 🔄 Part 3 — Restore Main Branch After Accidental Merge

## Scenario

You accidentally merged `branch-setup` into `main` and want to restore the previous state.

---

## Step 1 — Check Commit History

```bash
git checkout main
git log --oneline
```

Example:

```
a1b2c3d Merge branch 'branch-setup'
9f8e7d6 Last stable commit
```

Copy the commit ID before the merge:

```
9f8e7d6
```

---

## Method 1 — If Merge NOT Pushed

```bash
git reset --hard 9f8e7d6
```

---

## Method 2 — If Merge Already Pushed

```bash
git reset --hard 9f8e7d6
git push origin main --force
```

This will:

* Remove the merge commit
* Restore `main` to the previous version

---

## Method 3 — Safe Method (Team Environment)

Instead of rewriting history:

```bash
git revert -m 1 <merge_commit_id>
git push origin main
```

This creates a new commit that undoes the merge.

---

# 🔍 Find Merge Commit

```bash
git log --oneline --graph
```

Look for:

```
Merge branch 'branch-setup'
```

---

# ⚠️ Important Notes

* `reset --hard` deletes changes permanently
* `--force` push rewrites GitHub history
* Use force push only if you're sure

---

# ⚡ Quick Commands Summary

## Create Branch

```bash
git checkout main
git pull origin main
git checkout -b branch-setup
git push -u origin branch-setup
```

## Remove File

```bash
git checkout branch-setup
git rm filename.ext
git commit -m "Removed file"
git push
```

## Restore Main

```bash
git checkout main
git log --oneline
git reset --hard <commit_before_merge>
git push origin main --force
```
