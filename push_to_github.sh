#!/bin/bash

echo "Aborting any stuck processes..."
git rebase --abort 2>/dev/null || true
git merge --abort 2>/dev/null || true

echo "Initializing Git repository..."
git init

echo "Adding files..."
git add .

echo "Committing changes..."
git commit -m "Initial commit of Dynamic Dashboard"

echo "Renaming branch to main..."
git branch -M main

echo "Setting remote origin..."
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/achy02/cyber-app.git

echo "Pushing to GitHub..."
git push -u origin main

echo "Done!"
