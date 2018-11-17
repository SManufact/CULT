# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 0riginally created by Escalade (https://github.com/escalade)
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

PKG_NAME="retroarch-assets"
PKG_VERSION="488ef47233623af1b09977d6f9b7e63cd554f162"
PKG_SHA256="b38b84e2b661c3a914a9e1834060dd20f5c2636b7517b2eb30940b7a4e1ebe32"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/francescoricciardi/retroarch-assets-CULT"
PKG_URL="https://github.com/francescoricciardi/retroarch-assets-CULT/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="RetroArch assets. Background and icon themes for the menu drivers."
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  cd ../
  rm -rf .$TARGET_NAME
}

makeinstall_target() {
  make install DESTDIR=$INSTALL PREFIX=/usr
}

post_makeinstall_target() {
  mv $INSTALL/usr/share/libretro $INSTALL/usr/share/retroarch
}
