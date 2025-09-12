# Lenovo 15ILL9
Install `tlp` and enable with `systemctl enable --now tlp`. Ensure you are on kernel 6.16 or later to make use of Intel Energy Aware Scheduling using the schedutil governor. It is required to set `intel_pstate=passive` manually or via TLP to make use of it. Note that without this, the scheduler might not prefer E-cores over P-cores.

Verify changes with `tlp-stat -p`.

# Sound
Install `sof-firmware` to fix sound.

# Codecs
On OpenSUSE, you can install codecs by installing `opi` and running `opi codecs`.
