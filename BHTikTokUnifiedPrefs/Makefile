ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BHTikTokUnifiedPrefs

# 源文件配置
BHTikTokUnifiedPrefs_FILES = Entry.m
BHTikTokUnifiedPrefs_FILES += ../Controllers/SettingsViewController.m
BHTikTokUnifiedPrefs_FILES += ../Controllers/SecurityViewController.m
BHTikTokUnifiedPrefs_FILES += ../Core/BHIManager.m
BHTikTokUnifiedPrefs_FILES += ../Core/BHDownload.m
BHTikTokUnifiedPrefs_FILES += ../Core/BHMultipleDownload.m
BHTikTokUnifiedPrefs_FILES += ../Views/BHRegionInfoView.m

# 编译选项
BHTikTokUnifiedPrefs_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable
BHTikTokUnifiedPrefs_FRAMEWORKS = UIKit Foundation
BHTikTokUnifiedPrefs_PRIVATE_FRAMEWORKS = Preferences

# 包信息
BHTikTokUnifiedPrefs_INSTALL_PATH = /Library/PreferenceBundles
BHTikTokUnifiedPrefs_LDFLAGS = -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BHTikTokUnifiedPrefs.plist$(ECHO_END)