#!/usr/bin/env python3
"""
Sync content from Micro.blog GitHub archive to local Hugo development.

Usage: python3 sync-from-github.py

This script:
1. Pulls latest from the microblog-design-archive repo
2. Parses feed.json to extract posts
3. Creates/updates markdown files in the content folder
"""

import json
import os
import subprocess
import re
from datetime import datetime
from pathlib import Path

# Paths
SCRIPT_DIR = Path(__file__).parent
ARCHIVE_REPO = SCRIPT_DIR.parent / "microblog-design-archive"
CONTENT_DIR = SCRIPT_DIR / "content"

def pull_latest():
    """Pull latest changes from the archive repo."""
    print("Pulling latest from GitHub archive...")
    result = subprocess.run(
        ["git", "pull", "origin", "main"],
        cwd=ARCHIVE_REPO,
        capture_output=True,
        text=True
    )
    if result.returncode == 0:
        print(f"  {result.stdout.strip() or 'Already up to date.'}")
    else:
        print(f"  Warning: {result.stderr}")

def html_to_markdown(html):
    """Convert HTML to markdown (basic conversion)."""
    # Keep HTML as-is since Hugo renders it with unsafe: true
    # Just clean up some entities
    text = html
    text = text.replace("&rsquo;", "'")
    text = text.replace("&ldquo;", '"')
    text = text.replace("&rdquo;", '"')
    text = text.replace("&amp;", "&")
    text = text.replace("&gt;", ">")
    text = text.replace("&lt;", "<")
    return text.strip()

def url_to_filename(url, date_str):
    """Convert URL to a filename path in post/ folder."""
    # Parse date
    date = datetime.fromisoformat(date_str.replace("Z", "+00:00"))

    # Extract slug from URL (last part before .html)
    slug = url.rstrip("/").split("/")[-1]
    if slug.endswith(".html"):
        slug = slug[:-5]

    # Create path: post/YYYY/MM/DD/slug.md (Micro.blog export structure)
    path = f"post/{date.year}/{date.month:02d}/{date.day:02d}/{slug}.md"
    return path

def create_frontmatter(item):
    """Create Hugo frontmatter from feed item."""
    lines = ["---"]

    if item.get("title"):
        title = item["title"].replace('"', '\\"')
        lines.append(f'title: "{title}"')

    lines.append(f'date: {item["date_published"]}')

    if item.get("tags"):
        categories = json.dumps(item["tags"])
        lines.append(f'categories: {categories}')

    # Extract photos from content
    photos = re.findall(r'<img[^>]+src="([^"]+)"', item.get("content_html", ""))
    if photos:
        photos_json = json.dumps(photos)
        lines.append(f'photos: {photos_json}')

    lines.append("---")
    return "\n".join(lines)

def sync_posts():
    """Sync posts from feed.json to content folder."""
    feed_path = ARCHIVE_REPO / "feed.json"

    if not feed_path.exists():
        print(f"Error: {feed_path} not found")
        return

    with open(feed_path) as f:
        feed = json.load(f)

    posts = feed.get("items", [])
    print(f"Found {len(posts)} posts in feed.json")

    # Ensure content directory exists
    CONTENT_DIR.mkdir(exist_ok=True)

    created = 0
    updated = 0

    for item in posts:
        # Generate file path
        rel_path = url_to_filename(item["url"], item["date_published"])
        file_path = CONTENT_DIR / rel_path

        # Create frontmatter and content
        frontmatter = create_frontmatter(item)
        content = html_to_markdown(item.get("content_html", ""))

        full_content = f"{frontmatter}\n\n{content}\n"

        # Create directory if needed
        file_path.parent.mkdir(parents=True, exist_ok=True)

        # Check if file exists and has same content
        if file_path.exists():
            existing = file_path.read_text()
            if existing == full_content:
                continue
            updated += 1
            action = "Updated"
        else:
            created += 1
            action = "Created"

        # Write file
        file_path.write_text(full_content)
        print(f"  {action}: {rel_path}")

    print(f"\nSync complete: {created} created, {updated} updated")

def main():
    print("=" * 50)
    print("Micro.blog Content Sync")
    print("=" * 50)

    # Check archive repo exists
    if not ARCHIVE_REPO.exists():
        print(f"Error: Archive repo not found at {ARCHIVE_REPO}")
        print("Run: git clone git@github.com:gutierrezfredo/microblog-design-archive.git")
        return

    pull_latest()
    print()
    sync_posts()
    print()
    print("Note: Pages (like /intro/) are not in feed.json.")
    print("For pages, download the full export from Micro.blog.")

if __name__ == "__main__":
    main()
