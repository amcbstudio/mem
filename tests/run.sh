#!/bin/sh
set -eu

ROOT=$(cd "$(dirname "$0")/.." && pwd)
MEM_BIN="$ROOT/bin/mem"
INSTALL="$ROOT/hooks/install.sh"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

cd "$TMP"

git init -q
git config user.email "test@example.com"
git config user.name "Test User"

"$INSTALL"

printf 'hello\n' > file.txt
git add file.txt
git commit -q -m "test commit"

if [ ! -d ".amcb/memory" ]; then
  echo "missing .amcb/memory" >&2
  exit 1
fi

events_total=$(jq -r '.counters.events_total' .amcb/memory/state.json)
if [ "$events_total" -lt 1 ]; then
  echo "events_total < 1" >&2
  exit 1
fi

out=$("$MEM_BIN" show)
if [ -z "$out" ]; then
  echo "mem show produced no output" >&2
  exit 1
fi

echo "ok"
