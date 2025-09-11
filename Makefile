ARCHS = arm64 arm64e
TARGET := iphone:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BHTikTokUnified

BHTikTokUnified_FILES = Tweak.x $(wildcard Core/*.m) $(wildcard Controllers/*.m) $(wildcard Views/*.m) $(wildcard 库/JGProgressHUD/*.m)
BHTikTokUnified_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore CoreImage
BHTikTokUnified_EXTRA_FRAMEWORKS = Cephei CepheiPrefs
BHTikTokUnified_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-deprecated-implementations

SUBPROJECTS += BHTikTokUnifiedPrefs

include $(THEOS_MAKE_PATH)/tweak.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp BHTikTokUnified.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/$(ECHO_END)
	$(ECHO_NOTHING)rsync -a Resources/ $(THEOS_STAGING_DIR)/Library/Application\ Support/BHTikTokUnified/$(ECHO_END)
	$(ECHO_NOTHING)rsync -a Resources/Localizations/ $(THEOS_STAGING_DIR)/Library/Application\ Support/BHTikTokUnified/Localizations/$(ECHO_END)

after-install::
	install.exec "killall -9 SpringBoard"