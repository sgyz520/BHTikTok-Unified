#import <CepheiPrefs/CepheiPrefs.h>
#import <Cephei/HBPreferences.h>
#import <Preferences/PSSpecifier.h>
#import "../Core/BHIManager.h"

@interface BHTikTokUnifiedPrefsListController : HBListController
@end

@implementation BHTikTokUnifiedPrefsListController

- (id)specifiers {
    if (_specifiers == nil) {
        NSMutableArray *specifiers = [NSMutableArray array];
        
        // 添加标题组
        HBPreferenceSpecifier *titleGroup = [HBPreferenceSpecifier groupSpecifierWithName:@"BHTikTok Unified"];
        [specifiers addObject:titleGroup];
        
        // 添加版本信息
        HBPreferenceSpecifier *versionSpec = [HBPreferenceSpecifier preferenceSpecifierNamed:@"Version"
                                                                                       target:self
                                                                                          set:NULL
                                                                                          get:@selector(readPreferenceValue:)
                                                                                       detail:nil
                                                                                         cell:PSTitleValueCell
                                                                                         edit:nil];
        [versionSpec setIdentifier:@"version"];
        [versionSpec setProperty:@"25.9.10" forKey:@"default"];
        [specifiers addObject:versionSpec];
        
        // 添加作者信息
        HBPreferenceSpecifier *authorSpec = [HBPreferenceSpecifier preferenceSpecifierNamed:@"Author"
                                                                                      target:self
                                                                                         set:NULL
                                                                                         get:@selector(readPreferenceValue:)
                                                                                      detail:Nil
                                                                                        cell:PSTitleValueCell
                                                                                        edit:Nil];
        [authorSpec setIdentifier:@"author"];
        [authorSpec setProperty:@"BHTikTok Unified Team" forKey:@"default"];
        [specifiers addObject:authorSpec];
        
        // 添加功能设置组
        HBPreferenceSpecifier *settingsGroup = [HBPreferenceSpecifier groupSpecifierWithName:@"Features"];
        [specifiers addObject:settingsGroup];
        
        // 添加下载功能开关
        HBPreferenceSpecifier *downloadSwitch = [HBPreferenceSpecifier preferenceSpecifierNamed:@"Enable Download"
                                                                                           target:self
                                                                                              set:@selector(setPreferenceValue:forSpecifier:)
                                                                                              get:@selector(readPreferenceValue:)
                                                                                           detail:Nil
                                                                                             cell:PSSwitchCell
                                                                                             edit:Nil];
        [downloadSwitch setIdentifier:@"enableDownload"];
        [downloadSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:downloadSwitch];
        
        // 添加地区信息显示开关
        HBPreferenceSpecifier *regionSwitch = [HBPreferenceSpecifier preferenceSpecifierNamed:@"Show Region Info"
                                                                                        target:self
                                                                                           set:@selector(setPreferenceValue:forSpecifier:)
                                                                                           get:@selector(readPreferenceValue:)
                                                                                        detail:Nil
                                                                                          cell:PSSwitchCell
                                                                                          edit:Nil];
        [regionSwitch setIdentifier:@"showRegionInfo"];
        [regionSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:regionSwitch];
        
        // 添加上传时间显示开关
        HBPreferenceSpecifier *uploadTimeSwitch = [HBPreferenceSpecifier preferenceSpecifierNamed:@"Show Upload Time"
                                                                                             target:self
                                                                                                set:@selector(setPreferenceValue:forSpecifier:)
                                                                                                get:@selector(readPreferenceValue:)
                                                                                             detail:Nil
                                                                                               cell:PSSwitchCell
                                                                                               edit:Nil];
        [uploadTimeSwitch setIdentifier:@"showUploadTime"];
        [uploadTimeSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:uploadTimeSwitch];
        
        // 添加复制功能组
        HBPreferenceSpecifier *copyGroup = [HBPreferenceSpecifier groupSpecifierWithName:@"Copy Features"];
        [specifiers addObject:copyGroup];
        
        // 添加复制视频描述开关
        HBPreferenceSpecifier *copyDescSwitch = [HBPreferenceSpecifier preferenceSpecifierNamed:@"Copy Video Description"
                                                                                          target:self
                                                                                             set:@selector(setPreferenceValue:forSpecifier:)
                                                                                             get:@selector(readPreferenceValue:)
                                                                                          detail:Nil
                                                                                            cell:PSSwitchCell
                                                                                            edit:Nil];
        [copyDescSwitch setIdentifier:@"copyVideoDecription"];
        [copyDescSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:copyDescSwitch];
        
        // 添加复制视频链接开关
        HBPreferenceSpecifier *copyLinkSwitch = [HBPreferenceSpecifier preferenceSpecifierNamed:@"Copy Video Link"
                                                                                          target:self
                                                                                             set:@selector(setPreferenceValue:forSpecifier:)
                                                                                             get:@selector(readPreferenceValue:)
                                                                                          detail:Nil
                                                                                            cell:PSSwitchCell
                                                                                            edit:Nil];
        [copyLinkSwitch setIdentifier:@"copyVideoLink"];
        [copyLinkSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:copyLinkSwitch];
        
        // 添加复制音乐链接开关
        HBPreferenceSpecifier *copyMusicSwitch = [HBPreferenceSpecifier preferenceSpecifierNamed:@"Copy Music Link"
                                                                                           target:self
                                                                                              set:@selector(setPreferenceValue:forSpecifier:)
                                                                                              get:@selector(readPreferenceValue:)
                                                                                           detail:Nil
                                                                                             cell:PSSwitchCell
                                                                                             edit:Nil];
        [copyMusicSwitch setIdentifier:@"copyMusicLink"];
        [copyMusicSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:copyMusicSwitch];
        
        // 添加关于组
        HBPreferenceSpecifier *aboutGroup = [HBPreferenceSpecifier groupSpecifierWithName:@"About"];
        [specifiers addObject:aboutGroup];
        
        // 添加关于按钮
        HBPreferenceSpecifier *aboutButton = [HBPreferenceSpecifier preferenceSpecifierNamed:@"About"
                                                                                       target:self
                                                                                          set:NULL
                                                                                          get:NULL
                                                                                       detail:Nil
                                                                                         cell:PSButtonCell
                                                                                         edit:Nil];
        [aboutButton setIdentifier:@"about"];
        [aboutButton setButtonAction:@selector(showAbout)];
        [specifiers addObject:aboutButton];
        
        _specifiers = specifiers;
    }
    
    return _specifiers;
}

- (id)readPreferenceValue:(HBPreferenceSpecifier *)specifier {
    NSString *key = [specifier identifier];
    id defaultValue = [specifier properties][@"default"];
    
    // 从NSUserDefaults获取设置值，与BHIManager保持一致
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([key isEqualToString:@"enableDownload"]) {
        return @([defaults boolForKey:@"dw_videos"]);
    } else if ([key isEqualToString:@"showRegionInfo"]) {
        return @([defaults boolForKey:@"show_region_info"]);
    } else if ([key isEqualToString:@"showUploadTime"]) {
        return @([defaults boolForKey:@"show_upload_time"]);
    } else if ([key isEqualToString:@"copyVideoDecription"]) {
        return @([defaults boolForKey:@"copy_decription"]);
    } else if ([key isEqualToString:@"copyVideoLink"]) {
        return @([defaults boolForKey:@"copy_video_link"]);
    } else if ([key isEqualToString:@"copyMusicLink"]) {
        return @([defaults boolForKey:@"copy_music_link"]);
    } else if ([key isEqualToString:@"version"]) {
        return @"25.9.10";
    } else if ([key isEqualToString:@"author"]) {
        return @"BHTikTok Unified Team";
    }
    
    return defaultValue;
}

- (void)setPreferenceValue:(id)value forSpecifier:(HBPreferenceSpecifier *)specifier {
    NSString *key = [specifier identifier];
    
    // 保存设置值到NSUserDefaults，使用与BHIManager一致的键名
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([key isEqualToString:@"enableDownload"]) {
        [defaults setBool:[value boolValue] forKey:@"dw_videos"];
    } else if ([key isEqualToString:@"showRegionInfo"]) {
        [defaults setBool:[value boolValue] forKey:@"show_region_info"];
    } else if ([key isEqualToString:@"showUploadTime"]) {
        [defaults setBool:[value boolValue] forKey:@"show_upload_time"];
    } else if ([key isEqualToString:@"copyVideoDecription"]) {
        [defaults setBool:[value boolValue] forKey:@"copy_decription"];
    } else if ([key isEqualToString:@"copyVideoLink"]) {
        [defaults setBool:[value boolValue] forKey:@"copy_video_link"];
    } else if ([key isEqualToString:@"copyMusicLink"]) {
        [defaults setBool:[value boolValue] forKey:@"copy_music_link"];
    } else {
        // 对于其他键，直接使用原键名
        [defaults setObject:value forKey:key];
    }
    
    [defaults synchronize];
}

- (void)showAbout {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"About BHTikTok Unified"
                                                                   message:@"Powerful TikTok enhancement plugin with unified features and multi-language support.\n\nBased on BHTiktok by @hahios-2506 and BHTikTok-Plus by @dayanch96"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
