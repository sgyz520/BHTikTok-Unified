#import <UIKit/UIKit.h>
#import "../Core/BHIManager.h"

@interface BHRegionInfoView : UIView

// 界面元素
@property (nonatomic, strong) UILabel *uploadTimeLabel;
@property (nonatomic, strong) UILabel *regionLabel;
@property (nonatomic, strong) UIView *containerView;

// 数据模型
@property (nonatomic, strong) id awemeModel;

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame;
- (void)configureWithModel:(id)model;

// 界面配置
- (void)setupViews;
- (void)setupConstraints;
- (void)updateContent;

// 数据处理
- (NSString *)getUploadTimeString;
- (NSString *)getRegionInfoString;

// 显示控制
- (void)show;
- (void)hide;
- (void)updateVisibility;

@end