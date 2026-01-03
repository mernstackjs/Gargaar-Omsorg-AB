#!/usr/bin/env bash
# Load variables from .env into current shell environment (for local testing)
# Usage: source set-env.sh

ENV_FILE=".env"
if [ ! -f "$ENV_FILE" ]; then
  echo ".env not found. Copy .env.example to .env and fill in values." >&2
  return 1 2>/dev/null || exit 1
fi

while IFS='=' read -r key val; do
  # skip comments and empty lines
  if [[ "$key" =~ ^\s*# ]] || [[ -z "$key" ]]; then
    continue
  fi
  # remove surrounding quotes from value
  val="${val%\"}"
  val="${val#\"}"
  export "$key=$val"
done < <(grep -v '^\s*$' "$ENV_FILE")

echo "Exported environment variables from $ENV_FILE"
