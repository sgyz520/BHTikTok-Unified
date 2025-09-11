include $(THEOS)/makefiles/common.mk

SYSROOT = $(THEOS)/sdks/iPhoneOS.sdk

BUNDLE_NAME = BHTikTokUnifiedPrefs
BHTikTokUnifiedPrefs_FILES = Entry.m ../Core/BHIManager.m
BHTikTokUnifiedPrefs_FRAMEWORKS = UIKit Foundation
BHTikTokUnifiedPrefs_PRIVATE_FRAMEWORKS =
BHTikTokUnifiedPrefs_EXTRA_FRAMEWORKS = Cephei CepheiPrefs
BHTikTokUnifiedPrefs_INSTALL_PATH = /Library/PreferenceBundles
BHTikTokUnifiedPrefs_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-deprecated-implementations -F$(SYSROOT)/System/Library/Frameworks -F$(SYSROOT)/System/Library/PrivateFrameworks

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp Entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BHTikTokUnifiedPrefs.plist$(ECHO_END)