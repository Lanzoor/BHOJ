#!/usr/bin/env bash
set -euo pipefail

command -v python3 >/dev/null || {
  echo "python3 not found"
  exit 1
}

# Determine where the script is being runned
SOURCE="${BASH_SOURCE[0]}"
while [ -L "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
SCRIPT_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

# Run the main script
exec python3 "$SCRIPT_DIR/src/main.py" "$@"
