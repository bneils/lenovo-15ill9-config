#!/usr/bin/env bash

echo -n "Install for $USER? (y/N) "
read -r ans
[ "$ans" = "y" ] || exit

UDEV_DIR="/etc/udev/rules.d"
SCRIPT_DIR="$HOME/.local/bin"
SYSTEMD_DIR="$XDG_CONFIG_HOME/systemd/user"
BATTERY_DIR="/sys/class/power_supply/BAT0"

check_prerequisites() {
    if ! sudo which tlp >/dev/null ; then
        echo "error: tlp is not installed"
        exit 1
    fi
    if ! which kscreen-doctor >/dev/null ; then
        echo "error: kscreen-doctor is not installed"
        exit 1
    fi
}

check_paths() {
    if ! [ -d "$SCRIPT_DIR" ]; then
        echo "error: $SCRIPT_DIR not found"
        exit 1
    fi
    if ! [ -d "$UDEV_DIR" ]; then
        echo "error: $UDEV_DIR not found"
        exit 1
    fi
    if ! [ -d "$SYSTEMD_DIR" ]; then
        echo "error: $SYSTEMD_DIR not found"
        exit 1
    fi
    if ! [ -d "$BATTERY_DIR" ]; then
        echo "error: $BATTERY_DIR not found"
        exit 1
    fi
}

install_systemd() {
    # Install the systemd script
    SYSTEMD_SCRIPT_PATH="$SYSTEMD_DIR/on_pchange.service"
    cp ./src/on_pchange.service "$SYSTEMD_SCRIPT_PATH"
    sudo systemctl daemon-reload
    echo "Installed systemd service."
}

install_udev() {
    # Install the udev script
    UDEV_SCRIPT_PATH="$UDEV_DIR/60-on-pchange.rules"
    UDEV_SCRIPT="ACTION==\"change\", SUBSYSTEM==\"power_supply\", KERNEL!=\"hidpp_battery*\", RUN+=\"/usr/bin/systemctl -M $USER@ --user --no-block start on_pchange.service\""

    echo "$UDEV_SCRIPT" | sudo tee "$UDEV_SCRIPT_PATH" >/dev/null
    sudo udevadm control --reload
    echo "Installed udev script."
}

install_scripts() {
    # Install the first bash script to invoke on
    cp ./src/on_pchange "$SCRIPT_DIR"
    cp ./src/screen_mode "$SCRIPT_DIR"
    echo "Installed user scripts."
}

check_prerequisites
check_paths
install_systemd
install_udev
install_scripts
