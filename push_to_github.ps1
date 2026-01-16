# Helper script to push code to GitHub
# Run this AFTER installing Git from https://git-scm.com/downloads

Write-Host "Initializing Git repository..."
git init

Write-Host "Adding files..."
git add .

Write-Host "Committing changes..."
git commit -m "Initial commit of Dynamic Dashboard"

Write-Host "Renaming branch to main..."
git branch -M main

Write-Host "Setting remote origin to https://github.com/achy02/cyber-app.git..."
# Remove origin if it exists to avoid errors on re-run
git remote remove origin 2>$null 
git remote add origin https://github.com/achy02/cyber-app.git

Write-Host "Pushing to GitHub..."
git push -u origin main

Write-Host "Done! If you saw errors above, make sure Git is installed and you are logged in."
Read-Host -Prompt "Press Enter to exit"
