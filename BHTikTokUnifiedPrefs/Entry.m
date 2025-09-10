#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import "../Core/BHIManager.h"

@interface BHTikTokUnifiedPrefsListController : PSListController
@end

@implementation BHTikTokUnifiedPrefsListController

- (id)specifiers {
    if (_specifiers == nil) {
        NSMutableArray *specifiers = [NSMutableArray array];
        
        // 添加标题组
        PSSpecifier *titleGroup = [PSSpecifier groupSpecifierWithName:@"BHTikTok Unified"];
        [titleGroup setName:@"BHTikTok Unified"];
        [specifiers addObject:titleGroup];
        
        // 添加版本信息
        PSSpecifier *versionSpec = [PSSpecifier preferenceSpecifierNamed:@"Version"
                                                                    target:self
                                                                       set:NULL
                                                                       get:NULL
                                                                    detail:Nil
                                                                      cell:PSStaticTextCell
                                                                      edit:Nil];
        [versionSpec setIdentifier:@"version"];
        [specifiers addObject:versionSpec];
        
        // 添加作者信息
        PSSpecifier *authorSpec = [PSSpecifier preferenceSpecifierNamed:@"Author"
                                                                   target:self
                                                                      set:NULL
                                                                      get:NULL
                                                                   detail:Nil
                                                                     cell:PSStaticTextCell
                                                                     edit:Nil];
        [authorSpec setIdentifier:@"author"];
        [specifiers addObject:authorSpec];
        
        // 添加功能设置组
        PSSpecifier *settingsGroup = [PSSpecifier groupSpecifierWithName:@"功能设置"];
        [settingsGroup setName:@"功能设置"];
        [specifiers addObject:settingsGroup];
        
        // 添加下载功能开关
        PSSpecifier *downloadSwitch = [PSSpecifier preferenceSpecifierNamed:@"启用下载功能"
                                                                       target:self
                                                                          set:@selector(setPreferenceValue:forSpecifier:)
                                                                          get:@selector(readPreferenceValue:)
                                                                       detail:Nil
                                                                         cell:PSSwitchCell
                                                                         edit:Nil];
        [downloadSwitch setIdentifier:@"enableDownload"];
        [downloadSwitch setDefaultValue:@YES];
        [specifiers addObject:downloadSwitch];
        
        // 添加地区信息显示开关
        PSSpecifier *regionSwitch = [PSSpecifier preferenceSpecifierNamed:@"显示地区信息"
                                                                     target:self
                                                                        set:@selector(setPreferenceValue:forSpecifier:)
                                                                        get:@selector(readPreferenceValue:)
                                                                     detail:Nil
                                                                       cell:PSSwitchCell
                                                                       edit:Nil];
        [regionSwitch setIdentifier:@"showRegionInfo"];
        [regionSwitch setDefaultValue:@YES];
        [specifiers addObject:regionSwitch];
        
        // 添加上传时间显示开关
        PSSpecifier *uploadTimeSwitch = [PSSpecifier preferenceSpecifierNamed:@"显示上传时间"
                                                                         target:self
                                                                            set:@selector(setPreferenceValue:forSpecifier:)
                                                                            get:@selector(readPreferenceValue:)
                                                                         detail:Nil
                                                                           cell:PSSwitchCell
                                                                           edit:Nil];
        [uploadTimeSwitch setIdentifier:@"showUploadTime"];
        [uploadTimeSwitch setDefaultValue:@YES];
        [specifiers addObject:uploadTimeSwitch];
        
        // 添加复制功能组
        PSSpecifier *copyGroup = [PSSpecifier groupSpecifierWithName:@"复制功能"];
        [copyGroup setName:@"复制功能"];
        [specifiers addObject:copyGroup];
        
        // 添加复制视频描述开关
        PSSpecifier *copyDescSwitch = [PSSpecifier preferenceSpecifierNamed:@"复制视频描述"
                                                                       target:self
                                                                          set:@selector(setPreferenceValue:forSpecifier:)
                                                                          get:@selector(readPreferenceValue:)
                                                                       detail:Nil
                                                                         cell:PSSwitchCell
                                                                         edit:Nil];
        [copyDescSwitch setIdentifier:@"copyVideoDecription"];
        [copyDescSwitch setDefaultValue:@YES];
        [specifiers addObject:copyDescSwitch];
        
        // 添加复制视频链接开关
        PSSpecifier *copyLinkSwitch = [PSSpecifier preferenceSpecifierNamed:@"复制视频链接"
                                                                       target:self
                                                                          set:@selector(setPreferenceValue:forSpecifier:)
                                                                          get:@selector(readPreferenceValue:)
                                                                       detail:Nil
                                                                         cell:PSSwitchCell
                                                                         edit:Nil];
        [copyLinkSwitch setIdentifier:@"copyVideoLink"];
        [copyLinkSwitch setDefaultValue:@YES];
        [specifiers addObject:copyLinkSwitch];
        
        // 添加复制音乐链接开关
        PSSpecifier *copyMusicSwitch = [PSSpecifier preferenceSpecifierNamed:@"复制音乐链接"
                                                                        target:self
                                                                           set:@selector(setPreferenceValue:forSpecifier:)
                                                                           get:@selector(readPreferenceValue:)
                                                                        detail:Nil
                                                                          cell:PSSwitchCell
                                                                          edit:Nil];
        [copyMusicSwitch setIdentifier:@"copyMusicLink"];
        [copyMusicSwitch setDefaultValue:@YES];
        [specifiers addObject:copyMusicSwitch];
        
        // 添加关于组
        PSSpecifier *aboutGroup = [PSSpecifier groupSpecifierWithName:@"关于"];
        [aboutGroup setName:@"关于"];
        [specifiers addObject:aboutGroup];
        
        // 添加关于按钮
        PSSpecifier *aboutButton = [PSSpecifier preferenceSpecifierNamed:@"关于"
                                                                   target:self
                                                                      set:NULL
                                                                      get:NULL
                                                                   detail:Nil
                                                                     cell:PSLinkCell
                                                                     edit:Nil];
        [aboutButton setIdentifier:@"about"];
        [aboutButton setProperty:@selector(showAbout) forKey:@"action"];
        [specifiers addObject:aboutButton];
        
        _specifiers = specifiers;
    }
    
    return _specifiers;
}

- (id)readPreferenceValue:(PSSpecifier*)specifier {
    NSString *key = [specifier identifier];
    id defaultValue = [specifier propertyForKey:@"default"];
    
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

- (void)setPreferenceValue:(id)value forSpecifier:(PSSpecifier*)specifier {
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
