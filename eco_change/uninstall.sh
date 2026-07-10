#!/usr/bin/env bash

sudo rm /etc/udev/rules.d/60-on-pchange.rules
rm "$XDG_CONFIG_HOME/systemd/user/on_pchange.service" ~/.local/bin/on_pchange ~/.local/bin/screen_mode

sudo systemctl daemon-reload
sudo udevadm control --reload

echo "Uninstalled"
