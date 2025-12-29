#!/bin/bash

# Alfredo.design Local Development Server (Hugo)
# Usage: ./start.sh

cd /Users/alfredo/Developer/github.com/gutierrezfredo/microblog-design-local

echo "Starting Hugo dev server with live reload..."
echo ""
echo "Site:     http://localhost:1314/"
echo "Theme:    microblog-design-theme"
echo "CSS:      themes/design/static/styles.css"
echo ""
echo "Changes auto-reload in browser!"
echo "Press Ctrl+C to stop"
echo ""

open http://localhost:1314/
hugo server --disableFastRender --port 1314
