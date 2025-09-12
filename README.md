# Lenovo 15ILL9 
(also goes by Lenovo Yoga Slim 7i Aura)
## Environment
* Kernel 6.16
* OpenSUSE Tumbleweed
* Wayland, KDE Plasma
* Intel Ultra 7 256V

## TLP (EAS scheduler)
Install `tlp` and enable with `systemctl enable --now tlp`. Ensure you are on kernel 6.16 or later to make use of Intel Energy Aware Scheduling using the `schedutil` governor. It is required to set `intel_pstate=passive` manually or via TLP to make use of it.

If you'd like, you can experiment with disabling this setting, since it might actually *lower* power usage in some workloads. The only effect this will have is that load will be evenly distributed among all P and E-cores. 

Verify changes with `tlp-stat -p`.

## Sound
Install `sof-firmware` to fix sound.

## Codecs
On OpenSUSE, you can install codecs by installing `opi` and running `opi codecs`.

Verify that `intel-media-driver` is installed and that `libva-intel-driver` or `Mesa-libva` is installed.

## Hardware acceleration

In Firefox, ensure you've done these things:

1. type `about:config` in the address bar.
2. in the search bar type `gfx.webrender.all` and set it to true.
3. in the search bar type `media.ffmpeg.vaapi.enabled` and set it to true.

These are probably already done for you.

[Source](https://www.reddit.com/r/linux/comments/xcikym/tutorial_how_to_enable_hardware_video/)

Open `about:support` and verify you see the line "Compositing: WebRender" and not "WebRender (Software)".
