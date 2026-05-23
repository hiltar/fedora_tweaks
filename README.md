# Tweaks for Fedora
These tweaks will improve Fedora

## Encryption

[TPM documentation](https://wiki.archlinux.org/title/Trusted_Platform_Module)

```
sudo dnf install tpm2-tools
sudo lsblk # search for luks volume
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/sdX # nvme0n1p3

# add tpm2-device=auto in /etc/crypttab

sudo dracut -f
```

---

## Drivers

### Install drivers
```
sudo dnf install intel-media-driver libva libva-utils gstreamer1-vaapi ffmpeg intel-gpu-tools mesa-dri-drivers mpv
```

### Codecs
```
sudo dnf install gstreamer1-plugins-{bad-*,good-*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
```

---

## Firmware
```
sudo dnf install gnome-firmware fwupd
# Check firmware
fwupdmgr refresh
# Update firmware
fwupdmgr get-updates
# Install firmware updates
fwupdmgr update

# Gnome Firmware GUI
gnome-firmware
```

---

## Trackpoint

```
# To change speed & sensitivity, create a file
sudo vim /usr/share/libinput/local-overrides.quirks
# With contents:
[Trackpoint Override]

MatchUdevType=pointingstick

AttrTrackpointMultiplier=.75
```

---

## Updates with dnf

```
# Upgrading to new version
sudo dnf upgrade --refresh
sudo dnf autoremove
sudo dnf install dnf-plugin-system-upgrade
sudo dnf system-upgrade download --releasever=XX
sudo dnf system-upgrade reboot
# If any errors occurs
sudo dnf system-upgrade download --releasever=XX --allowerasing

# Safer updates if upgrading with dnf
sudo dnf offline-upgrade download
sudo dnf offline-upgrade reboot
```

---

### Delete repositories
```
dnf repolist
sudo dnf config-manager --set-disabled REPO
```

---

## Bugs

### Slow booting into OS
```
# Systemd-analyze shows the OS boot time
systemd-analyze
systemd-analyze blame
systemd-analyze critical-chain

# Unnecessary services to be disabled
sudo systemctl disable iscsi
sudo systemctl disable NetworkManager-wait-online.service
```

---
