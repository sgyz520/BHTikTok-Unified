#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "../Core/BHIManager.h"

@interface SecurityViewController : UIViewController

// 界面元素
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *authenticateButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

// 认证相关
@property (nonatomic, strong) LAContext *authContext;
@property (nonatomic, assign) BOOL isAuthenticating;

// 初始化和生命周期
- (instancetype)init;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;

// 界面配置
- (void)setupBlurEffect;
- (void)setupContainerView;
- (void)setupIconImageView;
- (void)setupLabels;
- (void)setupButtons;
- (void)setupConstraints;
- (void)updateInterfaceForAuthenticationType;

// 认证功能
- (void)startAuthentication;
- (void)authenticateWithBiometrics;
- (void)authenticateWithPasscode;
- (void)handleAuthenticationSuccess;
- (void)handleAuthenticationFailure:(NSError *)error;

// 用户交互
- (void)authenticateButtonTapped;
- (void)cancelButtonTapped;

// 实用方法
- (BOOL)isBiometricAuthenticationAvailable;
- (NSString *)biometricAuthenticationTypeString;
- (void)showErrorAlert:(NSString *)message;

@end