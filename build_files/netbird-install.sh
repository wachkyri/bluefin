#!/bin/bash

set -ouex pipefail

# Add NetBird repo
echo "Adding NetBird repository"

cat <<-EOF | tee /etc/yum.repos.d/netbird.repo
[NetBird]
name=NetBird
baseurl=https://pkgs.netbird.io/yum/
enabled=1
gpgcheck=0
gpgkey=https://pkgs.netbird.io/yum/repodata/repomd.xml.key
repo_gpgcheck=1
EOF

# Installing NetBird binary from repo
echo "Installing NetBird"
dnf5 -y install netbird netbird-ui