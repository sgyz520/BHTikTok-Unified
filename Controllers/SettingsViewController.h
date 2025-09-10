#import <UIKit/UIKit.h>
#import "../Core/BHIManager.h"

@interface SettingsViewController : UITableViewController

// 界面元素
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSDictionary *settingsData;

// 初始化方法
- (instancetype)init;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;

// 界面配置
- (void)setupNavigationBar;
- (void)setupTableView;
- (void)loadSettingsData;
- (void)refreshInterface;

// 用户交互
- (void)doneButtonTapped;
- (void)resetButtonTapped;
- (void)aboutButtonTapped;

// 表格视图数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

// 表格视图代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

// 设置项处理
- (void)handleSwitchValueChanged:(UISwitch *)sender forKey:(NSString *)key;
- (void)handleSliderValueChanged:(UISlider *)sender forKey:(NSString *)key;
- (void)handleSegmentedControlValueChanged:(UISegmentedControl *)sender forKey:(NSString *)key;

// 特殊功能
- (void)showLanguageSelector;
- (void)showRegionSelector;
- (void)showColorPicker;
- (void)showAboutPage;
- (void)showDonationPage;

@end
