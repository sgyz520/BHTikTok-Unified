#import "BHRegionInfoView.h"
#import "../Headers/TikTokHeaders.h"

@implementation BHRegionInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [self setupConstraints];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    
    // 容器视图
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    self.containerView.layer.cornerRadius = 8.0;
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.containerView];
    
    // 上传时间标签
    self.uploadTimeLabel = [[UILabel alloc] init];
    self.uploadTimeLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    self.uploadTimeLabel.textColor = [UIColor whiteColor];
    self.uploadTimeLabel.textAlignment = NSTextAlignmentLeft;
    self.uploadTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.uploadTimeLabel];
    
    // 地区信息标签
    self.regionLabel = [[UILabel alloc] init];
    self.regionLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    self.regionLabel.textColor = [UIColor whiteColor];
    self.regionLabel.textAlignment = NSTextAlignmentLeft;
    self.regionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.regionLabel];
    
    // 设置默认隐藏状态
    self.containerView.hidden = YES;
    self.uploadTimeLabel.hidden = YES;
    self.regionLabel.hidden = YES;
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        // 容器视图约束
        [self.containerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12],
        [self.containerView.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor constant:-12],
        [self.containerView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.containerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        
        // 上传时间标签约束
        [self.uploadTimeLabel.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:8],
        [self.uploadTimeLabel.topAnchor constraintEqualToAnchor:self.containerView.topAnchor constant:4],
        [self.uploadTimeLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.containerView.trailingAnchor constant:-8],
        
        // 地区信息标签约束
        [self.regionLabel.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:8],
        [self.regionLabel.topAnchor constraintEqualToAnchor:self.uploadTimeLabel.bottomAnchor constant:2],
        [self.regionLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.containerView.trailingAnchor constant:-8],
        [self.regionLabel.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor constant:-4]
    ]];
}

- (void)configureWithModel:(id)model {
    self.awemeModel = model;
    [self updateContent];
    [self updateVisibility];
}

- (void)updateContent {
    // 更新上传时间
    NSString *uploadTimeString = [self getUploadTimeString];
    if (uploadTimeString.length > 0 && [BHIManager showUploadTime]) {
        self.uploadTimeLabel.text = uploadTimeString;
        self.uploadTimeLabel.hidden = NO;
    } else {
        self.uploadTimeLabel.hidden = YES;
    }
    
    // 更新地区信息
    NSString *regionString = [self getRegionInfoString];
    if (regionString.length > 0 && [BHIManager showRegionInfo]) {
        // 添加"ip属地："前缀
        NSString *ipLocationText = BHLocalizedString(@"IPLocation");
        self.regionLabel.text = [NSString stringWithFormat:@"%@: %@", ipLocationText, regionString];
        self.regionLabel.hidden = NO;
    } else {
        self.regionLabel.hidden = YES;
    }
    
    // 如果两个标签都隐藏，隐藏整个容器
    self.containerView.hidden = (self.uploadTimeLabel.hidden && self.regionLabel.hidden);
}

- (NSString *)getUploadTimeString {
    if (!self.awemeModel || ![BHIManager showUploadTime]) {
        return @"";
    }
    
    NSDate *uploadDate = nil;
    
    // 尝试从createTime获取时间戳
    if ([self.awemeModel respondsToSelector:@selector(createTime)]) {
        NSNumber *createTime = [self.awemeModel createTime];
        if (createTime && [createTime isKindOfClass:[NSNumber class]]) {
            // TikTok的时间戳通常是秒级的
            uploadDate = [NSDate dateWithTimeIntervalSince1970:[createTime doubleValue]];
        }
    }
    
    // 如果没有获取到时间，尝试其他方法
    if (!uploadDate && [self.awemeModel respondsToSelector:@selector(uploadDate)]) {
        uploadDate = [self.awemeModel uploadDate];
    }
    
    // 如果还是没有，尝试从其他属性获取
    if (!uploadDate && [self.awemeModel respondsToSelector:@selector(createTimeStr)]) {
        NSString *createTimeStr = [self.awemeModel createTimeStr];
        if (createTimeStr && createTimeStr.length > 0) {
            // 尝试解析字符串格式的日期
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
            uploadDate = [formatter dateFromString:createTimeStr];
            
            if (!uploadDate) {
                // 尝试其他格式
                formatter.dateFormat = @"yyyy-MM-dd";
                uploadDate = [formatter dateFromString:createTimeStr];
            }
        }
    }
    
    // 如果仍然没有获取到时间，使用当前时间作为示例
    if (!uploadDate) {
        uploadDate = [NSDate date];
    }
    
    // 使用BHIManager的格式化方法，确保格式为"年-月-日"
    return [BHIManager formatUploadDate:uploadDate];
}

- (NSString *)getRegionInfoString {
    if (!self.awemeModel || ![BHIManager showRegionInfo]) {
        return @"";
    }
    
    NSString *ipLocation = [BHIManager getIPLocationFromModel:self.awemeModel];
    
    if (ipLocation && ipLocation.length > 0) {
        // 直接返回地区信息，格式为"国家 城市"
        return ipLocation;
    }
    
    return @"";
}

- (void)show {
    self.hidden = NO;
    self.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.hidden = YES;
        }
    }];
}

- (void)updateVisibility {
    BOOL shouldShow = ([BHIManager showUploadTime] && self.uploadTimeLabel.text.length > 0) || 
                      ([BHIManager showRegionInfo] && self.regionLabel.text.length > 0);
    
    if (shouldShow && self.containerView.hidden) {
        self.containerView.hidden = NO;
        self.containerView.alpha = 0.0;
        [UIView animateWithDuration:0.3 animations:^{
            self.containerView.alpha = 1.0;
        }];
    } else if (!shouldShow && !self.containerView.hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.containerView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                self.containerView.hidden = YES;
            }
        }];
    }
}

@end