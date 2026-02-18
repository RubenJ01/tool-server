#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

REPO_DIR="/root/tool-server"
cd "$REPO_DIR" || exit

git config --global --add safe.directory "$REPO_DIR"
git pull origin main --quiet

git add dokuwiki/config/dokuwiki/data/

if git diff --cached --quiet; then
    echo "$(date): No changes."
else
    git commit -m "chore: DokuWiki auto-update $(date +'%Y-%m-%d %H:%M')"
    git push origin main
    echo "$(date): Pushed."
fi
