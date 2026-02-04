#!/bin/sh
set -eu

MEM_ROOT=$(cd "$(dirname "$0")/.." && pwd)
MEM_BIN="$MEM_ROOT/bin/mem"

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "mem: not a git repository" >&2
  exit 2
fi

HOOKS_DIR=$(git rev-parse --git-path hooks 2>/dev/null || true)
if [ -z "$HOOKS_DIR" ]; then
  HOOKS_DIR="$(git rev-parse --git-dir)/hooks"
fi

mkdir -p "$HOOKS_DIR"

install_hook() {
  src=$1
  name=$(basename "$src")
  dest="$HOOKS_DIR/$name"
  sed "s|__MEM_BIN__|$MEM_BIN|g" "$src" > "$dest"
  chmod +x "$dest"
  printf 'installed %s -> %s\n' "$name" "$dest"
}

install_hook "$MEM_ROOT/hooks/post-commit"
install_hook "$MEM_ROOT/hooks/post-merge"
