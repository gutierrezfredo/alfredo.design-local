#!/bin/bash

# Refresh content from Micro.blog archive
# Run this when Micro.blog pushes new content (daily)

echo "Pulling latest content from archive..."
cd /Users/alfredo/Developer/github.com/gutierrezfredo/microblog-design-archive
git pull

echo ""
echo "Syncing to local dev..."
rsync -av --exclude='.git' --exclude='README.md' \
  /Users/alfredo/Developer/github.com/gutierrezfredo/microblog-design-archive/ \
  /Users/alfredo/Developer/github.com/gutierrezfredo/microblog-design-local/content/

echo ""
echo "Done! Hugo will auto-reload if running."
