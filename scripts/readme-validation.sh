#!/usr/bin/env bash
set -euo pipefail

echo "Running README validation checks..."

if [[ ! -f "README.md" ]]; then
  echo "README validation failed: README.md is missing."
  exit 1
fi

if ! grep -q "<!-- AI:START -->" README.md || ! grep -q "<!-- AI:END -->" README.md; then
  echo "README validation failed: AI markers are missing."
  exit 1
fi

if ! sed -n '/<!-- AI:START -->/,/<!-- AI:END -->/p' README.md | grep -qi "[A-Za-z]"; then
  echo "README validation failed: AI-managed section is empty or not English text."
  exit 1
fi

echo "README validation passed."
