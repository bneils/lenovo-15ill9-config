#!/bin/bash

# Create a child configuration to disable any pages under plasma-plasmashell being sent
# to swap, even if they are considered cold. This may help with desktop responsiveness
# under high memory pressure, even with low swappiness.

DIR=/usr/lib/systemd/user/plasma-plasmashell.service.d
sudo mkdir "$DIR"

sudo tee "$DIR/noswap.conf" >/dev/null <<EOF
# Disable swap entirely for this process
[Service]
MemorySwapMax=0
EOF

systemctl --user daemon-reload
systemctl --user restart plasma-plasmashell
