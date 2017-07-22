#
# Copyright (C) 2007-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=mt7612u
PKG_VERSION:=2.2.2
PKG_RELEASE:=3
PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/lioliy/mt7612u.git
PKG_SOURCE_VERSION:=1fc9c0ea1a1d05bd009b7c2702cf8d0c738f59b2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_PARALLEL:=1
PKG_MAINTAINER:=lioliy <lioliy@my.com>
PKG_LICENSE:=GPLv2

include $(INCLUDE_DIR)/package.mk

MAKE_OPTS:= \
	ARCH="$(LINUX_KARCH)" \
	CROSS_COMPILE="$(KERNEL_CROSS)" \
	KSRC="$(LINUX_DIR)" \
	KVER="$(LINUX_VERSION)" \
	M="$(PKG_BUILD_DIR)" \

define KernelPackage/$(PKG_NAME)
	SUBMENU:=Wireless Drivers
	TITLE:=Driver for mt7612u wireless adapters
	FILES:=$(PKG_BUILD_DIR)/mt7612u.$(LINUX_KMOD_SUFFIX)
	DEPENDS:=+wireless-tools +kmod-mac80211 @USB_SUPPORT
	AUTOLOAD:=$(call AutoProbe,mt7612u)
endef

define KernelPackage/$(PKG_NAME)/description
  This package contains a rewritten driver for usb wireless adapters based on the mediatek mt7612u chip by ulli-kroll
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_OPTS)
endef

define KernelPackage/mt7612u/install
	$(INSTALL_DIR) $(1)/lib/modules/$(LINUX_VERSION)
endef

$(eval $(call KernelPackage,$(PKG_NAME)))
