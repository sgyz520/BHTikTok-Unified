#import "BHIManager.h"
#import "../Headers/TikTokHeaders.h"

@implementation BHIManager

#pragma mark - 下载功能

+ (BOOL)hideAds {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"hide_ads"];
}

+ (BOOL)downloadVideos {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"dw_videos"];
}

+ (BOOL)downloadMusics {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"dw_musics"];
}

+ (BOOL)downloadHDVideos {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"dw_hd_videos"];
}

+ (BOOL)downloadWithoutWatermark {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"dw_without_watermark"];
}

#pragma mark - 界面功能

+ (BOOL)hideElementButton {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"remove_elements_button"];
}

+ (BOOL)progressBar {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"show_progress_bar"];
}

+ (BOOL)autoPlay {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"auto_play"];
}

+ (BOOL)extendedBio {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"extended_bio"];
}

+ (BOOL)extendedComment {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"extendedComment"];
}

+ (BOOL)hideTabBarLabels {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"hide_tabbar_labels"];
}

+ (BOOL)hideSearchBar {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"hide_search_bar"];
}

#pragma mark - 复制功能

+ (BOOL)copyVideoDescription {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"copy_description"];
}

+ (BOOL)copyMusicLink {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"copy_music_link"];
}

+ (BOOL)copyVideoLink {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"copy_video_link"];
}

+ (BOOL)profileSave {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"save_profile"];
}

+ (BOOL)profileCopy {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"copy_profile_information"];
}

#pragma mark - 确认功能

+ (BOOL)likeConfirmation {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"like_confirm"];
}

+ (BOOL)likeCommentConfirmation {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"like_comment_confirm"];
}

+ (BOOL)dislikeCommentConfirmation {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"dislike_comment_confirm"];
}

+ (BOOL)followConfirmation {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"follow_confirm"];
}

+ (BOOL)shareConfirmation {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"share_confirm"];
}

#pragma mark - 地区功能

+ (BOOL)alwaysOpenSafari {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"openInBrowser"];
}

+ (BOOL)regionChangingEnabled {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"en_region"];
}

+ (NSDictionary *)selectedRegion {
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"region"];
}

+ (NSArray *)availableRegions {
    return @[
        @{@"name": @"United States", @"code": @"US", @"flag": @"🇺🇸", @"cities": @[@"New York", @"Los Angeles", @"Chicago", @"Houston", @"Phoenix"]},
        @{@"name": @"China", @"code": @"CN", @"flag": @"🇨🇳", @"cities": @[@"Beijing", @"Shanghai", @"Guangzhou", @"Shenzhen", @"Hangzhou"]},
        @{@"name": @"Japan", @"code": @"JP", @"flag": @"🇯🇵", @"cities": @[@"Tokyo", @"Osaka", @"Kyoto", @"Yokohama", @"Nagoya"]},
        @{@"name": @"South Korea", @"code": @"KR", @"flag": @"🇰🇷", @"cities": @[@"Seoul", @"Busan", @"Incheon", @"Daegu", @"Daejeon"]},
        @{@"name": @"United Kingdom", @"code": @"GB", @"flag": @"🇬🇧", @"cities": @[@"London", @"Manchester", @"Birmingham", @"Liverpool", @"Leeds"]},
        @{@"name": @"Germany", @"code": @"DE", @"flag": @"🇩🇪", @"cities": @[@"Berlin", @"Munich", @"Hamburg", @"Cologne", @"Frankfurt"]},
        @{@"name": @"France", @"code": @"FR", @"flag": @"🇫🇷", @"cities": @[@"Paris", @"Lyon", @"Marseille", @"Toulouse", @"Nice"]},
        @{@"name": @"Canada", @"code": @"CA", @"flag": @"🇨🇦", @"cities": @[@"Toronto", @"Vancouver", @"Montreal", @"Calgary", @"Ottawa"]},
        @{@"name": @"Australia", @"code": @"AU", @"flag": @"🇦🇺", @"cities": @[@"Sydney", @"Melbourne", @"Brisbane", @"Perth", @"Adelaide"]},
        @{@"name": @"Brazil", @"code": @"BR", @"flag": @"🇧🇷", @"cities": @[@"São Paulo", @"Rio de Janeiro", @"Brasília", @"Salvador", @"Fortaleza"]},
        @{@"name": @"India", @"code": @"IN", @"flag": @"🇮🇳", @"cities": @[@"Mumbai", @"Delhi", @"Bangalore", @"Hyderabad", @"Chennai"]},
        @{@"name": @"Russia", @"code": @"RU", @"flag": @"🇷🇺", @"cities": @[@"Moscow", @"Saint Petersburg", @"Novosibirsk", @"Yekaterinburg", @"Kazan"]}
    ];
}

+ (BOOL)showRegionInfo {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"show_region_info"];
}

+ (BOOL)showUploadTime {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"show_upload_time"];
}

+ (NSString *)formatUploadDate:(NSDate *)date {
    if (!date) return @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:[self currentLanguage]];
    
    return [formatter stringFromDate:date];
}

+ (NSString *)getRegionDisplayName:(NSString *)region {
    if (!region || region.length == 0) return @"";
    
    NSArray *regions = [self availableRegions];
    for (NSDictionary *regionInfo in regions) {
        if ([regionInfo[@"code"] isEqualToString:region]) {
            return regionInfo[@"name"];
        }
    }
    
    // 如果没有找到，返回原始代码
    return region;
}

+ (NSString *)getIPLocationFromModel:(id)model {
    if (!model) return @"";
    
    // 尝试从模型中获取IP位置信息
    if ([model respondsToSelector:@selector(ipInfo)]) {
        NSDictionary *ipInfo = [model ipInfo];
        if (ipInfo && [ipInfo isKindOfClass:[NSDictionary class]]) {
            NSString *country = ipInfo[@"country"];
            NSString *city = ipInfo[@"city"];
            
            if (country && city) {
                // 获取国家名称
                NSString *countryName = [self getRegionDisplayName:country];
                return [NSString stringWithFormat:@"%@ %@", countryName, city];
            } else if (country) {
                // 获取国家名称
                NSString *countryName = [self getRegionDisplayName:country];
                return countryName;
            }
        }
    }
    
    // 尝试从region字段获取
    if ([model respondsToSelector:@selector(region)]) {
        NSString *region = (NSString *)[model performSelector:@selector(region)];
        if (region && region.length > 0) {
            NSString *regionName = [self getRegionDisplayName:region];
            
            // 随机选择一个城市（模拟真实情况）
            NSArray *regions = [self availableRegions];
            for (NSDictionary *regionInfo in regions) {
                if ([regionInfo[@"code"] isEqualToString:region]) {
                    NSArray *cities = regionInfo[@"cities"];
                    if (cities && cities.count > 0) {
                        NSString *randomCity = cities[arc4random() % cities.count];
                        return [NSString stringWithFormat:@"%@ %@", regionName, randomCity];
                    }
                    return regionName;
                }
            }
            
            return regionName;
        }
    }
    
    // 如果没有获取到地区信息，使用当前选择的地区
    NSDictionary *selectedRegion = [self selectedRegion];
    if (selectedRegion && selectedRegion[@"name"]) {
        NSString *regionName = selectedRegion[@"name"];
        NSArray *cities = selectedRegion[@"cities"];
        if (cities && cities.count > 0) {
            NSString *randomCity = cities[arc4random() % cities.count];
            return [NSString stringWithFormat:@"%@ %@", regionName, randomCity];
        }
        return regionName;
    }
    
    // 默认返回空字符串
    return @"";
}

#pragma mark - 伪造功能

+ (BOOL)fakeChangesEnabled {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"en_fake"];
}

+ (BOOL)fakeVerified {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"fake_verify"];
}

+ (NSNumber *)fakeFollowerCount {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"fake_follower_count"];
}

+ (NSNumber *)fakeFollowingCount {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"fake_following_count"];
}

+ (NSString *)fakeUsername {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"fake_username"];
}

#pragma mark - 安全功能

+ (BOOL)appLock {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"padlock"];
}

+ (BOOL)biometricAuth {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"biometric_auth"];
}

+ (BOOL)passcodeAuth {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"passcode_auth"];
}

#pragma mark - 外观功能

+ (UIColor *)accentColor {
    NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"accent_color"];
    if (colorData) {
        if (@available(iOS 12.0, *)) {
            NSError *error = nil;
            UIColor *color = [NSKeyedUnarchiver unarchivedObjectOfClass:[UIColor class] fromData:colorData error:&error];
            if (error) {
                NSLog(@"[BHTikTok Unified] 解档颜色失败: %@", error.localizedDescription);
                return [UIColor colorWithRed:1.0 green:0.0 blue:0.5 alpha:1.0]; // 默认粉色
            }
            return color ?: [UIColor colorWithRed:1.0 green:0.0 blue:0.5 alpha:1.0];
        } else {
            return [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
        }
    }
    return [UIColor colorWithRed:1.0 green:0.0 blue:0.5 alpha:1.0]; // 默认粉色
}

+ (BOOL)darkModeForced {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"force_dark_mode"];
}

+ (BOOL)customThemeEnabled {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"custom_theme_enabled"];
}

+ (NSDictionary *)customTheme {
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"custom_theme"];
}

#pragma mark - 隐私功能

+ (BOOL)hideOnlineStatus {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"hide_online_status"];
}

+ (BOOL)hideReadReceipts {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"hide_read_receipts"];
}

+ (BOOL)hideTypingIndicator {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"hide_typing_indicator"];
}

+ (BOOL)disableAnalytics {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"disable_analytics"];
}

#pragma mark - 实用工具

+ (void)cleanCache {
    NSArray <NSURL *> *DocumentFiles = [[NSFileManager defaultManager] 
        contentsOfDirectoryAtURL:[NSURL fileURLWithPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject] 
        includingPropertiesForKeys:@[] 
        options:NSDirectoryEnumerationSkipsHiddenFiles 
        error:nil];
    
    NSArray *extensionsToClean = @[@"mp4", @"png", @"jpeg", @"jpg", @"mp3", @"m4a", @"mov", @"tmp"];
    
    for (NSURL *file in DocumentFiles) {
        if ([extensionsToClean containsObject:file.pathExtension.lowercaseString]) {
            [[NSFileManager defaultManager] removeItemAtURL:file error:nil];
        }
    }
    
    NSArray <NSURL *> *TempFiles = [[NSFileManager defaultManager] 
        contentsOfDirectoryAtURL:[NSURL fileURLWithPath:NSTemporaryDirectory()] 
        includingPropertiesForKeys:@[] 
        options:NSDirectoryEnumerationSkipsHiddenFiles 
        error:nil];
    
    for (NSURL *file in TempFiles) {
        if ([extensionsToClean containsObject:file.pathExtension.lowercaseString] || [file hasDirectoryPath]) {
            if ([file hasDirectoryPath] && [self isEmpty:file]) {
                [[NSFileManager defaultManager] removeItemAtURL:file error:nil];
            } else if (![file hasDirectoryPath]) {
                [[NSFileManager defaultManager] removeItemAtURL:file error:nil];
            }
        }
    }
    
    NSLog(@"[BHTikTok Unified] 缓存清理完成");
}

+ (void)resetAllSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [defaults dictionaryRepresentation];
    
    for (NSString *key in [dictionary allKeys]) {
        if ([key hasPrefix:@"BHTikTokUnified_"] || 
            [key hasPrefix:@"hide_"] || 
            [key hasPrefix:@"dw_"] || 
            [key hasPrefix:@"copy_"] || 
            [key hasPrefix:@"fake_"] ||
            [key hasPrefix:@"en_"]) {
            [defaults removeObjectForKey:key];
        }
    }
    
    [defaults synchronize];
    NSLog(@"[BHTikTok Unified] 所有设置已重置");
}

+ (BOOL)isEmpty:(NSURL *)url {
    NSArray *FolderFiles = [[NSFileManager defaultManager] 
        contentsOfDirectoryAtURL:url 
        includingPropertiesForKeys:@[] 
        options:NSDirectoryEnumerationSkipsHiddenFiles 
        error:nil];
    return FolderFiles.count == 0;
}

+ (void)showSaveVC:(id)item {
    UIActivityViewController *acVC = [[UIActivityViewController alloc] 
        initWithActivityItems:item 
        applicationActivities:nil];
    
    if (is_iPad()) {
        acVC.popoverPresentationController.sourceView = topMostController().view;
        acVC.popoverPresentationController.sourceRect = CGRectMake(
            topMostController().view.bounds.size.width / 2.0, 
            topMostController().view.bounds.size.height / 2.0, 
            1.0, 1.0
        );
    }
    
    [topMostController() presentViewController:acVC animated:true completion:nil];
}

+ (NSString *)getDownloadingPersent:(float)per {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    NSNumber *number = [NSNumber numberWithFloat:per];
    return [numberFormatter stringFromNumber:number];
}

#pragma mark - 本地化支持

+ (NSString *)localizedStringForKey:(NSString *)key {
    NSString *language = [self currentLanguage];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]];
    if (!bundle) {
        bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]];
    }
    return [bundle localizedStringForKey:key value:key table:@"BHTikTokUnified"];
}

+ (void)setPreferredLanguage:(NSString *)language {
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"BHTikTokUnified_Language"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)currentLanguage {
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"BHTikTokUnified_Language"];
    if (!language) {
        language = [[NSLocale preferredLanguages] firstObject];
    }
    return language;
}

+ (NSArray *)supportedLanguages {
    return @[
        @{@"code": @"en", @"name": @"English", @"nativeName": @"English"},
        @{@"code": @"zh-Hans", @"name": @"Chinese (Simplified)", @"nativeName": @"简体中文"},
        @{@"code": @"zh-Hant", @"name": @"Chinese (Traditional)", @"nativeName": @"繁體中文"},
        @{@"code": @"ja", @"name": @"Japanese", @"nativeName": @"日本語"},
        @{@"code": @"ko", @"name": @"Korean", @"nativeName": @"한국어"},
        @{@"code": @"es", @"name": @"Spanish", @"nativeName": @"Español"},
        @{@"code": @"fr", @"name": @"French", @"nativeName": @"Français"},
        @{@"code": @"de", @"name": @"German", @"nativeName": @"Deutsch"},
        @{@"code": @"ru", @"name": @"Russian", @"nativeName": @"Русский"},
        @{@"code": @"pl", @"name": @"Polish", @"nativeName": @"Polski"},
        @{@"code": @"tr", @"name": @"Turkish", @"nativeName": @"Türkçe"},
        @{@"code": @"uk", @"name": @"Ukrainian", @"nativeName": @"Українська"},
        @{@"code": @"vi", @"name": @"Vietnamese", @"nativeName": @"Tiếng Việt"},
        @{@"code": @"ar", @"name": @"Arabic", @"nativeName": @"العربية"}
    ];
}

#pragma mark - 版本信息

+ (NSString *)version {
    return @"25.9.10";
}

+ (NSString *)buildNumber {
    return @"100";
}

+ (NSDictionary *)systemInfo {
    return @{
        @"version": [self version],
        @"build": [self buildNumber],
        @"iOS": [[UIDevice currentDevice] systemVersion],
        @"device": [[UIDevice currentDevice] model],
        @"language": [self currentLanguage],
        @"timestamp": @([[NSDate date] timeIntervalSince1970])
    };
}

@end