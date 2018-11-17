# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 0riginally created by Escalade (https://github.com/escalade)
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="emulationstation-retropie"
PKG_VERSION="aedee61990169df5d2c47bd5d93bdabbc71eaf24"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/francescoricciardi/EmulationStation-CULT"
PKG_URL="https://github.com/francescoricciardi/EmulationStation-CULT.git"
PKG_DEPENDS_TARGET="toolchain SDL2-git freetype curl freeimage vlc emulationstation-theme-carbon"
PKG_LONGDESC="A Fork of Emulation Station for RetroPie. Emulation Station is a flexible emulator front-end supporting keyboardless navigation and custom system themes."
PKG_BUILD_FLAGS="-gold"
GET_HANDLER_SUPPORT="git"

if [ "$PROJECT" = "Amlogic" ]; then
  PKG_CMAKE_OPTS_TARGET=-DGLES=ON
fi

post_makeinstall_target() {  
  #create directories
  mkdir -p $INSTALL/etc/emulationstation
  mkdir -p $INSTALL/usr/config/emulationstation
  mkdir -p $INSTALL/usr/lib/tmpfiles.d
  ln -s /usr/config/emulationstation/es_systems.cfg $INSTALL/etc/emulationstation/
  ln -s /usr/config/emulationstation/themes $INSTALL/etc/emulationstation/themes
  
  #copy scripts
  cp $PKG_DIR/scripts/$PROJECT/* $INSTALL/usr/bin

  #copy resources
  cp -r $PKG_DIR/files/* $INSTALL/usr/config/emulationstation/
  cp -a ../resources $INSTALL/usr/config/emulationstation/

  #copy config files
  cp $PKG_DIR/config/emulationstation.conf $INSTALL/usr/config/emulationstation/
  cp $PKG_DIR/config/es_input.cfg $INSTALL/usr/config/emulationstation/
  cp $PKG_DIR/config/es_settings.cfg $INSTALL/usr/config/emulationstation/
  cp $PKG_DIR/config/$PROJECT/es_systems-$PROJECT.cfg $INSTALL/usr/config/emulationstation/es_systems.cfg
  cp $PKG_DIR/config/$PROJECT/emulationstation-userdirs-$PROJECT.conf $INSTALL/usr/lib/tmpfiles.d/emulationstation-userdirs.conf
}
