#import "SettingsViewController.h"
#import "../Headers/TikTokHeaders.h"

@implementation SettingsViewController

@dynamic tableView;

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleInsetGrouped];
    if (self) {
        [self loadSettingsData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshInterface];
}

#pragma mark - 界面配置

- (void)setupNavigationBar {
    self.title = BHLocalizedString(@"Settings");
    
    // 完成按钮
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] 
        initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
        target:self 
        action:@selector(doneButtonTapped)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    // 关于按钮
    UIBarButtonItem *aboutButton = [[UIBarButtonItem alloc] 
        initWithImage:[UIImage systemImageNamed:@"info.circle"] 
        style:UIBarButtonItemStylePlain 
        target:self 
        action:@selector(aboutButtonTapped)];
    self.navigationItem.leftBarButtonItem = aboutButton;
    
    // 导航栏样式
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = BHSystemBackgroundColor;
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    }
}

- (void)setupTableView {
    self.tableView.backgroundColor = BHSystemBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor separatorColor];
    
    // 注册自定义单元格
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BasicCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SwitchCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DetailCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ButtonCell"];
}

- (void)loadSettingsData {
    self.settingsData = @{
        @"sections": @[
            @{
                @"title": BHLocalizedString(@"DownloadOptions"),
                @"items": @[
                    @{@"title": BHLocalizedString(@"DownloadVideos"), @"key": @"dw_videos", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"DownloadMusics"), @"key": @"dw_musics", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"DownloadHDVideos"), @"key": @"dw_hd_videos", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"DownloadWithoutWatermark"), @"key": @"dw_without_watermark", @"type": @"switch"}
                ]
            },
            @{
                @"title": BHLocalizedString(@"FeedOptions"),
                @"items": @[
                    @{@"title": BHLocalizedString(@"HideAds"), @"key": @"hide_ads", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"ShowProgressBar"), @"key": @"show_porgress_bar", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"AutoPlayNextVideo"), @"key": @"auto_play", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"HideUIElements"), @"key": @"remove_elements_button", @"type": @"switch"}
                ]
            },
            @{
                @"title": BHLocalizedString(@"ProfileOptions"),
                @"items": @[
                    @{@"title": BHLocalizedString(@"SaveProfileImage"), @"key": @"save_profile", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"CopyProfileInfo"), @"key": @"copy_profile_information", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"ExtendedBio"), @"key": @"extended_bio", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"ExtendedComment"), @"key": @"extendedComment", @"type": @"switch"}
                ]
            },
            @{
                @"title": BHLocalizedString(@"ConfirmationOptions"),
                @"items": @[
                    @{@"title": BHLocalizedString(@"LikeConfirmation"), @"key": @"like_confirm", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"CommentLikeConfirmation"), @"key": @"like_comment_confirm", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"FollowConfirmation"), @"key": @"follow_confirm", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"ShareConfirmation"), @"key": @"share_confirm", @"type": @"switch"}
                ]
            },
            @{
                @"title": BHLocalizedString(@"RegionOptions"),
                @"items": @[
                    @{@"title": BHLocalizedString(@"ChangeRegion"), @"key": @"en_region", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"SelectRegion"), @"type": @"detail", @"action": @"showRegionSelector"},
                    @{@"title": BHLocalizedString(@"ShowRegionInfo"), @"key": @"show_region_info", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"ShowUploadTime"), @"key": @"show_upload_time", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"AlwaysOpenInSafari"), @"key": @"openInBrowser", @"type": @"switch"}
                ]
            },
            @{
                @"title": BHLocalizedString(@"FakeOptions"),
                @"items": @[
                    @{@"title": BHLocalizedString(@"EnableFakeFeatures"), @"key": @"en_fake", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"FakeVerified"), @"key": @"fake_verify", @"type": @"switch"}
                ]
            },
            @{
                @"title": BHLocalizedString(@"ColorOptions"),
                @"items": @[
                    @{@"title": BHLocalizedString(@"AccentColor"), @"type": @"detail", @"action": @"showColorPicker"},
                    @{@"title": BHLocalizedString(@"DarkMode"), @"key": @"force_dark_mode", @"type": @"switch"}
                ]
            },
            @{
                @"title": BHLocalizedString(@"OtherOptions"),
                @"items": @[
                    @{@"title": BHLocalizedString(@"AppLock"), @"key": @"padlock", @"type": @"switch"},
                    @{@"title": BHLocalizedString(@"Language"), @"type": @"detail", @"action": @"showLanguageSelector"},
                    @{@"title": BHLocalizedString(@"CleanCache"), @"type": @"button", @"action": @"cleanCache"},
                    @{@"title": BHLocalizedString(@"ResetSettings"), @"type": @"button", @"action": @"resetSettings", @"destructive": @YES}
                ]
            },
            @{
                @"title": BHLocalizedString(@"Developer"),
                @"items": @[
                    @{@"title": BHLocalizedString(@"Donate"), @"type": @"button", @"action": @"showDonationPage"},
                    @{@"title": BHLocalizedString(@"Telegram"), @"type": @"button", @"action": @"openTelegram"},
                    @{@"title": BHLocalizedString(@"About"), @"type": @"detail", @"action": @"showAboutPage"}
                ]
            }
        ]
    };
}

- (void)refreshInterface {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - 用户交互

- (void)doneButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)resetButtonTapped {
    UIAlertController *alert = [UIAlertController 
        alertControllerWithTitle:BHLocalizedString(@"ResetSettings")
        message:BHLocalizedString(@"Reset Confirmation")
        preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction 
        actionWithTitle:BHLocalizedString(@"Cancel")
        style:UIAlertActionStyleCancel 
        handler:nil]];
    
    [alert addAction:[UIAlertAction 
        actionWithTitle:BHLocalizedString(@"Reset")
        style:UIAlertActionStyleDestructive 
        handler:^(UIAlertAction *action) {
            [BHIManager resetAllSettings];
            [self refreshInterface];
            
            UIAlertController *successAlert = [UIAlertController 
                alertControllerWithTitle:BHLocalizedString(@"Success")
                message:BHLocalizedString(@"Settings Reset")
                preferredStyle:UIAlertControllerStyleAlert];
            [successAlert addAction:[UIAlertAction 
                actionWithTitle:BHLocalizedString(@"OK")
                style:UIAlertActionStyleDefault 
                handler:nil]];
            [self presentViewController:successAlert animated:YES completion:nil];
        }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)aboutButtonTapped {
    [self showAboutPage];
}

#pragma mark - 表格视图数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.settingsData[@"sections"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *sectionData = self.settingsData[@"sections"][section];
    return [sectionData[@"items"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *sectionData = self.settingsData[@"sections"][indexPath.section];
    NSDictionary *itemData = sectionData[@"items"][indexPath.row];
    
    NSString *type = itemData[@"type"];
    NSString *title = itemData[@"title"];
    NSString *key = itemData[@"key"];
    
    if ([type isEqualToString:@"switch"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell" forIndexPath:indexPath];
        cell.textLabel.text = title;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UISwitch *switchControl = [[UISwitch alloc] init];
        switchControl.on = [[NSUserDefaults standardUserDefaults] boolForKey:key];
        switchControl.onTintColor = BHAccentColor;
        [switchControl addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        objc_setAssociatedObject(switchControl, @selector(settingsKey), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        cell.accessoryView = switchControl;
        return cell;
        
    } else if ([type isEqualToString:@"detail"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
        cell.textLabel.text = title;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        // 添加详细信息
        if ([itemData[@"action"] isEqualToString:@"showLanguageSelector"]) {
            cell.detailTextLabel.text = [BHIManager currentLanguage];
        } else if ([itemData[@"action"] isEqualToString:@"showRegionSelector"]) {
            NSDictionary *region = [BHIManager selectedRegion];
            cell.detailTextLabel.text = region ? region[@"name"] : BHLocalizedString(@"CurrentRegion");
        }
        
        return cell;
        
    } else if ([type isEqualToString:@"button"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell" forIndexPath:indexPath];
        cell.textLabel.text = title;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        if ([itemData[@"destructive"] boolValue]) {
            cell.textLabel.textColor = [UIColor systemRedColor];
        } else {
            cell.textLabel.textColor = BHAccentColor;
        }
        
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell" forIndexPath:indexPath];
        cell.textLabel.text = title;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *sectionData = self.settingsData[@"sections"][section];
    return sectionData[@"title"];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == [self.settingsData[@"sections"] count] - 1) {
        return [NSString stringWithFormat:@"BHTikTok Unified v%@ (%@)", [BHIManager version], [BHIManager buildNumber]];
    }
    return nil;
}

#pragma mark - 表格视图代理

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *sectionData = self.settingsData[@"sections"][indexPath.section];
    NSDictionary *itemData = sectionData[@"items"][indexPath.row];
    NSString *action = itemData[@"action"];
    
    if (action) {
        SEL selector = NSSelectorFromString(action);
        if ([self respondsToSelector:selector]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector];
            #pragma clang diagnostic pop
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

#pragma mark - 设置项处理

- (void)switchValueChanged:(UISwitch *)sender {
    NSString *key = objc_getAssociatedObject(sender, @selector(settingsKey));
    if (key) {
        [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)handleSwitchValueChanged:(UISwitch *)sender forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self refreshInterface];
}

- (void)handleSliderValueChanged:(UISlider *)sender forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setFloat:sender.value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self refreshInterface];
}

- (void)handleSegmentedControlValueChanged:(UISegmentedControl *)sender forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setInteger:sender.selectedSegmentIndex forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self refreshInterface];
}

#pragma mark - 特殊功能

- (void)showLanguageSelector {
    UIAlertController *alert = [UIAlertController 
        alertControllerWithTitle:BHLocalizedString(@"Language")
        message:nil 
        preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *languages = [BHIManager supportedLanguages];
    NSString *currentLanguage = [BHIManager currentLanguage];
    
    for (NSDictionary *language in languages) {
        NSString *title = [NSString stringWithFormat:@"%@ (%@)", language[@"nativeName"], language[@"name"]];
        UIAlertAction *action = [UIAlertAction 
            actionWithTitle:title
            style:UIAlertActionStyleDefault 
            handler:^(UIAlertAction *action) {
                [BHIManager setPreferredLanguage:language[@"code"]];
                [self refreshInterface];
            }];
        
        if ([language[@"code"] isEqualToString:currentLanguage]) {
            [action setValue:[UIImage systemImageNamed:@"checkmark"] forKey:@"image"];
        }
        
        [alert addAction:action];
    }
    
    [alert addAction:[UIAlertAction 
        actionWithTitle:BHLocalizedString(@"Cancel")
        style:UIAlertActionStyleCancel 
        handler:nil]];
    
    if (is_iPad()) {
        alert.popoverPresentationController.sourceView = self.view;
        alert.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0);
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showRegionSelector {
    UIAlertController *alert = [UIAlertController 
        alertControllerWithTitle:BHLocalizedString(@"SelectRegion")
        message:nil 
        preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *regions = [BHIManager availableRegions];
    NSDictionary *currentRegion = [BHIManager selectedRegion];
    
    for (NSDictionary *region in regions) {
        NSString *title = [NSString stringWithFormat:@"%@ %@", region[@"flag"], region[@"name"]];
        UIAlertAction *action = [UIAlertAction 
            actionWithTitle:title
            style:UIAlertActionStyleDefault 
            handler:^(UIAlertAction *action) {
                [[NSUserDefaults standardUserDefaults] setObject:region forKey:@"region"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self refreshInterface];
            }];
        
        if ([region[@"code"] isEqualToString:currentRegion[@"code"]]) {
            [action setValue:[UIImage systemImageNamed:@"checkmark"] forKey:@"image"];
        }
        
        [alert addAction:action];
    }
    
    [alert addAction:[UIAlertAction 
        actionWithTitle:BHLocalizedString(@"Cancel")
        style:UIAlertActionStyleCancel 
        handler:nil]];
    
    if (is_iPad()) {
        alert.popoverPresentationController.sourceView = self.view;
        alert.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0);
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showColorPicker {
    if (@available(iOS 14.0, *)) {
        UIColorPickerViewController *colorPicker = [[UIColorPickerViewController alloc] init];
        colorPicker.selectedColor = BHAccentColor;
        colorPicker.delegate = (id<UIColorPickerViewControllerDelegate>)self;
        [self presentViewController:colorPicker animated:YES completion:nil];
    }
}

- (void)cleanCache {
    UIAlertController *alert = [UIAlertController 
        alertControllerWithTitle:BHLocalizedString(@"CleanCache")
        message:BHLocalizedString(@"Please Wait")
        preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [BHIManager cleanCache];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:^{
                    UIAlertController *successAlert = [UIAlertController 
                        alertControllerWithTitle:BHLocalizedString(@"Success")
                        message:BHLocalizedString(@"Cache Cleared")
                        preferredStyle:UIAlertControllerStyleAlert];
                    [successAlert addAction:[UIAlertAction 
                        actionWithTitle:BHLocalizedString(@"OK")
                        style:UIAlertActionStyleDefault 
                        handler:nil]];
                    [self presentViewController:successAlert animated:YES completion:nil];
                }];
            });
        });
    }];
}

- (void)resetSettings {
    [self resetButtonTapped];
}

- (void)showAboutPage {
    UIAlertController *alert = [UIAlertController 
        alertControllerWithTitle:@"BHTikTok Unified"
        message:[NSString stringWithFormat:@"%@: %@\n%@: %@\n%@: %@\n%@: %@", 
                BHLocalizedString(@"Version"), [BHIManager version],
                BHLocalizedString(@"Build"), [BHIManager buildNumber],
                BHLocalizedString(@"iOS Version"), [[UIDevice currentDevice] systemVersion],
                BHLocalizedString(@"Device"), [[UIDevice currentDevice] model]]
        preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction 
        actionWithTitle:BHLocalizedString(@"OK")
        style:UIAlertActionStyleDefault 
        handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showDonationPage {
    UIAlertController *alert = [UIAlertController 
        alertControllerWithTitle:BHLocalizedString(@"Donate")
        message:BHLocalizedString(@"DonateMessage")
        preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction 
        actionWithTitle:BHLocalizedString(@"DonateViaPayPal")
        style:UIAlertActionStyleDefault 
        handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/bhtiktok"] options:@{} completionHandler:nil];
        }]];
    
    [alert addAction:[UIAlertAction 
        actionWithTitle:BHLocalizedString(@"MaybeLater")
        style:UIAlertActionStyleCancel 
        handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)openTelegram {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://t.me/BHTikTokUnified"] options:@{} completionHandler:nil];
}

@end

// 添加关联对象的方法
@implementation NSObject (SettingsKey)
- (void)setSettingsKey:(NSString *)key {
    objc_setAssociatedObject(self, @selector(settingsKey), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)settingsKey {
    return objc_getAssociatedObject(self, @selector(settingsKey));
}
@end
