#!/bin/bash

set -e

# Resolve the monorepo root (the directory containing pnpm-workspace.yaml),
# so this script works no matter which directory it is invoked from
# (e.g. via `pnpm clean-deps`, which runs with the app as CWD).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$SCRIPT_DIR"
while [[ ! -f "$WORKSPACE_ROOT/pnpm-workspace.yaml" ]]; do
  WORKSPACE_ROOT="$(dirname "$WORKSPACE_ROOT")"
  if [[ "$WORKSPACE_ROOT" == "/" ]]; then
    echo "Error: could not locate pnpm-workspace.yaml" >&2
    exit 1
  fi
done

APP_DIR="$(dirname "$SCRIPT_DIR")"

# Remove every node_modules directory in the workspace: the hoisted root one
# (which holds the .pnpm virtual store) and any per-package ones, including
# packages not matched by the workspace globs (e.g. archived/).
find "$WORKSPACE_ROOT" -name node_modules -type d -prune -exec rm -rf {} +

# Remove the lockfile so it is regenerated on the next install
rm -f "$WORKSPACE_ROOT/pnpm-lock.yaml"

# Remove the Expo cache for this app
rm -rf "$APP_DIR/.expo"

echo "Removed all node_modules from $WORKSPACE_ROOT"
