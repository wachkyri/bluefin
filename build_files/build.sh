#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

# Installing Netbird
/ctx/netbird-install.sh

# Install Mullvad
# mkdir "/opt/Mullvad VPN"
# dnf5 config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo
# dnf5 -y install mullvad-vpn

# Create symlink for /opt to /var/opt since it is not created in the image yet
mkdir -p "/var/opt" && ln -s "/var/opt"  "/opt"

curl --tlsv1.3 -fsS https://repository.mullvad.net/rpm/stable/mullvad.repo | tee /etc/yum.repos.d/mullvad.repo
dnf5 -y install mullvad-vpn

# Direct TriliumNext 
# renovate: datasource=github-releases depName=TriliumNext/Trilium
dnf5 -y install https://github.com/TriliumNext/Trilium/releases/download/v0.97.1/TriliumNotes-v0.97.1-linux-x64.rpm

# Direct Touche
dnf5 -y install https://github.com/JoseExposito/touchegg/releases/download/2.0.18/fedora34_touchegg-2.0.18-1.x86_64.rpm

#### Example for enabling a System Unit File

systemctl enable podman.socket
