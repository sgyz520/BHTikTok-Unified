#import "SecurityViewController.h"
#import "../Headers/TikTokHeaders.h"

@implementation SecurityViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.authContext = [[LAContext alloc] init];
        self.isAuthenticating = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBlurEffect];
    [self setupContainerView];
    [self setupIconImageView];
    [self setupLabels];
    [self setupButtons];
    [self setupConstraints];
    [self updateInterfaceForAuthenticationType];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.alpha = 0.0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:BHAnimationDuration animations:^{
        self.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self startAuthentication];
        }
    }];
}

#pragma mark - 界面配置

- (void)setupBlurEffect {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterial];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurEffectView.frame = self.view.bounds;
    self.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.blurEffectView];
}

- (void)setupContainerView {
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = BHSecondarySystemBackgroundColor;
    self.containerView.layer.cornerRadius = BHCornerRadius;
    self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.containerView.layer.shadowOffset = CGSizeMake(0, 4);
    self.containerView.layer.shadowRadius = 12;
    self.containerView.layer.shadowOpacity = 0.15;
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.containerView];
}

- (void)setupIconImageView {
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImageView.tintColor = BHAccentColor;
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.iconImageView];
}

- (void)setupLabels {
    // 标题标签
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = BHLocalizedString(@"Authentication Required");
    self.titleLabel.font = BHBoldSystemFont(20);
    self.titleLabel.textColor = [UIColor labelColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.titleLabel];
    
    // 消息标签
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.text = BHLocalizedString(@"Please authenticate to continue");
    self.messageLabel.font = BHSystemFont(16);
    self.messageLabel.textColor = [UIColor secondaryLabelColor];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.messageLabel];
}

- (void)setupButtons {
    // 认证按钮
    self.authenticateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.authenticateButton setTitle:BHLocalizedString(@"Authenticate") forState:UIControlStateNormal];
    self.authenticateButton.titleLabel.font = BHMediumSystemFont(17);
    [self.authenticateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.authenticateButton.backgroundColor = BHAccentColor;
    self.authenticateButton.layer.cornerRadius = BHSmallCornerRadius;
    [self.authenticateButton addTarget:self action:@selector(authenticateButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    self.authenticateButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.authenticateButton];
    
    // 取消按钮
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cancelButton setTitle:BHLocalizedString(@"Cancel") forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = BHSystemFont(17);
    [self.cancelButton setTitleColor:[UIColor systemRedColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.cancelButton];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        // 容器视图约束
        [self.containerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.containerView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.containerView.widthAnchor constraintEqualToConstant:300],
        [self.containerView.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.view.leadingAnchor constant:BHStandardPadding],
        [self.containerView.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.trailingAnchor constant:-BHStandardPadding],
        
        // 图标约束
        [self.iconImageView.topAnchor constraintEqualToAnchor:self.containerView.topAnchor constant:BHStandardPadding * 2],
        [self.iconImageView.centerXAnchor constraintEqualToAnchor:self.containerView.centerXAnchor],
        [self.iconImageView.widthAnchor constraintEqualToConstant:60],
        [self.iconImageView.heightAnchor constraintEqualToConstant:60],
        
        // 标题约束
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.iconImageView.bottomAnchor constant:BHStandardPadding],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:BHStandardPadding],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor constant:-BHStandardPadding],
        
        // 消息约束
        [self.messageLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:BHSmallPadding],
        [self.messageLabel.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:BHStandardPadding],
        [self.messageLabel.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor constant:-BHStandardPadding],
        
        // 认证按钮约束
        [self.authenticateButton.topAnchor constraintEqualToAnchor:self.messageLabel.bottomAnchor constant:BHStandardPadding * 1.5],
        [self.authenticateButton.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:BHStandardPadding],
        [self.authenticateButton.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor constant:-BHStandardPadding],
        [self.authenticateButton.heightAnchor constraintEqualToConstant:44],
        
        // 取消按钮约束
        [self.cancelButton.topAnchor constraintEqualToAnchor:self.authenticateButton.bottomAnchor constant:BHSmallPadding],
        [self.cancelButton.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:BHStandardPadding],
        [self.cancelButton.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor constant:-BHStandardPadding],
        [self.cancelButton.heightAnchor constraintEqualToConstant:44],
        [self.cancelButton.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor constant:-BHStandardPadding * 2]
    ]];
}

- (void)updateInterfaceForAuthenticationType {
    if ([self isBiometricAuthenticationAvailable]) {
        LABiometryType biometryType = [self.authContext biometryType];
        
        switch (biometryType) {
            case LABiometryTypeFaceID:
                self.iconImageView.image = [UIImage systemImageNamed:@"faceid"];
                [self.authenticateButton setTitle:[NSString stringWithFormat:@"%@ Face ID", BHLocalizedString(@"Use")] forState:UIControlStateNormal];
                break;
            case LABiometryTypeTouchID:
                self.iconImageView.image = [UIImage systemImageNamed:@"touchid"];
                [self.authenticateButton setTitle:[NSString stringWithFormat:@"%@ Touch ID", BHLocalizedString(@"Use")] forState:UIControlStateNormal];
                break;
            default:
                self.iconImageView.image = [UIImage systemImageNamed:@"lock.shield"];
                [self.authenticateButton setTitle:BHLocalizedString(@"Authenticate") forState:UIControlStateNormal];
                break;
        }
    } else {
        self.iconImageView.image = [UIImage systemImageNamed:@"lock.shield"];
        [self.authenticateButton setTitle:BHLocalizedString(@"Enter Passcode") forState:UIControlStateNormal];
    }
}

#pragma mark - 认证功能

- (void)startAuthentication {
    if (self.isAuthenticating) {
        return;
    }
    
    if ([self isBiometricAuthenticationAvailable]) {
        [self authenticateWithBiometrics];
    } else {
        [self authenticateWithPasscode];
    }
}

- (void)authenticateWithBiometrics {
    self.isAuthenticating = YES;
    
    NSString *reason = BHLocalizedString(@"Please authenticate to continue");
    
    [self.authContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                     localizedReason:reason
                               reply:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isAuthenticating = NO;
            
            if (success) {
                [self handleAuthenticationSuccess];
            } else {
                [self handleAuthenticationFailure:error];
            }
        });
    }];
}

- (void)authenticateWithPasscode {
    self.isAuthenticating = YES;
    
    NSString *reason = BHLocalizedString(@"Please authenticate to continue");
    
    [self.authContext evaluatePolicy:LAPolicyDeviceOwnerAuthentication
                     localizedReason:reason
                               reply:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isAuthenticating = NO;
            
            if (success) {
                [self handleAuthenticationSuccess];
            } else {
                [self handleAuthenticationFailure:error];
            }
        });
    }];
}

- (void)handleAuthenticationSuccess {
    [UIView animateWithDuration:BHAnimationDuration animations:^{
        self.view.alpha = 0.0;
        self.containerView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)handleAuthenticationFailure:(NSError *)error {
    if (error.code == LAErrorUserCancel || error.code == LAErrorSystemCancel) {
        // 用户取消，不显示错误
        return;
    }
    
    NSString *errorMessage;
    switch (error.code) {
        case LAErrorAuthenticationFailed:
            errorMessage = BHLocalizedString(@"Authentication Failed");
            break;
        case LAErrorUserFallback:
            [self authenticateWithPasscode];
            return;
        case LAErrorBiometryNotAvailable:
            [self authenticateWithPasscode];
            return;
        case LAErrorBiometryLockout:
            errorMessage = BHLocalizedString(@"Too many failed attempts. Please try again later.");
            break;
        default:
            errorMessage = BHLocalizedString(@"Please try again");
            break;
    }
    
    [self showErrorAlert:errorMessage];
    
    // 添加震动反馈
    if (@available(iOS 10.0, *)) {
        UINotificationFeedbackGenerator *feedbackGenerator = [[UINotificationFeedbackGenerator alloc] init];
        [feedbackGenerator notificationOccurred:UINotificationFeedbackTypeError];
    }
    
    // 添加摇晃动画
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    shakeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    shakeAnimation.duration = 0.6;
    shakeAnimation.values = @[@(-20), @(20), @(-20), @(20), @(-10), @(10), @(-5), @(5), @(0)];
    [self.containerView.layer addAnimation:shakeAnimation forKey:@"shake"];
}

#pragma mark - 用户交互

- (void)authenticateButtonTapped {
    [self startAuthentication];
}

- (void)cancelButtonTapped {
    [UIView animateWithDuration:BHAnimationDuration animations:^{
        self.view.alpha = 0.0;
        self.containerView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        // 退出应用
        exit(0);
    }];
}

#pragma mark - 实用方法

- (BOOL)isBiometricAuthenticationAvailable {
    NSError *error = nil;
    return [self.authContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
}

- (NSString *)biometricAuthenticationTypeString {
    if (![self isBiometricAuthenticationAvailable]) {
        return nil;
    }
    
    LABiometryType biometryType = [self.authContext biometryType];
    switch (biometryType) {
        case LABiometryTypeFaceID:
            return @"Face ID";
        case LABiometryTypeTouchID:
            return @"Touch ID";
        default:
            return @"Biometric";
    }
}

- (void)showErrorAlert:(NSString *)message {
    UIAlertController *alert = [UIAlertController 
        alertControllerWithTitle:BHLocalizedString(@"Authentication Failed")
        message:message
        preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction 
        actionWithTitle:BHLocalizedString(@"Retry")
        style:UIAlertActionStyleDefault 
        handler:^(UIAlertAction *action) {
            [self startAuthentication];
        }]];
    
    [alert addAction:[UIAlertAction 
        actionWithTitle:BHLocalizedString(@"Cancel")
        style:UIAlertActionStyleCancel 
        handler:^(UIAlertAction *action) {
            [self cancelButtonTapped];
        }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end