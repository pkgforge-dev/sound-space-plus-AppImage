#!/bin/sh

set -eux
ARCH="$(uname -m)"
BINARY="https://github.com/David20122/sound-space-plus/releases/latest/download/linux.zip"
EXTRA_PACKAGES="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"

echo "Installing dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	base-devel        \
	curl              \
	git               \
	libx11            \
	libxrandr         \
	libxss            \
	pulseaudio        \
	pulseaudio-alsa   \
	pipewire-audio    \
	sdl2              \
	unzip             \
	wget              \
	xorg-server-xvfb  \
	zsync

echo "Getting binary..."
echo "---------------------------------------------------------------"
if ! wget --retry-connrefused --tries=30 "$BINARY" -O /tmp/download.zip 2>/tmp/download.log; then
	cat /tmp/download.log
	exit 1
fi
awk -F'/' '/Location:/{print $(NF-1); exit}' /tmp/download.log > ~/version

mkdir -p ./AppDir/bin
unzip /tmp/download.zip -d ./AppDir/bin
chmod +x ./AppDir/bin/SoundSpacePlus."$ARCH"

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 "$EXTRA_PACKAGES" -O ./get-debloated-pkgs.sh
chmod +x ./get-debloated-pkgs.sh
./get-debloated-pkgs.sh --add-common


