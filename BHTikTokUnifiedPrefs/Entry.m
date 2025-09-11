#import <CepheiPrefs/CepheiPrefs.h>
#import <Cephei/HBPreferences.h>
#import <Cephei/HBPreferences.h>
#import <CepheiPrefs/HBRootListController.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "../Core/BHIManager.h"

@interface BHTikTokUnifiedPrefsListController : HBRootListController
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
        [downloadSwitch setProperty:@"dw_videos" forKey:@"key"];
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
        [regionSwitch setProperty:@"show_region_info" forKey:@"key"];
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
        [uploadTimeSwitch setProperty:@"show_upload_time" forKey:@"key"];
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
        [copyDescSwitch setProperty:@"copy_decription" forKey:@"key"];
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
        [copyLinkSwitch setProperty:@"copy_video_link" forKey:@"key"];
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
        [copyMusicSwitch setProperty:@"copy_music_link" forKey:@"key"];
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
    
    // 从BHIManager获取设置值
    if ([key isEqualToString:@"dw_videos"]) {
        return @([BHIManager downloadVideos]);
    } else if ([key isEqualToString:@"show_region_info"]) {
        return @([BHIManager showRegionInfo]);
    } else if ([key isEqualToString:@"show_upload_time"]) {
        return @([BHIManager showUploadTime]);
    } else if ([key isEqualToString:@"copy_decription"]) {
        return @([BHIManager copyVideoDescription]);
    } else if ([key isEqualToString:@"copy_video_link"]) {
        return @([BHIManager copyVideoLink]);
    } else if ([key isEqualToString:@"copy_music_link"]) {
        return @([BHIManager copyMusicLink]);
    } else if ([key isEqualToString:@"version"]) {
        return @"25.9.10";
    } else if ([key isEqualToString:@"author"]) {
        return @"BHTikTok Unified Team";
    }
    
    return @NO;
}

- (void)setPreferenceValue:(id)value forSpecifier:(PSSpecifier*)specifier {
    NSString *key = [specifier propertyForKey:@"key"];
    
    // 保存设置值到NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

- (void)showAbout {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"关于 BHTikTok Unified" 
                                                                   message:@"BHTikTok Unified 是一个功能强大的TikTok增强工具，提供下载、去广告、地区信息显示等功能。\n\n版本：25.9.10\n作者：BHTikTok Unified Team" 
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end