#
# Copyright (C) 2007-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=mt7612u
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/ulli-kroll/mt7612u.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=a4265cca30130deb7be04a8ff65a918e795bf78c
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_BUILD_PARALLEL:=1

PKG_MAINTAINER:=lioliy <lioliy@my.com>

include $(INCLUDE_DIR)/package.mk

WMENU:=Wireless Drivers

define KernelPackage/mt7612u
	SUBMENU:=Wireless Drivers
	TITLE:=Driver for mt7612u wireless adapters
	FILES:=$(PKG_BUILD_DIR)/mt7612u.$(LINUX_KMOD_SUFFIX)
	DEPENDS:=+wireless-tools +kmod-mac80211 @USB_SUPPORT @LINUX_3_X
	AUTOLOAD:=$(call AutoProbe,mt7612u)
endef

define KernelPackage/mt7612u/description
  This package contains a rewritten driver for usb wireless adapters based on the mediatek mt7612u chip by kuba-moo
endef

mt7612u_MAKEOPTS= -C $(PKG_BUILD_DIR) \
	KERNELRELEASE="$(LINUX_VERSION)" \
	KDIR="(KERNEL_BUILD_DIR)" \
	TARGET="$(HAL_TARGET)" \
	ARCH="$(LINUX_KARCH)"

define Build/Compile
	$(MAKE) $(mt7612u_MAKEOPTS)
endef

define KernelPackage/mt7612u/install
	$(INSTALL_DIR) $(1)/lib/modules/$(LINUX_VERSION)
endef

$(eval $(call KernelPackage,mt7612u))
