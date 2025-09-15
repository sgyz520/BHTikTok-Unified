#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BHIManager : NSObject

// 下载功能
+ (BOOL)hideAds;
+ (BOOL)downloadVideos;
+ (BOOL)downloadMusics;
+ (BOOL)downloadHDVideos;
+ (BOOL)downloadWithoutWatermark;

// 界面功能
+ (BOOL)hideElementButton;
+ (BOOL)progressBar;
+ (BOOL)autoPlay;
+ (BOOL)extendedBio;
+ (BOOL)extendedComment;
+ (BOOL)hideTabBarLabels;
+ (BOOL)hideSearchBar;

// 复制功能
+ (BOOL)copyVideoDescription;
+ (BOOL)copyMusicLink;
+ (BOOL)copyVideoLink;
+ (BOOL)profileSave;
+ (BOOL)profileCopy;

// 确认功能
+ (BOOL)likeConfirmation;
+ (BOOL)likeCommentConfirmation;
+ (BOOL)dislikeCommentConfirmation;
+ (BOOL)followConfirmation;
+ (BOOL)shareConfirmation;

// 地区功能
+ (BOOL)alwaysOpenSafari;
+ (BOOL)regionChangingEnabled;
+ (NSDictionary *)selectedRegion;
+ (NSArray *)availableRegions;
+ (BOOL)showRegionInfo;
+ (BOOL)showUploadTime;
+ (NSString *)formatUploadDate:(NSDate *)date;
+ (NSString *)getRegionDisplayName:(NSString *)region;
+ (NSString *)getIPLocationFromModel:(id)model;

// 伪造功能
+ (BOOL)fakeChangesEnabled;
+ (BOOL)fakeVerified;
+ (NSNumber *)fakeFollowerCount;
+ (NSNumber *)fakeFollowingCount;
+ (NSString *)fakeUsername;

// 安全功能
+ (BOOL)appLock;
+ (BOOL)biometricAuth;
+ (BOOL)passcodeAuth;

// 外观功能
+ (UIColor *)accentColor;
+ (BOOL)darkModeForced;
+ (BOOL)customThemeEnabled;
+ (NSDictionary *)customTheme;

// 隐私功能
+ (BOOL)hideOnlineStatus;
+ (BOOL)hideReadReceipts;
+ (BOOL)hideTypingIndicator;
+ (BOOL)disableAnalytics;

// 实用工具
+ (void)showSaveVC:(id)item;
+ (void)cleanCache;
+ (void)resetAllSettings;
+ (BOOL)isEmpty:(NSURL *)url;
+ (NSString *)getDownloadingPersent:(float)per;

// 本地化支持
+ (NSString *)localizedStringForKey:(NSString *)key;
+ (void)setPreferredLanguage:(NSString *)language;
+ (NSString *)currentLanguage;
+ (NSArray *)supportedLanguages;

// 版本信息
+ (NSString *)version;
+ (NSString *)buildNumber;
+ (NSDictionary *)systemInfo;

@end