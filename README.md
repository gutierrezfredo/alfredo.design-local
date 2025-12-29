# alfredo.design Local Development

Local Hugo development environment for [alfredo.design](https://alfredo.design).

## Purpose

This repository is the **local development environment** for testing theme changes before deploying to Micro.blog. It is NOT deployed anywhere - it's only for local preview.

## Structure

```
microblog-design-local/
├── content/           # Site content (markdown files from Micro.blog export)
├── themes/
│   └── design/        # Symlink → microblog-design-theme
├── config.toml        # Hugo configuration
└── start.sh           # Script to run Hugo server
```

## Setup

The `themes/design` folder is a symlink to the actual theme repository:

```
themes/design → /Users/alfredo/Developer/github.com/gutierrezfredo/microblog-design-theme
```

## Running Locally

```bash
./start.sh
# or
hugo server -D
```

Then visit: http://localhost:1314/

## Workflow

1. Download content export from Micro.blog
2. Copy content files to `content/` folder
3. Edit theme files in `microblog-design-theme`
4. Preview changes at localhost:1314
5. Push theme changes to deploy on Micro.blog

## Related Repositories

- [microblog-design-theme](https://github.com/gutierrezfredo/microblog-design-theme) - The actual theme (linked to Micro.blog)
- [microblog-design-archive](https://github.com/gutierrezfredo/microblog-design-archive) - Static archive backup
