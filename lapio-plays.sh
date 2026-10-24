#!/usr/bin/env bash
set -Eeuo pipefail

# Keep the browser terminal private: configure GOTTY_CREDENTIAL in Render
# using the format "username:strong-password".
if [[ -z "${GOTTY_CREDENTIAL:-}" || "${GOTTY_CREDENTIAL}" != *:* ]]; then
  echo "ERROR: Set GOTTY_CREDENTIAL in Render as username:strong-password." >&2
  exit 1
fi

# Render supplies PORT for web services. Keep a local default for development.
port="${PORT:-10000}"
if [[ ! "${port}" =~ ^[0-9]+$ ]]; then
  echo "ERROR: PORT must be numeric." >&2
  exit 1
fi

exec /usr/local/bin/gotty \
  --address 0.0.0.0 \
  --port "${port}" \
  --credential "${GOTTY_CREDENTIAL}" \
  --permit-write \
  /bin/bash
