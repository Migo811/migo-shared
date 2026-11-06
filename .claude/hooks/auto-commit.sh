#!/usr/bin/env bash
# Stop hook: commit and push any uncommitted work so every session lands on GitHub (Migo811).
set -u
cd "${CLAUDE_PROJECT_DIR:-$(pwd)}" 2>/dev/null || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0
[ -z "$(git status --porcelain)" ] && exit 0

branch="$(git rev-parse --abbrev-ref HEAD)"
git add -A
git commit -q -m "Auto-save session work ($(date -u +%Y-%m-%dT%H:%MZ))" || exit 0
git push -q -u origin "$branch" >/dev/null 2>&1 || echo "auto-commit: push to $branch failed; commit is local" >&2
exit 0
