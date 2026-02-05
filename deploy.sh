#!/bin/bash

# alfredo.design Deploy Script
# Syncs content from Obsidian and pushes to GitHub Pages

OBSIDIAN_PATH="/Users/alfredo/Library/Mobile Documents/iCloud~md~obsidian/Documents/Docs/Web Projects/alfredo.design"
REPO_PATH="/Users/alfredo/Developer/github.com/gutierrezfredo/alfredo.design"

echo "Deploying alfredo.design..."
echo ""

# 1. Sync content from Obsidian (excluding backups and Obsidian files)
echo "Syncing content from Obsidian..."
rsync -av --delete \
    --exclude='.DS_Store' \
    --exclude='*.backup' \
    --exclude='.obsidian' \
    --exclude='BASE.base' \
    --exclude='README.md' \
    "$OBSIDIAN_PATH/" "$REPO_PATH/content/"

if [ $? -ne 0 ]; then
    echo "Error: Failed to sync content from Obsidian"
    exit 1
fi

# 2. Check if there are changes
cd "$REPO_PATH"
if [[ -z $(git status -s) ]]; then
    echo "No changes to deploy"
    exit 0
fi

# 3. Show what changed
echo ""
echo "Changes detected:"
git status -s

# 4. Commit and push
echo ""
echo "Committing changes..."
git add content/
git commit -m "Update content from Obsidian

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"

echo ""
echo "Pushing to GitHub..."
git push

if [ $? -eq 0 ]; then
    echo ""
    echo "Deployed successfully!"
    echo "Site will update at: https://alfredo.design"
else
    echo ""
    echo "Error: Failed to push to GitHub"
    exit 1
fi
