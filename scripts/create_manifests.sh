#!/bin/bash
# Create manifests and auto-import them into site.pp

set -e

if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root (use sudo)."
  exit 1
fi

MANIFEST_DIR="/etc/puppet/code/environments/production/manifests"
echo "📂 Creating manifest directory..."
mkdir -p $MANIFEST_DIR

echo "📝 Creating nginx.pp..."
tee $MANIFEST_DIR/nginx.pp > /dev/null <<'EOL'
node default {
  package { 'nginx':
    ensure => installed,
  }
}
EOL

echo "📝 Creating message.pp..."
tee $MANIFEST_DIR/message.pp > /dev/null <<'EOL'
node default {
  file { '/tmp/message.txt':
    ensure  => present,
    mode    => '0644',
    content => "Hello from Puppet Master!\n",
  }
}
EOL

echo "📝 Creating site.pp with imports..."
tee $MANIFEST_DIR/site.pp > /dev/null <<'EOL'
import '/etc/puppet/code/environments/production/manifests/nginx.pp'
import '/etc/puppet/code/environments/production/manifests/message.pp'
EOL

echo "🔄 Restarting puppet-master..."
systemctl restart puppet-master

echo "✅ Manifests created successfully!"
echo "➡ Now run 'sudo puppet agent --test' on the slave to apply."
