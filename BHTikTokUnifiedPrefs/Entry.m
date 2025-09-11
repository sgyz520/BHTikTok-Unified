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
        PSSpecifier *titleGroup = [PSSpecifier preferenceSpecifierNamed:@"BHTikTok Unified" 
                                                               target:self 
                                                                  set:nil 
                                                                  get:nil 
                                                               detail:nil 
                                                                  cell:PSGroupCell 
                                                                  edit:nil];
        [specifiers addObject:titleGroup];
        
        // 添加版本信息
        PSSpecifier *versionSpec = [PSSpecifier preferenceSpecifierNamed:@"Version" 
                                                               target:self 
                                                                  set:nil 
                                                                  get:nil 
                                                               detail:nil 
                                                                  cell:PSStaticTextCell 
                                                                  edit:nil];
        [versionSpec setProperty:@"25.9.10" forKey:@"default"];
        [versionSpec setProperty:@"version" forKey:@"key"];
        [specifiers addObject:versionSpec];
        
        // 添加作者信息
        PSSpecifier *authorSpec = [PSSpecifier preferenceSpecifierNamed:@"Author" 
                                                               target:self 
                                                                  set:nil 
                                                                  get:nil 
                                                               detail:nil 
                                                                  cell:PSStaticTextCell 
                                                                  edit:nil];
        [authorSpec setProperty:@"BHTikTok Unified Team" forKey:@"default"];
        [authorSpec setProperty:@"author" forKey:@"key"];
        [specifiers addObject:authorSpec];
        
        // 添加功能设置组
        PSSpecifier *settingsGroup = [PSSpecifier preferenceSpecifierNamed:@"功能设置" 
                                                                  target:self 
                                                                     set:nil 
                                                                     get:nil 
                                                                  detail:nil 
                                                                     cell:PSGroupCell 
                                                                     edit:nil];
        [specifiers addObject:settingsGroup];
        
        // 添加下载功能开关
        PSSpecifier *downloadSwitch = [PSSpecifier preferenceSpecifierNamed:@"启用下载功能" 
                                                                   target:self 
                                                                      set:@selector(setPreferenceValue:specifier:) 
                                                                      get:@selector(readPreferenceValue:) 
                                                                   detail:nil 
                                                                      cell:PSSwitchCell 
                                                                      edit:nil];
        [downloadSwitch setProperty:@"enableDownload" forKey:@"key"];
        [downloadSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:downloadSwitch];
        
        // 添加地区信息显示开关
        PSSpecifier *regionSwitch = [PSSpecifier preferenceSpecifierNamed:@"显示地区信息" 
                                                                 target:self 
                                                                    set:@selector(setPreferenceValue:specifier:) 
                                                                    get:@selector(readPreferenceValue:) 
                                                                 detail:nil 
                                                                    cell:PSSwitchCell 
                                                                    edit:nil];
        [regionSwitch setProperty:@"showRegionInfo" forKey:@"key"];
        [regionSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:regionSwitch];
        
        // 添加上传时间显示开关
        PSSpecifier *uploadTimeSwitch = [PSSpecifier preferenceSpecifierNamed:@"显示上传时间" 
                                                                     target:self 
                                                                        set:@selector(setPreferenceValue:specifier:) 
                                                                        get:@selector(readPreferenceValue:) 
                                                                     detail:nil 
                                                                        cell:PSSwitchCell 
                                                                        edit:nil];
        [uploadTimeSwitch setProperty:@"showUploadTime" forKey:@"key"];
        [uploadTimeSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:uploadTimeSwitch];
        
        // 添加复制功能组
        PSSpecifier *copyGroup = [PSSpecifier preferenceSpecifierNamed:@"复制功能" 
                                                               target:self 
                                                                  set:nil 
                                                                  get:nil 
                                                               detail:nil 
                                                                  cell:PSGroupCell 
                                                                  edit:nil];
        [specifiers addObject:copyGroup];
        
        // 添加复制视频描述开关
        PSSpecifier *copyDescSwitch = [PSSpecifier preferenceSpecifierNamed:@"复制视频描述" 
                                                                   target:self 
                                                                      set:@selector(setPreferenceValue:specifier:) 
                                                                      get:@selector(readPreferenceValue:) 
                                                                   detail:nil 
                                                                      cell:PSSwitchCell 
                                                                      edit:nil];
        [copyDescSwitch setProperty:@"copyVideoDecription" forKey:@"key"];
        [copyDescSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:copyDescSwitch];
        
        // 添加复制视频链接开关
        PSSpecifier *copyLinkSwitch = [PSSpecifier preferenceSpecifierNamed:@"复制视频链接" 
                                                                   target:self 
                                                                      set:@selector(setPreferenceValue:specifier:) 
                                                                      get:@selector(readPreferenceValue:) 
                                                                   detail:nil 
                                                                      cell:PSSwitchCell 
                                                                      edit:nil];
        [copyLinkSwitch setProperty:@"copyVideoLink" forKey:@"key"];
        [copyLinkSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:copyLinkSwitch];
        
        // 添加复制音乐链接开关
        PSSpecifier *copyMusicSwitch = [PSSpecifier preferenceSpecifierNamed:@"复制音乐链接" 
                                                                    target:self 
                                                                       set:@selector(setPreferenceValue:specifier:) 
                                                                       get:@selector(readPreferenceValue:) 
                                                                    detail:nil 
                                                                       cell:PSSwitchCell 
                                                                       edit:nil];
        [copyMusicSwitch setProperty:@"copyMusicLink" forKey:@"key"];
        [copyMusicSwitch setProperty:@YES forKey:@"default"];
        [specifiers addObject:copyMusicSwitch];
        
        // 添加关于组
        PSSpecifier *aboutGroup = [PSSpecifier preferenceSpecifierNamed:@"关于" 
                                                               target:self 
                                                                  set:nil 
                                                                  get:nil 
                                                               detail:nil 
                                                                  cell:PSGroupCell 
                                                                  edit:nil];
        [specifiers addObject:aboutGroup];
        
        // 添加关于按钮
        PSSpecifier *aboutButton = [PSSpecifier preferenceSpecifierNamed:@"关于" 
                                                                target:self 
                                                                   set:nil 
                                                                   get:nil 
                                                                detail:nil 
                                                                   cell:PSButtonCell 
                                                                   edit:nil];
        [aboutButton setProperty:@"about" forKey:@"key"];
        [aboutButton setButtonAction:@selector(showAbout)];
        [specifiers addObject:aboutButton];
        
        _specifiers = specifiers;
    }
    
    return _specifiers;
}

- (id)readPreferenceValue:(PSSpecifier*)specifier {
    NSString *key = [specifier propertyForKey:@"key"];
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
    NSString *key = [specifier propertyForKey:@"key"];
    
    // 保存设置值到NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
    
    // 注意：BHIManager类中没有对应的setter方法，所以这里只保存到NSUserDefaults
    // 实际的功能实现应该在BHIManager内部读取这些NSUserDefaults值
}

- (void)showAbout {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"关于 BHTikTok Unified"
                                                                   message:@"功能强大的 TikTok 增强插件，整合版本结合完整功能实现与多语言支持。\n\n基于 @hahios-2506 的 BHTiktok 和 @dayanch96 的 BHTikTok-Plus 项目"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
