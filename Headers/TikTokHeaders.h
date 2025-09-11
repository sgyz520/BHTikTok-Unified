#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// 通用函数声明
static inline UIViewController *topMostController(void);
static inline BOOL is_iPad(void);

// TikTok 应用相关类声明
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@interface AWEUIAlertView : NSObject
+ (void)showAlertWithTitle:(NSString *)title 
               description:(NSString *)description 
                     image:(UIImage *)image 
         actionButtonTitle:(NSString *)actionTitle 
         cancelButtonTitle:(NSString *)cancelTitle 
               actionBlock:(void (^)(void))actionBlock 
               cancelBlock:(void (^)(void))cancelBlock;
@end

@interface TTKSettingsBaseCellPlugin : NSObject
@property (nonatomic, strong) id itemModel;
@property (nonatomic, strong) id context;
- (instancetype)initWithPluginContext:(id)context;
- (void)setItemModel:(id)model;
- (void)didSelectItemAtIndex:(NSInteger)index;
@end

@interface AWESettingItemModel : NSObject
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, assign) NSInteger type;
- (instancetype)initWithIdentifier:(NSString *)identifier;
- (void)setTitle:(NSString *)title;
- (void)setDetail:(NSString *)detail;
- (void)setIconImage:(UIImage *)image;
- (void)setType:(NSInteger)type;
@end

@interface AWESettingsNormalSectionViewModel : NSObject
@property (nonatomic, strong) NSString *sectionIdentifier;
@property (nonatomic, strong) id context;
- (void)viewDidLoad;
- (void)insertModel:(id)model atIndex:(NSInteger)index animated:(BOOL)animated;
@end

@interface SparkViewController : UIViewController
@property (nonatomic, strong) NSURL *originURL;
- (void)viewWillAppear:(BOOL)animated;
- (void)didTapCloseButton;
@end

@interface CTCarrier : NSObject
- (NSString *)isoCountryCode;
- (NSString *)carrierName;
@end

@interface AWEFeedContainerViewController : UIViewController
- (void)setAweme:(id)aweme;
@end

@interface AWEAwemeModel : NSObject
@property (nonatomic, strong) NSString *awemeId;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) id author;
@property (nonatomic, strong) id music;
@property (nonatomic, strong) id video;
@property (nonatomic, strong) NSNumber *createTime;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *regionFullName;
@property (nonatomic, strong) NSDictionary *ipInfo;
- (BOOL)isAds;
- (BOOL)isAdvertisement;
- (NSDate *)uploadDate;
- (NSString *)regionDisplayName;
- (NSString *)ipLocation;
@end

@interface AWEUserModel : NSObject
@property (nonatomic, strong) NSString *uniqueId;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSNumber *followerCount;
@property (nonatomic, strong) NSNumber *followingCount;
- (BOOL)isVerified;
@end

@interface AWEMusicModel : NSObject
@property (nonatomic, strong) id playURL;
@end

@interface AWEURLModel : NSObject
@property (nonatomic, strong) NSString *originURLString;
@end

@interface AWEAwemeDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) AWEAwemeModel *model;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIView *playerContainerView;
- (void)configureWithModel:(id)model;
- (void)likeButtonTapped;
@end

@interface AWEFeedCellViewController : UIViewController
@property (nonatomic, strong) AWEAwemeModel *model;
@property (nonatomic, strong) UIView *descriptionContainerView;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIView *playerView;
- (void)configureWithModel:(id)model;
@end

@interface AWEPlayInteractionViewController : UIViewController
@property (nonatomic, strong) AWEAwemeModel *model;
@property (nonatomic, strong) UIView *bottomContainerView;
@property (nonatomic, strong) UILabel *descriptionLabel;
- (void)configureWithModel:(id)model;
@end

@interface TIKTOKProfileHeaderExtraViewController : UIViewController
- (void)followButtonTapped;
@end

@interface TIKTOKProfileHeaderView : UIView
@property (nonatomic, strong) AWEUserModel *model;
@property (nonatomic, strong) UILabel *bioLabel;
- (void)configureWithModel:(id)model;
@end

@interface AWEProfileImagePreviewView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@end

@interface AWECommentTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *commentLabel;
- (void)configureWithModel:(id)model;
@end

@interface AWEVideoPlayerView : UIView
- (void)setPlayer:(id)player;
@end

@interface AWEFeedTableViewController : UITableViewController
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end

// 通用函数实现
static inline UIViewController *topMostController(void) {
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        window = [[UIApplication sharedApplication].windows firstObject];
    } else {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    UIViewController *topController = window.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    if ([topController isKindOfClass:[UINavigationController class]]) {
        topController = [(UINavigationController *)topController visibleViewController];
    }
    
    if ([topController isKindOfClass:[UITabBarController class]]) {
        topController = [(UITabBarController *)topController selectedViewController];
        if ([topController isKindOfClass:[UINavigationController class]]) {
            topController = [(UINavigationController *)topController visibleViewController];
        }
    }
    
    return topController;
}

static inline BOOL is_iPad(void) {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

// 本地化宏定义
#define BHLocalizedString(key) [BHIManager localizedStringForKey:key]
#define BHLocalizedStringWithDefault(key, defaultValue) ([BHIManager localizedStringForKey:key] ?: defaultValue)

// 颜色宏定义
#define BHAccentColor [BHIManager accentColor]
#define BHSystemBackgroundColor [UIColor systemBackgroundColor]
#define BHSecondarySystemBackgroundColor [UIColor secondarySystemBackgroundColor]

// 字体宏定义
#define BHSystemFont(size) [UIFont systemFontOfSize:size]
#define BHBoldSystemFont(size) [UIFont boldSystemFontOfSize:size]
#define BHMediumSystemFont(size) [UIFont systemFontOfSize:size weight:UIFontWeightMedium]

// 动画宏定义
#define BHAnimationDuration 0.3
#define BHSpringAnimationDuration 0.6
#define BHSpringDamping 0.8
#define BHSpringVelocity 0.5

// 尺寸宏定义
#define BHCornerRadius 12.0
#define BHSmallCornerRadius 8.0
#define BHStandardPadding 16.0
#define BHSmallPadding 8.0

// 通知名称
extern NSString * const BHTikTokUnifiedSettingsChangedNotification;
extern NSString * const BHTikTokUnifiedLanguageChangedNotification;
extern NSString * const BHTikTokUnifiedThemeChangedNotification;