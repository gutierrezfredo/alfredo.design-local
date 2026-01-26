#!/bin/bash

# Alfredo.design Local Development Server (Hugo)
# Usage: ./start.sh

SITE_PATH="/Users/alfredo/Developer/github.com/gutierrezfredo/alfredo.design-local"
cd "$SITE_PATH"

# Check for new micro.blog export in Downloads (alfredo_* for design site)
LATEST_EXPORT=$(ls -td ~/Downloads/alfredo_* 2>/dev/null | head -1)
LAST_IMPORT="$SITE_PATH/.last_import"

if [ -n "$LATEST_EXPORT" ] && [ -d "$LATEST_EXPORT/content" ]; then
    if [ ! -f "$LAST_IMPORT" ] || [ "$LATEST_EXPORT" -nt "$LAST_IMPORT" ]; then
        echo "New micro.blog export found: $LATEST_EXPORT"
        echo "Importing content..."
        cp -R "$LATEST_EXPORT/content/"* "$SITE_PATH/content/"
        # Fix absolute URLs to relative
        find "$SITE_PATH/content" -name "*.md" -exec sed -i '' 's|https://alfredo.design/|/|g' {} \;
        touch "$LAST_IMPORT"
        echo "Content imported and URLs fixed!"
        echo ""
    fi
fi

echo "Pulling latest images from archive..."
cd /Users/alfredo/Developer/github.com/gutierrezfredo/alfredo.design-archive && git pull
cd "$SITE_PATH"

echo ""
echo "Starting Hugo dev server with live reload..."
echo ""
echo "Site:     http://localhost:1314/"
echo "Theme:    alfredo.design-theme"
echo "CSS:      themes/design/static/styles.css"
echo ""
echo "Changes auto-reload in browser!"
echo "Press Ctrl+C to stop"
echo ""

open http://localhost:1314/
hugo server --disableFastRender --port 1314
