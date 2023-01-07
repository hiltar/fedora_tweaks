# Tweaks for Fedora
These tweaks will improve Fedora

# Note: Silverblue / Kinoite

[Silverblue GNOME](https://silverblue.fedoraproject.org/)

[Kinoite KDE](https://kinoite.fedoraproject.org/)

[Kinoite Tweaks](/kinoite/README.md)

**It is recommended to use Fedora Silverblue (GNOME) or Fedora Kinoite (KDE) for laptop.**

**Silverblue/Kinoite is more secure due to it's design and is considered as main installation for laptops when there isn't backup system available (Backup to HDD, cloud backup, clone).**

**Think about this: laptops are used while travelling and sometimes, updates or any changes might produces errors that bricks the OS. In this scenario, user must carry either an OS image to access the bricked OS's disk contents or install the OS again. Unfortunately Silverblue/Kinoite is not immune to bricking but it has a unique recovery process as described below.**

**With Silverblue/Kinoite, user is able to downgrade or upgrade to any version of Fedora, because OS is separated from user's files. For example, if there is any problems with Fedora Silverblue/Kinoite Beta, user can downgrade to previous version from GRUB menu. This makes backups kind of useless, because user is able to use OS without breaking it. Of course, user files should be backed up.**

**Silverblue / Kinoite could be considered for desktop computers too. This section will be updated if Kinoite is considered better than regular Fedora Workstation installation**

---

## Sudo
```
# Assign Sudo Privileges to User
sudo usermod -a -G wheel $USER
# Remove Sudo Privileges from User
sudo gpasswd -d USER wheel

# Execute previous command with sudo
sudo !!
```

---

## Disk

### Encryption

#### Setup encryption

It is mandatory to setup encryption while doing partitions at installation

TODO

#### Setup TPM2

[TPM documentation](https://wiki.archlinux.org/title/Trusted_Platform_Module)

```
sudo dnf install tpm2-tools
sudo lsblk # search for luks volume
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/sdX # nvme0n1p3

# add tpm2-device=auto in /etc/crypttab

sudo dracut -f
```

### Cloning / Backups

```
sudo dnf install timeshift

# Initial setup
Select Snapshot Type: BTRFS

TODO

```

### Disaster recovery

TODO

---

## Drivers

### Install drivers
```
sudo dnf install intel-media-driver libva libva-utils gstreamer1-vaapi ffmpeg intel-gpu-tools mesa-dri-drivers mpv
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

## Audio

### Volume control
```
# Sets Media buttons raise & down volume
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-step 2
```

---

## Battery tweaks
```
sudo dnf install tlp tlp-rdw
```

---

## Display

### Display stuttering or some features isn't working as they should be
```
# Wayland is recommended
# X11 produces more heat etc.

# Log out, Gear > X11 > Log in
# Test X11

# Changing Wayland to X11
sudo vim /etc/gdm/custom.conf
# Uncomment #WaylandEnable=false line
# Add a new line into [daemon] section:
DefaultSession=gnome-xorg.desktop
```

### VAAPI / Hardware acceleration not working due to patents
[Phoronix article about VAAPI](https://www.phoronix.com/news/Fedora-Disable-Bad-VA-API)

```
# This affects only AMD users
# To build MESA with required codecs,
# installation script is found in
# ./scripts/amd folder

sh mesa_install.sh

### Cronjob TODO

```

---

## Fingerprint reader
[Installation guide](https://gist.github.com/borcean/f32c47f6cc52cee33dfc2265ce63f777)

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

## Flatpaks
```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# Install Flatpak applications from Software
```

---

## Repositories
```
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf upgrade --refresh
sudo dnf groupupdate core
```

### Delete repositories
```
dnf repolist
sudo dnf config-manager --set-disabled REPO
```

---

## Useful, missing packages
```
sudo dnf install openssl openssl-devel perl
```

---

## Bugs

### gjs quit unexpectedly
```
# Delete System Monitor
```

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

# Desktop Environments

## Desktop environment related notes

**For Intel HD Graphics, KDE should be better option than GNOME.**

**Generally, if user has touch capable display, GNOME could be good option. Otherwise, KDE should be installed as a main desktop environment because it doesn't need any modifications, like GNOME does. GNOME's modifications might have bugs and updates can break them.**

# KDE related changes
```
TODO
```

---

# GNOME related changes

## Gnome Tweaks
```
sudo dnf install gnome-tweaks
```
### Restore minimize & resize buttons
```
gnome-tweaks
# Window Titlebars > Titlebar Buttons: Maximize on, Minimize on
```

## Gnome Extensions
##### Google Chrome
https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep
##### Firefox
https://addons.mozilla.org/en-US/firefox/addon/gnome-shell-integration/

### User Themes
https://extensions.gnome.org/extension/19/user-themes/
```
mkdir ~/.themes
# Extract files & Move themes
tar xvf theme.gz.tar
mv -rf theme-folder ~/.themes

# To use themes, open Gnome Tweaks > Appearance
gnome-tweaks
```
![Neofetch](/pictures/neofetch.png)

### Fonts
Gnome Tweaks > Fonts
```
sudo dnf install 'google-roboto*' 'mozilla-fira*' fira-code-fonts
```

### Microsoft fonts
Standard font: Nimbus Roman

Serif font: Nimbus Roman

Sans-serif font: Nimbus Sans

Fixed-width font: Fira Code

***Better fonts***
```
sudo dnf install google-cousine-fonts
```

### Android integration
https://extensions.gnome.org/extension/1319/gsconnect/

***Android***

===========

Google Play > KDE Connect

Connect to Wifi

Accept pairing

Check settings

***Fedora 36***

===========

Install extension: https://extensions.gnome.org/extension/1319/gsconnect/

Pair Android

Check settings

---

## Games
```
sudo dnf install steam lutris
```

### Install Windows native games
Steam settings > Steam Play

Enable Steam Play for all other titles

Run other titles with: Proton version

Launch games via Lutris if best performance is needed

---

## Misc

### Copy file contents into clipboard
```
sudo dnf install xsel
cat tweakkeja.md | xsel --clipboard
```

### Console
```
# Minimal console to replace Terminal
sudo dnf install gnome-console
sudo dnf remove terminal
```

### Monitoring with btop
```
sudo dnf install btop
```

### Putty & File Transfer
```
sudo dnf install putty filezilla
```

### Traditional Alt+Tab
```
# Settings > Keyboard > View and Customize Shortcuts
# Search: Switch windows
# Assign shortcut, press Alt + Tab
```

---
