# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="oem"
PKG_VERSION="1.0"
PKG_LICENSE="various"
PKG_SITE="http://www.libreelec.tv"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="oem"
PKG_LONGDESC="OEM: Metapackage for various OEM packages"

PKG_TOOLCHAIN="manual"

OEM_APPS_COMMON=" \
  ds4drv \
  htop \
  mc \
  sdl-jstest \
  spectre-meltdown-checker"

OEM_APPS_AMLOGIC=""

OEM_APPS_GENERIC=" \
  dmidecode \
  smartmontools"

OEM_APPS_RPI=""

OEM_EMU_COMMON=" \
  emulationstation-retropie \
  retroarch \
  dosbox-sdl2 \
  lr-bluemsx \
  lr-bsnes-mercury-accuracy \
  lr-dosbox \
  lr-fbalpha2018 \
  lr-fceumm \
  lr-fuse \
  lr-gambatte \
  lr-genplus \
  lr-mame2003-plus \
  lr-mame2010 \
  lr-mupen64plus \
  lr-nestopia \
  lr-snes9x \
  lr-snes9x2010 \
  lr-vice"

OEM_EMU_AMLOGIC=""

OEM_EMU_GENERIC=""

OEM_EMU_RPI=""

if [ "$OEM_APPS" == "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_APPS_COMMON"
  case $PROJECT in
    Amlogic)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_APPS_AMLOGIC"
      ;;
    Generic)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_APPS_GENERIC"
      ;;
    RPi*)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_APPS_RPI"
      ;;
  esac
fi

if [ "$OEM_EMU" == "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_EMU_COMMON"
  case $PROJECT in
    Amlogic)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_EMU_AMLOGIC"
      ;;
    Generic)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_EMU_GENERIC"
      ;;
    RPi*)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OEM_EMU_RPI"
      ;;
  esac
fi

makeinstall_target() {
  mkdir -p $INSTALL
  cp -PR $PKG_DIR/files/common/* $INSTALL
  cp -PR $PKG_DIR/files/$PROJECT/* $INSTALL
}
