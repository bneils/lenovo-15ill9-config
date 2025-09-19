# Lenovo 15ILL9 
(also goes by Lenovo Yoga Slim 7i Aura)

## Environment
* Kernel 6.16
* OpenSUSE Tumbleweed
* Wayland, KDE Plasma
* Intel Ultra 7 256V

## TLP (EAS scheduler)
Install `tlp` and enable with `systemctl enable --now tlp`. Ensure you are on kernel 6.16 or later to make use of Intel Energy Aware Scheduling using the `schedutil` governor. It is required to set `intel_pstate=passive` manually or via TLP to make use of it.

The script `enable` can be used to do this. If you'd like, run `./enable schedutil` to use EAS and `./enable powersave` to use the traditional driver. This will automatically apply the changes to TLP for you in the directory `/etc/tlp.d/` (ensure nothing is conflicting). You can experiment with disabling EAS, since it might actually *lower* power usage in some workloads. The only effect this will have is that load will be evenly distributed among all P and E-cores. 

Verify changes with `tlp-stat -p`.

## Sound
Install `sof-firmware` to fix sound.

## Suspend
Sleep disables fans upon resume. To enable hibernation you must change the power management settings and extend your swap page to your RAM size (16 or 32).

Please see my [script](https://github.com/bneils/yoga-slim-7i-aura-suspend) for a workaround.

## Wayland or X11
Wayland uses less power than X11, but has some bugs --- see below. I recommend it for laptops.

## LibreOffice
Unfortunately, one side effect under Wayland is that the LibreOffice suite (e.g Writer) is unusably laggy. It is recommended to use X11 for these applications by using `QT_QPA_PLATFORM=xcb` for each application launcher. This uses less power than setting X11 for all applications.

## Codecs
On OpenSUSE, you can install codecs by installing `opi` and running `opi codecs`.

Verify that `intel-media-driver` is installed and that `libva-intel-driver` or `Mesa-libva` is installed.

## Hardware acceleration

In Firefox, ensure you've done these things:

1. type `about:config` in the address bar.
2. type `gfx.webrender.all` and set it to true.
3. type `media.ffmpeg.vaapi.enabled` and set it to true.
4. type `gfx.webrender.software` and set it to false.
5. type `layers.acceleration.force-enabled` and set it to true.
6. type `layers.force-active` and set it to true.
7. type `media.rdd-vpx.enabled` and set it to true.
8. type `gfx.webrender.direct` and set it to true.

Firefox has poor defaults, so some of the above options might not be enabled by default. The `layers.*` options force hardware acceleration to be enabled.

[Source](https://www.reddit.com/r/linux/comments/xcikym/tutorial_how_to_enable_hardware_video/)

Open `about:support` and verify you see the line "Compositing: WebRender" and not "WebRender (Software)".

## Display

Here are three suggestions to decrease power usage in instances where Wayland is using a lot of your CPU:

1. Decrease brightness.

One major power drain is the display. Using a high brightness level can drain your battery, and some numbers suggest that power increases at about 0.4 watts / 10% brightness. You may want to purchase a matte screen film if your screen is glossy.

2. Set your display to 60 Hz.

If you are watching YouTube, you should set your display to 60 Hz to reduce the workload on your GPU.

3. Use an integer scaling factor (200% recommended).

Fractional scaling requires more compute than integer scaling. This is more noticeable in applications where Wayland completes more refreshes.
