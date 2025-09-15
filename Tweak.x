/*
 * BHTikTok Unified - A comprehensive TikTok enhancement tweak
 * 
 * This project integrates and enhances code from:
 * - BHTiktok by @hahios-2506: https://github.com/hahios-2506/BHTiktok
 * - BHTikTok-Plus by @dayanch96: https://github.com/dayanch96/BHTikTok-Plus
 * 
 * Special thanks to the original developers for their excellent work!
 */

#import "Headers/TikTokHeaders.h"
#import "Core/BHIManager.h"
#import "Controllers/SettingsViewController.h"
#import "Controllers/SecurityViewController.h"
#import "Views/BHRegionInfoView.h"

NSArray *jailbreakPaths;

static void showConfirmation(void (^okHandler)(void)) {
    [%c(AWEUIAlertView) showAlertWithTitle:@"BHTikTok Unified" 
                              description:NSLocalizedStringFromTable(@"ConfirmationMessage", @"BHTikTokUnified", @"Are you sure?")
                                    image:nil 
                        actionButtonTitle:NSLocalizedStringFromTable(@"Yes", @"BHTikTokUnified", @"Yes")
                        cancelButtonTitle:NSLocalizedStringFromTable(@"No", @"BHTikTokUnified", @"No")
                              actionBlock:^{
        okHandler();
    } cancelBlock:nil];
}

%hook AppDelegate
- (_Bool)application:(UIApplication *)application didFinishLaunchingWithOptions:(id)arg2 {
    %orig;
    
    // 首次运行初始化
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"BHTikTokUnifiedFirstRun"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"BHTikTokUnifiedFirstRun" forKey:@"BHTikTokUnifiedFirstRun"];
        
        // 默认启用的功能
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"hide_ads"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"dw_videos"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"dw_musics"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"remove_elements_button"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"copy_description"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"copy_video_link"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"copy_music_link"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"show_progress_bar"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"save_profile"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"copy_profile_information"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"extended_bio"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"extendedComment"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"show_region_info"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"show_upload_time"];
        
        // 设置默认语言
        NSString *preferredLanguage = [[NSLocale preferredLanguages] firstObject];
        [[NSUserDefaults standardUserDefaults] setObject:preferredLanguage forKey:@"BHTikTokUnified_Language"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [BHIManager cleanCache];
    return true;
}

static BOOL isAuthenticationShowed = FALSE;
- (void)applicationDidBecomeActive:(id)arg1 {
    %orig;
    
    if ([BHIManager appLock] && !isAuthenticationShowed) {
        UIViewController *rootController = [[self window] rootViewController];
        SecurityViewController *securityViewController = [SecurityViewController new];
        securityViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [rootController presentViewController:securityViewController animated:YES completion:nil];
        isAuthenticationShowed = TRUE;
    }
}

- (void)applicationWillEnterForeground:(id)arg1 {
    %orig;
    isAuthenticationShowed = FALSE;
}
%end

%hook TTKSettingsBaseCellPlugin
- (void)didSelectItemAtIndex:(NSInteger)index {
    // 安全获取identifier
    NSString *identifier = nil;
    
    @try {
        if (self.itemModel && [self.itemModel respondsToSelector:@selector(identifier)]) {
            identifier = [self.itemModel identifier];
        }
    } @catch (NSException *exception) {
        NSLog(@"[BHTikTok Unified] 获取identifier时发生异常: %@", exception.reason);
        return %orig;
    }
    
    if (identifier && [identifier isEqualToString:@"bhtiktok_unified_settings"]) {
        @try {
            UINavigationController *BHTikTokSettings = [[UINavigationController alloc] 
                initWithRootViewController:[[SettingsViewController alloc] init]];
            UIViewController *topController = topMostController();
            if (topController) {
                [topController presentViewController:BHTikTokSettings animated:true completion:nil];
            }
        } @catch (NSException *exception) {
            NSLog(@"[BHTikTok Unified] 显示设置界面时发生异常: %@", exception.reason);
        }
    } else {
        return %orig;
    }
}
%end

%hook AWESettingsNormalSectionViewModel
- (void)viewDidLoad {
    %orig;
    
    // 添加调试日志
    NSLog(@"[BHTikTok Unified] AWESettingsNormalSectionViewModel viewDidLoad called");
    NSLog(@"[BHTikTok Unified] Section identifier: %@", self.sectionIdentifier);
    
    // 尝试多个可能的section identifier
    if ([self.sectionIdentifier isEqualToString:@"account"] || 
        [self.sectionIdentifier isEqualToString:@"Account"] ||
        [self.sectionIdentifier isEqualToString:@"settings"] ||
        [self.sectionIdentifier isEqualToString:@"Settings"] ||
        [self.sectionIdentifier isEqualToString:@"general"] ||
        [self.sectionIdentifier isEqualToString:@"General"]) {
        
        NSLog(@"[BHTikTok Unified] 匹配到section: %@，准备添加设置项", self.sectionIdentifier);
        
        @try {
            // 检查必要的类是否存在
            Class TTKSettingsBaseCellPluginClass = %c(TTKSettingsBaseCellPlugin);
            Class AWESettingItemModelClass = %c(AWESettingItemModel);
            
            if (!TTKSettingsBaseCellPluginClass) {
                NSLog(@"[BHTikTok Unified] 警告: TTKSettingsBaseCellPlugin 类不存在");
                return;
            }
            
            if (!AWESettingItemModelClass) {
                NSLog(@"[BHTikTok Unified] 警告: AWESettingItemModel 类不存在");
                return;
            }
            
            TTKSettingsBaseCellPlugin *BHTikTokSettingsPluginCell = [[TTKSettingsBaseCellPluginClass alloc] 
                initWithPluginContext:self.context];

            AWESettingItemModel *BHTikTokSettingsItemModel = [[AWESettingItemModelClass alloc] 
                initWithIdentifier:@"bhtiktok_unified_settings"];
            
            // 设置标题和描述
            [BHTikTokSettingsItemModel setTitle:@"BHTikTok Unified 设置"];
            [BHTikTokSettingsItemModel setDetail:@"配置 BHTikTok Unified 功能"];
            
            // 尝试设置图标
            @try {
                UIImage *icon = [UIImage systemImageNamed:@"gear.circle.fill"];
                if (icon) {
                    [BHTikTokSettingsItemModel setIconImage:icon];
                } else {
                    NSLog(@"[BHTikTok Unified] 无法加载系统图标，使用默认");
                }
            } @catch (NSException *iconException) {
                NSLog(@"[BHTikTok Unified] 设置图标异常: %@", iconException.reason);
            }
            
            [BHTikTokSettingsItemModel setType:99];

            [BHTikTokSettingsPluginCell setItemModel:BHTikTokSettingsItemModel];
            
            // 尝试插入设置项
            if ([self respondsToSelector:@selector(insertModel:atIndex:animated:)]) {
                [self insertModel:BHTikTokSettingsPluginCell atIndex:0 animated:true];
                NSLog(@"[BHTikTok Unified] 设置项已成功添加到索引0");
            } else {
                NSLog(@"[BHTikTok Unified] 警告: insertModel:atIndex:animated: 方法不存在");
            }
            
        } @catch (NSException *exception) {
            NSLog(@"[BHTikTok Unified] 添加设置项时发生异常: %@", exception.reason);
            NSLog(@"[BHTikTok Unified] 异常堆栈: %@", exception.callStackSymbols);
        }
    } else {
        NSLog(@"[BHTikTok Unified] 未匹配section identifier: %@", self.sectionIdentifier);
    }
}
%end

// Safari 浏览器重定向
%hook SparkViewController
- (void)viewWillAppear:(BOOL)animated {
    if (![BHIManager alwaysOpenSafari]) {
        return %orig;
    }
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:self.originURL resolvingAgainstBaseURL:NO];
    NSString *searchParameter = @"url";
    NSString *searchValue = nil;
    
    for (NSURLQueryItem *queryItem in components.queryItems) {
        if ([queryItem.name isEqualToString:searchParameter]) {
            searchValue = queryItem.value;
            break;
        }
    }

    if (searchValue) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:searchValue] 
                                           options:@{} 
                                 completionHandler:nil];
        [self didTapCloseButton];
    } else {
        return %orig;
    }
}
%end

// 地区更改功能
%hook CTCarrier
- (NSString *)isoCountryCode {
    if ([BHIManager regionChangingEnabled]) {
        NSDictionary *selectedRegion = [BHIManager selectedRegion];
        if (selectedRegion && selectedRegion[@"code"]) {
            return selectedRegion[@"code"];
        }
    }
    return %orig;
}

- (NSString *)carrierName {
    if ([BHIManager regionChangingEnabled]) {
        NSDictionary *selectedRegion = [BHIManager selectedRegion];
        if (selectedRegion && selectedRegion[@"name"]) {
            return selectedRegion[@"name"];
        }
    }
    return %orig;
}
%end

// 广告移除
%hook AWEFeedContainerViewController
- (void)setAweme:(id)aweme {
    if ([BHIManager hideAds]) {
        if ([aweme isAds] || [aweme isAdvertisement]) {
            return;
        }
    }
    %orig;
}
%end

// 下载功能增强 + 地区信息显示
%hook AWEAwemeDetailTableViewCell
- (void)configureWithModel:(id)model {
    %orig;
    
    // 下载功能增强
    if ([BHIManager downloadVideos] || [BHIManager downloadMusics]) {
        // 添加下载按钮
        UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [downloadButton setTitle:NSLocalizedStringFromTable(@"Download", @"BHTikTokUnified", @"Download") 
                        forState:UIControlStateNormal];
        [downloadButton addTarget:self 
                           action:@selector(bh_downloadButtonTapped:) 
                 forControlEvents:UIControlEventTouchUpInside];
        
        // 设置按钮样式
        downloadButton.backgroundColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:0.8];
        downloadButton.layer.cornerRadius = 8.0;
        downloadButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [downloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        // 添加到视图
        [self.contentView addSubview:downloadButton];
        downloadButton.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [downloadButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
            [downloadButton.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-16],
            [downloadButton.widthAnchor constraintEqualToConstant:80],
            [downloadButton.heightAnchor constraintEqualToConstant:32]
        ]];
    }
    
    // 地区信息显示
    if ([BHIManager showRegionInfo] || [BHIManager showUploadTime]) {
        // 检查是否已经添加了地区信息视图
        BHRegionInfoView *regionInfoView = objc_getAssociatedObject(self, @selector(bh_regionInfoView));
        
        if (!regionInfoView) {
            regionInfoView = [[BHRegionInfoView alloc] initWithFrame:CGRectZero];
            regionInfoView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.contentView addSubview:regionInfoView];
            
            // 设置约束，将地区信息视图放在描述信息下方，进度条上方
            [NSLayoutConstraint activateConstraints:@[
                [regionInfoView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:12],
                [regionInfoView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-12],
                [regionInfoView.topAnchor constraintEqualToAnchor:self.descriptionLabel.bottomAnchor constant:8]
            ]];
            
            // 保存关联对象
            objc_setAssociatedObject(self, @selector(bh_regionInfoView), regionInfoView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        // 配置地区信息视图
        [regionInfoView configureWithModel:model];
    }
}

%new
- (void)bh_downloadButtonTapped:(UIButton *)sender {
    // 下载功能实现
    if ([BHIManager downloadVideos]) {
        // 检查BHDownload类是否可用
        Class BHDownloadClass = NSClassFromString(@"BHDownload");
        if (BHDownloadClass) {
            [BHDownloadClass performSelector:@selector(downloadVideoWithModel:) withObject:self.model];
        } else {
            NSLog(@"[BHTikTok Unified] BHDownload class not found");
        }
    }
}

%new
- (BHRegionInfoView *)bh_regionInfoView {
    return objc_getAssociatedObject(self, @selector(bh_regionInfoView));
}

// 长按复制功能
- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        UIAlertController *alert = [UIAlertController 
            alertControllerWithTitle:NSLocalizedStringFromTable(@"CopyOptions", @"BHTikTokUnified", @"Copy Options")
                             message:nil 
                      preferredStyle:UIAlertControllerStyleActionSheet];
        
        if ([BHIManager copyVideoDescription]) {
            [alert addAction:[UIAlertAction 
                actionWithTitle:NSLocalizedStringFromTable(@"CopyDescription", @"BHTikTokUnified", @"Copy Description")
                          style:UIAlertActionStyleDefault 
                        handler:^(UIAlertAction *action) {
                [[UIPasteboard generalPasteboard] setString:self.model.desc ?: @""];
            }]];
        }
        
        if ([BHIManager copyVideoLink]) {
            [alert addAction:[UIAlertAction 
                actionWithTitle:NSLocalizedStringFromTable(@"CopyVideoLink", @"BHTikTokUnified", @"Copy Video Link")
                          style:UIAlertActionStyleDefault 
                        handler:^(UIAlertAction *action) {
                // 安全获取uniqueId和awemeId
                NSString *uniqueId = @"";
                NSString *awemeId = @"";
                
                @try {
                    // 获取uniqueId
                    if (self.model.author && [self.model.author respondsToSelector:@selector(uniqueId)]) {
                        uniqueId = [self.model.author uniqueId] ?: @"";
                    }
                    
                    // 获取awemeId
                    if (self.model && [self.model respondsToSelector:@selector(awemeId)]) {
                        awemeId = [self.model awemeId] ?: @"";
                    }
                } @catch (NSException *exception) {
                    NSLog(@"[BHTikTok Unified] 获取视频信息时发生异常: %@", exception.reason);
                }
                
                NSString *videoURL = [NSString stringWithFormat:@"https://www.tiktok.com/@%@/video/%@", 
                                    uniqueId, awemeId];
                [[UIPasteboard generalPasteboard] setString:videoURL];
            }]];
        }
        
        if ([BHIManager copyMusicLink]) {
            [alert addAction:[UIAlertAction 
                actionWithTitle:NSLocalizedStringFromTable(@"CopyMusicLink", @"BHTikTokUnified", @"Copy Music Link")
                          style:UIAlertActionStyleDefault 
                        handler:^(UIAlertAction *action) {
                // 安全获取音乐URL
                NSString *musicURL = @"";
                
                @try {
                    if (self.model.music && [self.model.music respondsToSelector:@selector(playURL)]) {
                        id playURL = [self.model.music playURL];
                        
                        // 尝试获取originURLString
                        if (playURL && [playURL respondsToSelector:@selector(originURLString)]) {
                            musicURL = [playURL originURLString] ?: @"";
                        }
                    }
                } @catch (NSException *exception) {
                    NSLog(@"[BHTikTok Unified] 获取音乐链接时发生异常: %@", exception.reason);
                }
                
                [[UIPasteboard generalPasteboard] setString:musicURL];
            }]];
        }
        
        [alert addAction:[UIAlertAction 
            actionWithTitle:NSLocalizedStringFromTable(@"Cancel", @"BHTikTokUnified", @"Cancel")
                      style:UIAlertActionStyleCancel 
                    handler:nil]];
        
        if (alert.actions.count > 1) {
            [topMostController() presentViewController:alert animated:YES completion:nil];
        }
        return;
    }
    %orig;
}
%end

// 关注确认
%hook TIKTOKProfileHeaderExtraViewController
- (void)followButtonTapped {
    if ([BHIManager followConfirmation]) {
        showConfirmation(^{
            %orig;
        });
    } else {
        %orig;
    }
}
%end

// 点赞确认
%hook AWEAwemeDetailTableViewCell
- (void)likeButtonTapped {
    if ([BHIManager likeConfirmation]) {
        showConfirmation(^{
            %orig;
        });
    } else {
        %orig;
    }
}
%end

// 个人资料复制功能
%hook TIKTOKProfileHeaderView
- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture {
    if ([BHIManager profileCopy] && gesture.state == UIGestureRecognizerStateBegan) {
        UIAlertController *alert = [UIAlertController 
            alertControllerWithTitle:NSLocalizedStringFromTable(@"ProfileOptions", @"BHTikTokUnified", @"Profile Options")
                             message:nil 
                      preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alert addAction:[UIAlertAction 
            actionWithTitle:NSLocalizedStringFromTable(@"CopyUsername", @"BHTikTokUnified", @"Copy Username")
                      style:UIAlertActionStyleDefault 
                    handler:^(UIAlertAction *action) {
            [[UIPasteboard generalPasteboard] setString:self.model.uniqueId ?: @""];
        }]];
        
        [alert addAction:[UIAlertAction 
            actionWithTitle:NSLocalizedStringFromTable(@"CopyBio", @"BHTikTokUnified", @"Copy Bio")
                      style:UIAlertActionStyleDefault 
                    handler:^(UIAlertAction *action) {
            [[UIPasteboard generalPasteboard] setString:self.model.signature ?: @""];
        }]];
        
        [alert addAction:[UIAlertAction 
            actionWithTitle:NSLocalizedStringFromTable(@"Cancel", @"BHTikTokUnified", @"Cancel")
                      style:UIAlertActionStyleCancel 
                    handler:nil]];
        
        [topMostController() presentViewController:alert animated:YES completion:nil];
        return;
    }
    %orig;
}
%end

// 头像保存功能
%hook AWEProfileImagePreviewView
- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture {
    if ([BHIManager profileSave] && gesture.state == UIGestureRecognizerStateBegan) {
        UIAlertController *alert = [UIAlertController 
            alertControllerWithTitle:NSLocalizedStringFromTable(@"SaveProfileImage", @"BHTikTokUnified", @"Save Profile Image")
                             message:NSLocalizedStringFromTable(@"SaveProfileImageMessage", @"BHTikTokUnified", @"Do you want to save this profile image?")
                      preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction 
            actionWithTitle:NSLocalizedStringFromTable(@"Save", @"BHTikTokUnified", @"Save")
                      style:UIAlertActionStyleDefault 
                    handler:^(UIAlertAction *action) {
            [BHIManager showSaveVC:@[self.imageView.image]];
        }]];
        
        [alert addAction:[UIAlertAction 
            actionWithTitle:NSLocalizedStringFromTable(@"Cancel", @"BHTikTokUnified", @"Cancel")
                      style:UIAlertActionStyleCancel 
                    handler:nil]];
        
        [topMostController() presentViewController:alert animated:YES completion:nil];
        return;
    }
    %orig;
}
%end

// 伪造功能
%hook AWEUserModel
- (BOOL)isVerified {
    if ([BHIManager fakeChangesEnabled] && [BHIManager fakeVerified]) {
        return YES;
    }
    return %orig;
}

- (NSNumber *)followerCount {
    if ([BHIManager fakeChangesEnabled]) {
        NSNumber *fakeCount = [[NSUserDefaults standardUserDefaults] objectForKey:@"fake_follower_count"];
        if (fakeCount) {
            return fakeCount;
        }
    }
    return %orig;
}

- (NSNumber *)followingCount {
    if ([BHIManager fakeChangesEnabled]) {
        NSNumber *fakeCount = [[NSUserDefaults standardUserDefaults] objectForKey:@"fake_following_count"];
        if (fakeCount) {
            return fakeCount;
        }
    }
    return %orig;
}
%end

// 扩展评论显示
%hook AWECommentTableViewCell
- (void)configureWithModel:(id)model {
    %orig;
    
    if ([BHIManager extendedComment]) {
        self.commentLabel.numberOfLines = 0;
        self.commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
}
%end

// 扩展个人简介显示
%hook TIKTOKProfileHeaderView
- (void)configureWithModel:(id)model {
    %orig;
    
    if ([BHIManager extendedBio]) {
        self.bioLabel.numberOfLines = 0;
        self.bioLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
}
%end

// 进度条显示
%hook AWEVideoPlayerView
- (void)setPlayer:(id)player {
    %orig;
    
    if ([BHIManager progressBar]) {
        // 添加进度条
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.progressTintColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.5 alpha:1.0];
        progressView.trackTintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
        
        [self addSubview:progressView];
        progressView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [progressView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [progressView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [progressView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            [progressView.heightAnchor constraintEqualToConstant:2.0]
        ]];
        
        // 设置进度更新
        objc_setAssociatedObject(self, @selector(bh_progressView), progressView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

%new
- (UIProgressView *)bh_progressView {
    return objc_getAssociatedObject(self, @selector(bh_progressView));
}
%end

// 自动播放控制
%hook AWEFeedTableViewController
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![BHIManager autoPlay]) {
        return;
    }
    %orig;
}
%end

// 播放页面地区信息显示
%hook AWEPlayInteractionViewController
- (void)configureWithModel:(id)model {
    %orig;
    
    // 添加地区信息视图
    if ([BHIManager showRegionInfo] || [BHIManager showUploadTime]) {
        // 检查是否已经添加了地区信息视图
        BHRegionInfoView *regionInfoView = objc_getAssociatedObject(self, @selector(bh_regionInfoView));
        
        if (!regionInfoView) {
            regionInfoView = [[BHRegionInfoView alloc] initWithFrame:CGRectZero];
            regionInfoView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.bottomContainerView addSubview:regionInfoView];
            
            // 设置约束，将地区信息视图放在描述信息下方，进度条上方
            [NSLayoutConstraint activateConstraints:@[
                [regionInfoView.leadingAnchor constraintEqualToAnchor:self.bottomContainerView.leadingAnchor constant:12],
                [regionInfoView.trailingAnchor constraintEqualToAnchor:self.bottomContainerView.trailingAnchor constant:-12],
                [regionInfoView.topAnchor constraintEqualToAnchor:self.descriptionLabel.bottomAnchor constant:8]
            ]];
            
            // 保存关联对象
            objc_setAssociatedObject(self, @selector(bh_regionInfoView), regionInfoView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        // 配置地区信息视图
        [regionInfoView configureWithModel:model];
    }
}

%new
- (BHRegionInfoView *)bh_regionInfoView {
    return objc_getAssociatedObject(self, @selector(bh_regionInfoView));
}
%end



// 构造函数
%ctor {
    jailbreakPaths = @[
        @"/Applications/Cydia.app",
        @"/Library/MobileSubstrate/MobileSubstrate.dylib",
        @"/bin/bash",
        @"/usr/sbin/sshd",
        @"/etc/apt",
        @"/private/var/lib/apt/",
        @"/private/var/lib/cydia",
        @"/private/var/mobile/Library/SBSettings/Themes",
        @"/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
        @"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
        @"/private/var/cache/apt",
        @"/private/var/lib/apt",
        @"/private/var/lib/cydia",
        @"/private/var/log/syslog",
        @"/private/var/tmp/cydia.log",
        @"/Applications/Icy.app",
        @"/Applications/MxTube.app",
        @"/Applications/RockApp.app",
        @"/Applications/blackra1n.app",
        @"/Applications/SBSettings.app",
        @"/Applications/FakeCarrier.app",
        @"/Applications/WinterBoard.app",
        @"/Applications/IntelliScreen.app"
    ];
    
    // 初始化本地化支持
    NSString *preferredLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"BHTikTokUnified_Language"];
    if (!preferredLanguage) {
        preferredLanguage = [[NSLocale preferredLanguages] firstObject];
        [[NSUserDefaults standardUserDefaults] setObject:preferredLanguage forKey:@"BHTikTokUnified_Language"];
    }
    
    // 添加详细的初始化日志
    NSLog(@"[BHTikTok Unified] ============================================");
    NSLog(@"[BHTikTok Unified] 插件初始化开始");
    NSLog(@"[BHTikTok Unified] 版本: 25.9.10");
    NSLog(@"[BHTikTok Unified] 语言: %@", preferredLanguage);
    NSLog(@"[BHTikTok Unified] Bundle ID: %@", [[NSBundle mainBundle] bundleIdentifier]);
    NSLog(@"[BHTikTok Unified] 应用名称: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]);
    NSLog(@"[BHTikTok Unified] iOS 版本: %@", [[UIDevice currentDevice] systemVersion]);
    NSLog(@"[BHTikTok Unified] 设备型号: %@", [[UIDevice currentDevice] model]);
    
    // 检查关键类是否存在
    NSLog(@"[BHTikTok Unified] 检查关键类...");
    
    Class AWESettingsNormalSectionViewModelClass = %c(AWESettingsNormalSectionViewModel);
    Class TTKSettingsBaseCellPluginClass = %c(TTKSettingsBaseCellPlugin);
    Class AWESettingItemModelClass = %c(AWESettingItemModel);
    
    NSLog(@"[BHTikTok Unified] AWESettingsNormalSectionViewModel: %@", AWESettingsNormalSectionViewModelClass ? @"存在" : @"不存在");
    NSLog(@"[BHTikTok Unified] TTKSettingsBaseCellPlugin: %@", TTKSettingsBaseCellPluginClass ? @"存在" : @"不存在");
    NSLog(@"[BHTikTok Unified] AWESettingItemModel: %@", AWESettingItemModelClass ? @"存在" : @"不存在");
    
    NSLog(@"[BHTikTok Unified] 插件初始化完成");
    NSLog(@"[BHTikTok Unified] ============================================");
}