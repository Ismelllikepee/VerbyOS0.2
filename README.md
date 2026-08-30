# VerbyOS

VerbyOS is a Debian 13 (Trixie) based, amd64 live Linux desktop focused on a polished lightweight experience, gaming support, and an aggressively cute cat/bunny theme.

## Build

Requirements: a Debian 13/Ubuntu-like build host with root privileges, internet access, and `live-build` installed.

```bash
sudo apt update
sudo apt install live-build xorriso squashfs-tools debootstrap dosfstools mtools grub-pc-bin grub-efi-amd64-bin
sudo ./build.sh
```

The build produces `VerbyOS.iso` and `VerbyOS.iso.sha256` in the project root.

## Design

- Debian 13 Trixie, amd64
- XFCE desktop with a custom Python/GTK3 dock
- Daily local cat/bunny wallpaper rotation
- Saved wallpaper manager
- VerbyOS Settings
- Steam/Proton/Vulkan/GameMode/MangoHud tooling
- Legitimate launchers/install helpers for proprietary software
- Custom `verby-info`, `verby-wallpaper`, and `verby-update` commands

The included wallpapers are original SVG artwork created for this project, so the base ISO does not depend on downloading third-party images.

## Proprietary software

VerbyOS does not redistribute proprietary copies of Discord, Geometry Dash, Minecraft, or their assets. Helpers point users toward legitimate installation methods and detect software that is already installed.

## License

The VerbyOS code and scripts are MIT licensed. Debian packages remain under their respective licenses. See `LICENSE`.
