#import <CepheiPrefs/CepheiPrefs.h>
#import <Cephei/HBPreferences.h>
#import "../Core/BHIManager.h"

@interface BHTikTokUnifiedPrefsListController : HBListController
@end

@implementation BHTikTokUnifiedPrefsListController

- (id)specifiers {
    if (_specifiers == nil) {
        NSMutableArray *specifiers = [NSMutableArray array];
        
        // 添加标题组
        HBPreferenceSpecifier *titleGroup = [[HBPreferenceSpecifier alloc] init];
        [titleGroup setName:@"BHTikTok Unified"];
        [specifiers addObject:titleGroup];
        
        // 添加版本信息
        HBPreferenceSpecifier *versionSpec = [[HBPreferenceSpecifier alloc] init];
        [versionSpec setName:@"Version"];
        [versionSpec setIdentifier:@"version"];
        [versionSpec setProperty:@"25.9.10" forKey:@"default"];
        [specifiers addObject:versionSpec];
        
        // 添加作者信息
        HBPreferenceSpecifier *authorSpec = [[HBPreferenceSpecifier alloc] init];
        [authorSpec setName:@"Author"];
        [authorSpec setIdentifier:@"author"];
        [authorSpec setProperty:@"BHTikTok Unified Team" forKey:@"default"];
        [specifiers addObject:authorSpec];
        
        // 添加功能设置组
        HBPreferenceSpecifier *settingsGroup = [[HBPreferenceSpecifier alloc] init];
        [settingsGroup setName:@"功能设置"];
        [specifiers addObject:settingsGroup];
        
        // 添加下载功能开关
        HBPreferenceSpecifier *downloadSwitch = [[HBPreferenceSpecifier alloc] init];
        [downloadSwitch setName:@"启用下载功能"];
        [downloadSwitch setIdentifier:@"enableDownload"];
        [downloadSwitch setProperty:@YES forKey:@"default"];
        [downloadSwitch setTarget:self];
        [downloadSwitch setSetAction:@selector(setPreferenceValue:forSpecifier:)];
        [downloadSwitch setGetAction:@selector(readPreferenceValue:)];
        [specifiers addObject:downloadSwitch];
        
        // 添加地区信息显示开关
        HBPreferenceSpecifier *regionSwitch = [[HBPreferenceSpecifier alloc] init];
        [regionSwitch setName:@"显示地区信息"];
        [regionSwitch setIdentifier:@"showRegionInfo"];
        [regionSwitch setProperty:@YES forKey:@"default"];
        [regionSwitch setTarget:self];
        [regionSwitch setSetAction:@selector(setPreferenceValue:forSpecifier:)];
        [regionSwitch setGetAction:@selector(readPreferenceValue:)];
        [specifiers addObject:regionSwitch];
        
        // 添加上传时间显示开关
        HBPreferenceSpecifier *uploadTimeSwitch = [[HBPreferenceSpecifier alloc] init];
        [uploadTimeSwitch setName:@"显示上传时间"];
        [uploadTimeSwitch setIdentifier:@"showUploadTime"];
        [uploadTimeSwitch setProperty:@YES forKey:@"default"];
        [uploadTimeSwitch setTarget:self];
        [uploadTimeSwitch setSetAction:@selector(setPreferenceValue:forSpecifier:)];
        [uploadTimeSwitch setGetAction:@selector(readPreferenceValue:)];
        [specifiers addObject:uploadTimeSwitch];
        
        // 添加复制功能组
        HBPreferenceSpecifier *copyGroup = [[HBPreferenceSpecifier alloc] init];
        [copyGroup setName:@"复制功能"];
        [specifiers addObject:copyGroup];
        
        // 添加复制视频描述开关
        HBPreferenceSpecifier *copyDescSwitch = [[HBPreferenceSpecifier alloc] init];
        [copyDescSwitch setName:@"复制视频描述"];
        [copyDescSwitch setIdentifier:@"copyVideoDecription"];
        [copyDescSwitch setProperty:@YES forKey:@"default"];
        [copyDescSwitch setTarget:self];
        [copyDescSwitch setSetAction:@selector(setPreferenceValue:forSpecifier:)];
        [copyDescSwitch setGetAction:@selector(readPreferenceValue:)];
        [specifiers addObject:copyDescSwitch];
        
        // 添加复制视频链接开关
        HBPreferenceSpecifier *copyLinkSwitch = [[HBPreferenceSpecifier alloc] init];
        [copyLinkSwitch setName:@"复制视频链接"];
        [copyLinkSwitch setIdentifier:@"copyVideoLink"];
        [copyLinkSwitch setProperty:@YES forKey:@"default"];
        [copyLinkSwitch setTarget:self];
        [copyLinkSwitch setSetAction:@selector(setPreferenceValue:forSpecifier:)];
        [copyLinkSwitch setGetAction:@selector(readPreferenceValue:)];
        [specifiers addObject:copyLinkSwitch];
        
        // 添加复制音乐链接开关
        HBPreferenceSpecifier *copyMusicSwitch = [[HBPreferenceSpecifier alloc] init];
        [copyMusicSwitch setName:@"复制音乐链接"];
        [copyMusicSwitch setIdentifier:@"copyMusicLink"];
        [copyMusicSwitch setProperty:@YES forKey:@"default"];
        [copyMusicSwitch setTarget:self];
        [copyMusicSwitch setSetAction:@selector(setPreferenceValue:forSpecifier:)];
        [copyMusicSwitch setGetAction:@selector(readPreferenceValue:)];
        [specifiers addObject:copyMusicSwitch];
        
        // 添加关于组
        HBPreferenceSpecifier *aboutGroup = [[HBPreferenceSpecifier alloc] init];
        [aboutGroup setName:@"关于"];
        [specifiers addObject:aboutGroup];
        
        // 添加关于按钮
        HBPreferenceSpecifier *aboutButton = [[HBPreferenceSpecifier alloc] init];
        [aboutButton setName:@"关于"];
        [aboutButton setIdentifier:@"about"];
        [aboutButton setButtonAction:@selector(showAbout)];
        [specifiers addObject:aboutButton];
        
        _specifiers = specifiers;
    }
    
    return _specifiers;
}

- (id)readPreferenceValue:(HBPreferenceSpecifier*)specifier {
    NSString *key = [specifier identifier];
    id defaultValue = [specifier properties][@"default"];
    
    // 从BHIManager获取设置值
    if ([key isEqualToString:@"enableDownload"]) {
        return @([BHIManager downloadVideos]);
    } else if ([key isEqualToString:@"showRegionInfo"]) {
        return @([BHIManager showRegionInfo]);
    } else if ([key isEqualToString:@"showUploadTime"]) {
        return @([BHIManager showUploadTime]);
    } else if ([key isEqualToString:@"copyVideoDecription"]) {
        return @([BHIManager copyVideoDecription]);
    } else if ([key isEqualToString:@"copyVideoLink"]) {
        return @([BHIManager copyVideoLink]);
    } else if ([key isEqualToString:@"copyMusicLink"]) {
        return @([BHIManager copyMusicLink]);
    } else if ([key isEqualToString:@"version"]) {
        return @"25.9.10";
    } else if ([key isEqualToString:@"author"]) {
        return @"BHTikTok Unified Team";
    }
    
    return defaultValue;
}

- (void)setPreferenceValue:(id)value forSpecifier:(HBPreferenceSpecifier*)specifier {
    NSString *key = [specifier identifier];
    
    // 保存设置值到NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
    
    // 注意：BHIManager类中没有对应的setter方法，所以这里只保存到NSUserDefaults
    // 实际的功能实现应该在BHIManager内部读取这些NSUserDefaults值
}

- (void)showAbout {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关于 BHTikTok Unified"
                                                    message:@"功能强大的 TikTok 增强插件，整合版本结合完整功能实现与多语言支持。\n\n基于 @hahios-2506 的 BHTiktok 和 @dayanch96 的 BHTikTok-Plus 项目"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

@end