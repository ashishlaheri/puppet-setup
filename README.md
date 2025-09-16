# Puppet Setup Automation

This repository automates Puppet Master and Slave setup on Ubuntu (18.04/20.04/22.04).

## Usage

### 1. Clone Repo
```bash
git clone <your-repo-url>
cd puppet-setup/scripts
```

### 2. Setup Puppet Master
```bash
sudo ./install_master.sh
sudo ./create_manifests.sh
```

### 3. Setup Puppet Slave
```bash
sudo ./install_slave.sh <MASTER_PRIVATE_IP>
sudo puppet agent --test
```

### 4. Verify
```bash
cat /tmp/message.txt
nginx -v
```

You should see the message file and nginx installed successfully.
