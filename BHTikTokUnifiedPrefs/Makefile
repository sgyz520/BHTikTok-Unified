include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BHTikTokUnifiedPrefs
TARGET := iphone:clang:16.5:14.0
BHTikTokUnifiedPrefs_FILES = Entry.m ../Core/BHIManager.m
BHTikTokUnifiedPrefs_FRAMEWORKS = UIKit Foundation
BHTikTokUnifiedPrefs_EXTRA_FRAMEWORKS = Cephei CepheiPrefs
BHTikTokUnifiedPrefs_INSTALL_PATH = /Library/PreferenceBundles
BHTikTokUnifiedPrefs_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-deprecated-implementations

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp Entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BHTikTokUnifiedPrefs.plist$(ECHO_END)
	$(ECHO_NOTHING)chmod +x $(THEOS_STAGING_DIR)/Library/PreferenceBundles/BHTikTokUnifiedPrefs.bundle/BHTikTokUnifiedPrefs$(ECHO_END)