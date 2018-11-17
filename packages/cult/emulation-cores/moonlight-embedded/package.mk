# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="moonlight-embedded"
PKG_VERSION="e21e207" #v2.4.7+
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/irtimmer/moonlight-embedded"
PKG_URL="https://github.com/irtimmer/moonlight-embedded.git"
PKG_DEPENDS_TARGET="toolchain alsa-lib avahi curl enet expat ffmpeg libcec libevdev pulseaudio openssl opus SDL2-git SDL_GameControllerDB systemd"
PKG_LONGDESC="Moonlight Embedded is an open source implementation of NVIDIA's GameStream, as used by the NVIDIA Shield, but built for Linux."
GET_HANDLER_SUPPORT="git"

if [ "$PROJECT" = "RPi" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET bcm2835-driver"
elif [ "$PROJECT" = "Generic" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libvdpau libxcb"
fi

post_makeinstall_target() {
  #cleanup
  rm -rf $INSTALL/usr/share
  rm -rf $INSTALL/usr/etc
  
  #create directories
  mkdir -p $INSTALL/etc/moonlight
  mkdir -p $INSTALL/usr/config/moonlight
  mkdir -p $INSTALL/usr/share/moonlight

  #copy config files
  ln -sf /usr/config/moonlight/moonlight.conf $INSTALL/etc/moonlight/
  ln -sf /usr/config/SDL-GameControllerDB/gamecontrollerdb.txt $INSTALL/usr/share/moonlight/
  ln -sf /usr/config/SDL-GameControllerDB/gamecontrollerdb.txt $INSTALL/usr/config/moonlight/
  cp -PR $PKG_DIR/config/* $INSTALL/usr/config/moonlight/
  cp -PR $PKG_DIR/scripts/* $INSTALL/usr/bin/
}               
