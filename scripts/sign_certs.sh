#!/bin/bash
# Auto-sign all pending Puppet certificates on Master

set -e

if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root (use sudo)."
  exit 1
fi

echo "🔑 Checking pending certificates..."
PENDING=$(puppet cert list)

if [ -z "$PENDING" ]; then
  echo "ℹ️ No pending certificates found."
else
  echo "🖊️ Signing all pending certificates..."
  puppet cert sign --all
  echo "✅ All certificates signed."
  echo "🔄 Restarting puppet-master..."
  systemctl restart puppet-master
fi

echo "✅ Done."
