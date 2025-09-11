ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BHTikTokUnified

# 源文件配置
BHTikTokUnified_FILES = Tweak.x
BHTikTokUnified_FILES += Core/BHIManager.m
BHTikTokUnified_FILES += Core/BHDownload.m
BHTikTokUnified_FILES += Core/BHMultipleDownload.m
BHTikTokUnified_FILES += Controllers/SettingsViewController.m
BHTikTokUnified_FILES += Controllers/SecurityViewController.m
BHTikTokUnified_FILES += Views/BHRegionInfoView.m

# 第三方库文件
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUD.m
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUDAnimation.m
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUDErrorIndicatorView.m
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUDFadeAnimation.m
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUDFadeZoomAnimation.m
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUDImageIndicatorView.m
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUDIndeterminateIndicatorView.m
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUDIndicatorView.m
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUDPieIndicatorView.m
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUDRingIndicatorView.m
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUDShadow.m
BHTikTokUnified_FILES += 库/JGProgressHUD/JGProgressHUDSuccessIndicatorView.m

# 编译选项
BHTikTokUnified_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable
BHTikTokUnified_FRAMEWORKS = UIKit Foundation AVFoundation Photos LocalAuthentication
BHTikTokUnified_PRIVATE_FRAMEWORKS = Preferences PreferencesUI

# 包信息
DISPLAY_NAME = TikTok
BUNDLE_ID = com.zhiliaoapp.musically

include $(THEOS_MAKE_PATH)/tweak.mk

# 设置界面包
SUBPROJECTS += BHTikTokUnifiedPrefs
include $(THEOS_MAKE_PATH)/aggregate.mk

# 安装后操作
after-install::
	install.exec "sbreload"

# 清理操作
clean::
	rm -rf packages/*
	rm -rf .theos/*

# 打包配置
package::
	@echo "正在打包 BHTikTok Unified..."
	@echo "版本: $(shell grep '^Version:' control | cut -d' ' -f2)"
	@echo "目标: $(BUNDLE_ID)"

# 开发者调试
debug::
	@echo "=== BHTikTok Unified 调试信息 ==="
	@echo "架构: $(ARCHS)"
	@echo "目标: $(TARGET)"
	@echo "显示名称: $(DISPLAY_NAME)"
	@echo "Bundle ID: $(BUNDLE_ID)"
	@echo "源文件数量: $(words $(BHTikTokUnified_FILES))"
	@echo "================================"

# 本地化资源复制
after-build::
	@echo "复制本地化资源..."
	mkdir -p $(THEOS_STAGING_DIR)/Library/Application\ Support/BHTikTokUnified/
	cp -r Resources/Localizations/* $(THEOS_STAGING_DIR)/Library/Application\ Support/BHTikTokUnified/ 2>/dev/null || true

# 版本信息
version:
	@echo "BHTikTok Unified Build System"
	@echo "基于 Theos $(THEOS_VERSION)"
	@echo "支持 iOS 14.0+"
