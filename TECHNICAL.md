# BHTikTok Unified - 技术文档 | Technical Documentation

## 🏗️ 架构概述 | Architecture Overview

**BHTikTok Unified** 是一个基于 Theos 框架构建的 iOS 越狱插件，整合了 [@hahios-2506](https://github.com/hahios-2506) 的 [BHTiktok](https://github.com/hahios-2506/BHTiktok) 项目的完整功能实现和 [@dayanch96](https://github.com/dayanch96) 的 [BHTikTok-Plus](https://github.com/dayanch96/BHTikTok-Plus) 项目的多语言支持与现代化文档。

BHTikTok Unified is an iOS jailbreak tweak built on the Theos framework, integrating the complete functionality from [@hahios-2506](https://github.com/hahios-2506)'s [BHTiktok](https://github.com/hahios-2506/BHTiktok) project with the multi-language support and modern documentation from [@dayanch96](https://github.com/dayanch96)'s [BHTikTok-Plus](https://github.com/dayanch96/BHTikTok-Plus) project.

## 📋 技术规格 | Technical Specifications

### 支持的平台 | Supported Platforms
- **iOS 版本** | **iOS Versions**: 14.0 - 18.x
- **架构支持** | **Architectures**: arm64, arm64e
- **目标应用** | **Target Application**: TikTok (com.zhiliaoapp.musically)
- **开发框架** | **Framework**: Theos + Objective-C Runtime

### 依赖项 | Dependencies
- **MobileSubstrate**: 核心钩子框架 (>= 0.9.5000) | Core hooking framework (>= 0.9.5000)
- **PreferenceLoader**: 设置界面集成 | Settings integration
- **ws.hbang.common**: 通用库支持 | Common library support
- **UIKit**: 用户界面组件 | User interface components
- **Foundation**: 基础框架 | Foundation framework
- **LocalAuthentication**: 生物识别验证 | Biometric authentication

## 🗂️ 项目结构 | Project Structure

```
BHTikTok-Unified/
├── 📄 README.md                           # 项目说明文档 | Project documentation
├── 📄 Makefile                            # 构建配置文件 | Build configuration
├── 📄 control                             # Debian包控制文件 | Debian package control
├── 📄 BHTikTokUnified.plist              # 目标应用过滤器 | Target app filter
├── 📄 Tweak.x                            # 主要Hook实现文件 | Main hook implementation
├── 📄 TECHNICAL.md                       # 技术文档 | Technical documentation
├── 📄 CONTRIBUTING.md                    # 贡献指南 | Contributing guide
├── 📄 LICENSE                            # 许可证文件 | License file
│
├── 📁 Headers/                           # 头文件目录 | Header files directory
│   └── 📄 TikTokHeaders.h                # TikTok应用头文件 | TikTok app headers
│
├── 📁 Core/                              # 核心功能模块 | Core functionality modules
│   ├── 📄 BHIManager.h/.m                # 配置管理器 | Configuration manager
│   ├── 📄 BHDownload.h/.m                # 下载功能实现 | Download functionality
│   └── 📄 BHMultipleDownload.h/.m        # 批量下载功能 | Batch download functionality
│
├── 📁 Controllers/                       # 控制器目录 | Controllers directory
│   ├── 📄 SettingsViewController.h/.m    # 设置界面控制器 | Settings view controller
│   └── 📄 SecurityViewController.h/.m    # 安全验证控制器 | Security verification controller
│
├── 📁 Libraries/                         # 第三方库目录 | Third-party libraries directory
│   └── 📁 JGProgressHUD/                 # 进度指示器库 | Progress indicator library
│       ├── 📄 JGProgressHUD.h/.m         # 主要进度HUD类 | Main progress HUD class
│       ├── 📄 JGProgressHUD-Defines.h    # 定义和常量 | Definitions and constants
│       └── 📄 ...                        # 其他相关文件 | Other related files
│
├── 📁 Resources/                         # 资源文件目录 | Resources directory
│   └── 📁 Localizations/                 # 本地化资源 | Localization resources
│       ├── 📁 en.lproj/                  # 英语本地化 | English localization
│       ├── 📁 zh-Hans.lproj/             # 简体中文本地化 | Simplified Chinese
│       ├── 📁 zh-Hant.lproj/             # 繁体中文本地化 | Traditional Chinese
│       └── 📁 ...                        # 其他语言 | Other languages
│
└── 📁 .github/                           # GitHub配置目录 | GitHub configuration
    └── 📁 workflows/                     # GitHub Actions工作流 | GitHub Actions workflows
        └── 📄 build.yml                  # 构建工作流 | Build workflow
```

## 🔧 核心组件 | Core Components

### 1. 主要Hook文件 (Tweak.x)
负责拦截和修改 TikTok 应用的运行时行为：

```objective-c
// 应用启动Hook
%hook AppDelegate
- (_Bool)application:(UIApplication *)application didFinishLaunchingWithOptions:(id)arg2 {
    %orig;
    // 初始化插件设置
    // Initialize tweak settings
}
%end

// 设置界面集成
%hook AWESettingsNormalSectionViewModel
- (void)viewDidLoad {
    %orig;
    // 添加插件设置入口
    // Add tweak settings entry
}
%end
```

### 2. 配置管理器 (BHIManager)
统一管理所有插件设置和功能开关：

```objective-c
@interface BHIManager : NSObject
+ (BOOL)downloadVideos;
+ (BOOL)hideAds;
+ (BOOL)appLock;
// ... 其他功能方法
@end
```

### 3. 设置界面 (SettingsViewController)
提供用户友好的设置界面：

```objective-c
@interface SettingsViewController : UITableViewController
- (void)setupNavigationBar;
- (void)loadSettingsData;
- (void)showLanguageSelector;
// ... 其他界面方法
@end
```

### 4. 安全验证 (SecurityViewController)
实现应用锁定和生物识别验证：

```objective-c
@interface SecurityViewController : UIViewController
- (void)authenticateWithBiometrics;
- (void)authenticateWithPasscode;
- (void)handleAuthenticationSuccess;
// ... 其他安全方法
@end
```

## 🎯 功能实现 | Feature Implementation

### 下载功能 | Download Features

#### 视频下载 | Video Download
```objective-c
%hook AWEAwemeDetailTableViewCell
- (void)configureWithModel:(id)model {
    %orig;
    if ([BHIManager downloadVideos]) {
        // 添加下载按钮
        // Add download button
    }
}
%end
```

#### 无水印下载 | Watermark-free Download
通过拦截视频URL请求，获取原始无水印视频链接：

```objective-c
%hook AWEURLModel
- (NSString *)originURLString {
    NSString *originalURL = %orig;
    if ([BHIManager downloadWithoutWatermark]) {
        // 处理URL移除水印参数
        // Process URL to remove watermark parameters
    }
    return originalURL;
}
%end
```

### 界面增强 | UI Enhancements

#### 广告移除 | Ad Removal
```objective-c
%hook AWEFeedContainerViewController
- (void)setAweme:(id)aweme {
    if ([BHIManager hideAds]) {
        if ([aweme isAds] || [aweme isAdvertisement]) {
            return; // 跳过广告内容
        }
    }
    %orig;
}
%end
```

#### 进度条显示 | Progress Bar Display
```objective-c
%hook AWEVideoPlayerView
- (void)setPlayer:(id)player {
    %orig;
    if ([BHIManager progressBar]) {
        // 添加自定义进度条
        // Add custom progress bar
    }
}
%end
```

### 安全功能 | Security Features

#### 应用锁定 | App Lock
```objective-c
%hook AppDelegate
- (void)applicationDidBecomeActive:(id)arg1 {
    %orig;
    if ([BHIManager appLock] && !isAuthenticationShowed) {
        // 显示安全验证界面
        // Show security verification interface
    }
}
%end
```

#### 生物识别验证 | Biometric Authentication
```objective-c
- (void)authenticateWithBiometrics {
    [self.authContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                     localizedReason:reason
                               reply:^(BOOL success, NSError *error) {
        // 处理验证结果
        // Handle authentication result
    }];
}
```

### 地区功能 | Region Features

#### 地区切换 | Region Switching
```objective-c
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
%end
```

### 伪造功能 | Fake Features

#### 认证标识伪造 | Verification Badge Spoofing
```objective-c
%hook AWEUserModel
- (BOOL)isVerified {
    if ([BHIManager fakeChangesEnabled] && [BHIManager fakeVerified]) {
        return YES;
    }
    return %orig;
}
%end
```

## 🌐 本地化系统 | Localization System

### 支持的语言 | Supported Languages
- 🇺🇸 English (en)
- 🇨🇳 简体中文 (zh-Hans)
- 🇹🇼 繁體中文 (zh-Hant)
- 🇯🇵 日本語 (ja)
- 🇰🇷 한국어 (ko)
- 🇪🇸 Español (es)
- 🇫🇷 Français (fr)
- 🇩🇪 Deutsch (de)
- 🇷🇺 Русский (ru)
- 🇵🇱 Polski (pl)
- 🇹🇷 Türkçe (tr)
- 🇺🇦 Українська (uk)
- 🇻🇳 Tiếng Việt (vi)
- 🇸🇦 العربية (ar)

### 本地化实现 | Localization Implementation
```objective-c
+ (NSString *)localizedStringForKey:(NSString *)key {
    NSString *language = [self currentLanguage];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]];
    if (!bundle) {
        bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]];
    }
    return [bundle localizedStringForKey:key value:key table:@"BHTikTokUnified"];
}
```

### 宏定义 | Macro Definitions
```objective-c
#define BHLocalizedString(key) [BHIManager localizedStringForKey:key]
#define BHLocalizedStringWithDefault(key, defaultValue) ([BHIManager localizedStringForKey:key] ?: defaultValue)
```

## 🔨 构建系统 | Build System

### Makefile 配置 | Makefile Configuration
```makefile
ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:14.0

TWEAK_NAME = BHTikTokUnified
BHTikTokUnified_FILES = Tweak.x
BHTikTokUnified_FILES += Core/BHIManager.m
BHTikTokUnified_FILES += Controllers/SettingsViewController.m
# ... 其他源文件

BHTikTokUnified_CFLAGS = -fobjc-arc -Wno-deprecated-declarations
BHTikTokUnified_FRAMEWORKS = UIKit Foundation LocalAuthentication
```

### GitHub Actions 工作流 | GitHub Actions Workflow
```yaml
name: Build and Release BHTikTok Unified
on:
  workflow_dispatch:
    inputs:
      bhtiktok_version:
        description: "The version of BHTikTok Unified"
        required: true
      # ... 其他输入参数

jobs:
  build:
    runs-on: macos-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Setup Theos
        # ... 设置构建环境
      - name: Build Package
        # ... 构建包
```

## 🧪 测试策略 | Testing Strategy

### 单元测试 | Unit Testing
- 配置管理器功能测试
- 本地化字符串测试
- 安全验证流程测试

### 集成测试 | Integration Testing
- TikTok 应用兼容性测试
- 不同 iOS 版本兼容性测试
- 多语言界面测试

### 手动测试清单 | Manual Testing Checklist
- [ ] 下载功能测试
- [ ] 界面增强功能测试
- [ ] 安全验证功能测试
- [ ] 地区切换功能测试
- [ ] 伪造功能测试
- [ ] 多语言切换测试

## 🔧 开发工具 | Development Tools

### 推荐的开发环境 | Recommended Development Environment
- **Xcode**: 最新版本 | Latest version
- **Theos**: 最新版本 | Latest version
- **iOS SDK**: 16.5+ 
- **macOS**: 12.0+ (Monterey)

### 调试工具 | Debugging Tools
- **Console.app**: 查看系统日志 | View system logs
- **Xcode Instruments**: 性能分析 | Performance analysis
- **LLDB**: 调试器 | Debugger
- **Hopper Disassembler**: 逆向分析 | Reverse engineering

### 代码质量工具 | Code Quality Tools
- **Clang Static Analyzer**: 静态代码分析 | Static code analysis
- **OCLint**: Objective-C 代码检查 | Objective-C code linting
- **SonarQube**: 代码质量管理 | Code quality management

## 📊 性能优化 | Performance Optimization

### 内存管理 | Memory Management
- 使用 ARC (Automatic Reference Counting)
- 避免循环引用
- 及时释放不需要的资源

### 启动时间优化 | Launch Time Optimization
- 延迟加载非关键功能
- 优化初始化代码
- 减少启动时的 Hook 数量

### 运行时性能 | Runtime Performance
- 缓存频繁访问的数据
- 优化 Hook 方法的执行效率
- 使用异步操作处理耗时任务

## 🔒 安全考虑 | Security Considerations

### 代码混淆 | Code Obfuscation
- 保护关键算法和逻辑
- 防止逆向工程
- 使用符号混淆

### 数据保护 | Data Protection
- 加密敏感配置信息
- 安全存储用户数据
- 防止数据泄露

### 权限管理 | Permission Management
- 最小权限原则
- 安全的 API 调用
- 用户隐私保护

## 🚀 部署流程 | Deployment Process

### 构建流程 | Build Process
1. 代码检查和测试
2. 版本号更新
3. 自动化构建
4. 包签名和验证
5. 发布到仓库

### 发布策略 | Release Strategy
- **Alpha**: 内部测试版本
- **Beta**: 公开测试版本
- **Stable**: 稳定发布版本
- **Hotfix**: 紧急修复版本

## 📈 监控和分析 | Monitoring and Analytics

### 错误监控 | Error Monitoring
- 崩溃报告收集
- 错误日志分析
- 性能指标监控

### 使用情况分析 | Usage Analytics
- 功能使用统计
- 用户行为分析
- 性能指标跟踪

## 🔮 未来规划 | Future Plans

### 短期目标 | Short-term Goals
- 添加更多下载格式支持
- 优化界面响应速度
- 增加新的语言支持

### 长期目标 | Long-term Goals
- 支持更多社交媒体平台
- 开发独立的设置应用
- 实现云端配置同步

---

*本技术文档随项目更新而维护，每个主要版本发布时都会更新。*

*This technical documentation is maintained alongside the project and updated with each major release.*