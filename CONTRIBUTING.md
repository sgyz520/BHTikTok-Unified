# 为 BHTikTok Unified 做贡献 | Contributing to BHTikTok Unified

感谢您对为 BHTikTok Unified 做贡献的兴趣！本文档为贡献者提供指南和信息。

Thank you for your interest in contributing to BHTikTok Unified! This document provides guidelines and information for contributors.

## 🌟 贡献方式 | Ways to Contribute

### 🌐 本地化 | Localization
帮助我们让 BHTikTok Unified 为全世界更多用户所用：
Help us make BHTikTok Unified accessible to more users worldwide:

- **改进现有翻译** | **Improve existing translations** - 修复错误或提高清晰度 | Fix errors or improve clarity
- **添加新语言** | **Add new languages** - 扩展我们的语言支持 | Expand our language support
- **审查翻译** | **Review translations** - 帮助维护翻译质量 | Help maintain translation quality

### 🐛 错误报告 | Bug Reports
发现问题？请帮助我们修复：
Found an issue? Help us fix it:

- **详细描述问题** | **Describe the issue in detail**
- **提供重现步骤** | **Provide reproduction steps**
- **包含系统信息** | **Include system information**
- **附加截图或日志** | **Attach screenshots or logs**

### 💡 功能建议 | Feature Requests
有好想法？我们很乐意听到：
Have a great idea? We'd love to hear it:

- **清楚描述功能** | **Clearly describe the feature**
- **解释使用场景** | **Explain the use case**
- **考虑实现复杂度** | **Consider implementation complexity**

### 🔧 代码贡献 | Code Contributions
想要直接贡献代码？太棒了！
Want to contribute code directly? Awesome!

- **修复错误** | **Fix bugs**
- **实现新功能** | **Implement new features**
- **改进性能** | **Improve performance**
- **优化代码** | **Optimize code**

## 🚀 开始贡献 | Getting Started

### 1. 设置开发环境 | Setting Up Development Environment

#### 前提条件 | Prerequisites
- **macOS**: 12.0+ (Monterey)
- **Xcode**: 最新版本 | Latest version
- **Theos**: 最新版本 | Latest version
- **Git**: 版本控制 | Version control

#### 安装步骤 | Installation Steps
```bash
# 1. 克隆仓库 | Clone repository
git clone https://github.com/your-username/BHTikTok-Unified.git
cd BHTikTok-Unified

# 2. 安装依赖 | Install dependencies
brew install ldid dpkg make

# 3. 设置 Theos | Setup Theos
git clone --recursive https://github.com/theos/theos.git $THEOS

# 4. 下载 iOS SDK | Download iOS SDK
# 按照 Theos 文档下载适当的 SDK
# Follow Theos documentation to download appropriate SDK

# 5. 构建项目 | Build project
make clean && make
```

### 2. 项目结构理解 | Understanding Project Structure

请阅读 [TECHNICAL.md](TECHNICAL.md) 了解详细的项目架构和技术实现。

Please read [TECHNICAL.md](TECHNICAL.md) for detailed project architecture and technical implementation.

### 3. 编码规范 | Coding Standards

#### Objective-C 规范 | Objective-C Guidelines
```objective-c
// ✅ 好的示例 | Good example
@interface BHExampleClass : NSObject
@property (nonatomic, strong) NSString *exampleProperty;
- (void)exampleMethodWithParameter:(NSString *)parameter;
@end

// ❌ 不好的示例 | Bad example
@interface example : NSObject
@property NSString* prop;
-(void)method:(NSString*)param;
@end
```

#### 命名约定 | Naming Conventions
- **类名**: 使用 `BH` 前缀 | Use `BH` prefix for classes
- **方法名**: 使用驼峰命名法 | Use camelCase for methods
- **常量**: 使用 `k` 前缀 | Use `k` prefix for constants
- **宏定义**: 使用全大写 | Use UPPERCASE for macros

#### 代码风格 | Code Style
- **缩进**: 4个空格 | 4 spaces for indentation
- **大括号**: K&R 风格 | K&R style braces
- **行长度**: 最大120字符 | Maximum 120 characters per line
- **注释**: 使用双语注释 | Use bilingual comments

### 4. 提交规范 | Commit Guidelines

#### 提交消息格式 | Commit Message Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

#### 类型 | Types
- **feat**: 新功能 | New feature
- **fix**: 错误修复 | Bug fix
- **docs**: 文档更新 | Documentation update
- **style**: 代码格式 | Code formatting
- **refactor**: 代码重构 | Code refactoring
- **test**: 测试相关 | Testing
- **chore**: 构建过程或辅助工具的变动 | Build process or auxiliary tool changes

#### 示例 | Examples
```bash
feat(download): add HD video download support

- Implement HD video quality detection
- Add user preference for HD downloads
- Update download UI with quality options

Closes #123
```

```bash
fix(security): resolve biometric authentication issue

- Fix Face ID authentication failure on iOS 16
- Add fallback to passcode authentication
- Improve error handling and user feedback

Fixes #456
```

## 🌐 本地化贡献 | Localization Contributions

### 添加新语言 | Adding New Languages

1. **创建语言文件夹** | **Create language folder**
   ```bash
   mkdir -p Resources/Localizations/[language-code].lproj
   ```

2. **复制英语模板** | **Copy English template**
   ```bash
   cp Resources/Localizations/en.lproj/Localizable.strings \
      Resources/Localizations/[language-code].lproj/
   ```

3. **翻译字符串** | **Translate strings**
   ```
   /* Headers */
   "Settings" = "Your Translation";
   "Developer" = "Your Translation";
   ```

4. **更新语言列表** | **Update language list**
   在 `BHIManager.m` 中添加新语言到 `supportedLanguages` 数组。
   Add the new language to the `supportedLanguages` array in `BHIManager.m`.

### 翻译指南 | Translation Guidelines

#### 一般原则 | General Principles
- **保持简洁** | **Keep it concise** - 界面空间有限 | UI space is limited
- **保持一致** | **Be consistent** - 使用统一的术语 | Use consistent terminology
- **考虑文化** | **Consider culture** - 适应当地文化习惯 | Adapt to local cultural practices
- **测试界面** | **Test UI** - 确保翻译在界面中正确显示 | Ensure translations display correctly in UI

#### 特殊注意事项 | Special Considerations
- **按钮文本**: 应该简短有力 | Button text should be short and actionable
- **错误消息**: 应该清晰易懂 | Error messages should be clear and understandable
- **设置项**: 应该准确描述功能 | Settings items should accurately describe functionality

### 翻译质量检查 | Translation Quality Check

#### 自检清单 | Self-check Checklist
- [ ] 所有字符串都已翻译 | All strings are translated
- [ ] 翻译准确无误 | Translations are accurate
- [ ] 语法正确 | Grammar is correct
- [ ] 术语一致 | Terminology is consistent
- [ ] 界面测试通过 | UI testing passed

#### 同行评审 | Peer Review
我们鼓励翻译者之间相互评审，以确保翻译质量。

We encourage translators to review each other's work to ensure translation quality.

## 🐛 错误报告 | Bug Reports

### 报告模板 | Report Template

```markdown
## 🐛 错误描述 | Bug Description
简要描述遇到的问题。
Brief description of the issue encountered.

## 📱 环境信息 | Environment Information
- **设备型号** | **Device Model**: iPhone 14 Pro
- **iOS 版本** | **iOS Version**: 16.5
- **TikTok 版本** | **TikTok Version**: 31.5.0
- **插件版本** | **Tweak Version**: 1.0.0
- **越狱工具** | **Jailbreak Tool**: checkra1n

## 🔄 重现步骤 | Reproduction Steps
1. 打开 TikTok 应用 | Open TikTok app
2. 进入设置页面 | Go to settings page
3. 点击下载选项 | Tap download options
4. 观察到错误 | Observe the error

## 📋 预期行为 | Expected Behavior
描述您期望发生的情况。
Describe what you expected to happen.

## 📋 实际行为 | Actual Behavior
描述实际发生的情况。
Describe what actually happened.

## 📸 截图 | Screenshots
如果适用，请添加截图来帮助解释问题。
If applicable, add screenshots to help explain the problem.

## 📄 日志 | Logs
如果有相关日志，请粘贴在这里。
If you have relevant logs, please paste them here.

## 💡 其他信息 | Additional Information
添加任何其他有助于解决问题的信息。
Add any other information that might help resolve the issue.
```

### 错误优先级 | Bug Priority

#### 🔴 高优先级 | High Priority
- 应用崩溃 | App crashes
- 核心功能失效 | Core functionality broken
- 安全漏洞 | Security vulnerabilities
- 数据丢失 | Data loss

#### 🟡 中优先级 | Medium Priority
- 功能异常 | Feature malfunctions
- 界面问题 | UI issues
- 性能问题 | Performance issues
- 兼容性问题 | Compatibility issues

#### 🟢 低优先级 | Low Priority
- 界面美化 | UI enhancements
- 功能改进 | Feature improvements
- 文档更新 | Documentation updates
- 代码优化 | Code optimization

## 💡 功能建议 | Feature Requests

### 建议模板 | Request Template

```markdown
## 💡 功能描述 | Feature Description
清楚简洁地描述您想要的功能。
A clear and concise description of what you want to happen.

## 🎯 使用场景 | Use Case
描述这个功能的使用场景和目标用户。
Describe the use case and target users for this feature.

## 📋 详细需求 | Detailed Requirements
详细描述功能的具体需求和行为。
Detailed description of the specific requirements and behavior.

## 🎨 界面设计 | UI Design
如果涉及界面，请描述或提供设计草图。
If UI is involved, describe or provide design sketches.

## 🔧 技术考虑 | Technical Considerations
如果您了解技术实现，请提供相关信息。
If you understand the technical implementation, provide relevant information.

## 📊 优先级 | Priority
说明这个功能对您的重要程度。
Explain how important this feature is to you.

## 💭 替代方案 | Alternatives
描述您考虑过的其他解决方案。
Describe alternative solutions you've considered.
```

## 🔧 代码贡献 | Code Contributions

### Pull Request 流程 | Pull Request Process

#### 1. 准备工作 | Preparation
```bash
# Fork 仓库并克隆 | Fork repository and clone
git clone https://github.com/your-username/BHTikTok-Unified.git
cd BHTikTok-Unified

# 创建功能分支 | Create feature branch
git checkout -b feature/your-feature-name
```

#### 2. 开发 | Development
- 遵循编码规范 | Follow coding standards
- 添加必要的注释 | Add necessary comments
- 编写测试代码 | Write test code
- 更新文档 | Update documentation

#### 3. 测试 | Testing
```bash
# 构建项目 | Build project
make clean && make

# 运行测试 | Run tests
make test

# 检查代码质量 | Check code quality
make lint
```

#### 4. 提交 | Commit
```bash
# 添加更改 | Add changes
git add .

# 提交更改 | Commit changes
git commit -m "feat(scope): add new feature"

# 推送到远程 | Push to remote
git push origin feature/your-feature-name
```

#### 5. 创建 Pull Request | Create Pull Request
- 使用清晰的标题 | Use clear title
- 详细描述更改 | Describe changes in detail
- 链接相关 Issue | Link related issues
- 请求代码审查 | Request code review

### Pull Request 模板 | Pull Request Template

```markdown
## 📋 更改描述 | Description of Changes
简要描述这个 PR 的更改内容。
Brief description of what this PR changes.

## 🔗 相关 Issue | Related Issues
Closes #123
Fixes #456

## 🧪 测试 | Testing
- [ ] 单元测试通过 | Unit tests pass
- [ ] 集成测试通过 | Integration tests pass
- [ ] 手动测试完成 | Manual testing completed
- [ ] 在真实设备上测试 | Tested on real device

## 📸 截图 | Screenshots
如果有界面更改，请提供截图。
If there are UI changes, please provide screenshots.

## ✅ 检查清单 | Checklist
- [ ] 代码遵循项目规范 | Code follows project standards
- [ ] 添加了必要的注释 | Added necessary comments
- [ ] 更新了相关文档 | Updated relevant documentation
- [ ] 添加了适当的测试 | Added appropriate tests
- [ ] 所有测试都通过 | All tests pass

## 💭 其他说明 | Additional Notes
任何其他需要说明的信息。
Any additional information that needs to be explained.
```

### 代码审查 | Code Review

#### 审查重点 | Review Focus
- **功能正确性** | **Functionality correctness**
- **代码质量** | **Code quality**
- **性能影响** | **Performance impact**
- **安全考虑** | **Security considerations**
- **文档完整性** | **Documentation completeness**

#### 审查标准 | Review Standards
- 代码可读性强 | Code is readable
- 逻辑清晰合理 | Logic is clear and reasonable
- 错误处理完善 | Error handling is comprehensive
- 测试覆盖充分 | Test coverage is sufficient
- 文档更新及时 | Documentation is up to date

## 📚 文档贡献 | Documentation Contributions

### 文档类型 | Documentation Types
- **用户指南** | **User guides** - 帮助用户使用功能 | Help users use features
- **开发文档** | **Developer docs** - 帮助开发者理解代码 | Help developers understand code
- **API 文档** | **API documentation** - 接口说明 | Interface descriptions
- **故障排除** | **Troubleshooting** - 常见问题解决 | Common problem solutions

### 文档规范 | Documentation Standards
- 使用 Markdown 格式 | Use Markdown format
- 提供双语内容 | Provide bilingual content
- 包含代码示例 | Include code examples
- 添加截图说明 | Add screenshot explanations

## 🎉 贡献者认可 | Contributor Recognition

### 贡献者类型 | Contributor Types
- **🌟 核心贡献者** | **Core Contributors** - 长期活跃的主要贡献者 | Long-term active major contributors
- **🔧 代码贡献者** | **Code Contributors** - 提交代码的贡献者 | Contributors who submit code
- **🌐 翻译贡献者** | **Translation Contributors** - 提供翻译的贡献者 | Contributors who provide translations
- **📚 文档贡献者** | **Documentation Contributors** - 改进文档的贡献者 | Contributors who improve documentation
- **🐛 测试贡献者** | **Testing Contributors** - 报告问题的贡献者 | Contributors who report issues

### 认可方式 | Recognition Methods
- **贡献者列表** | **Contributors list** - 在 README 中列出 | Listed in README
- **发布说明** | **Release notes** - 在发布说明中感谢 | Thanked in release notes
- **特殊徽章** | **Special badges** - GitHub 个人资料徽章 | GitHub profile badges
- **社区荣誉** | **Community honors** - 社区内的特殊认可 | Special recognition within community

## 📞 联系我们 | Contact Us

### 沟通渠道 | Communication Channels
- **GitHub Issues**: 错误报告和功能建议 | Bug reports and feature requests
- **GitHub Discussions**: 一般讨论和问答 | General discussions and Q&A
- **Telegram**: [@BHTikTokUnified](https://t.me/BHTikTokUnified) - 实时交流 | Real-time communication
- **Email**: contribute@bhtiktok-unified.com - 私人联系 | Private contact

### 响应时间 | Response Time
- **错误报告** | **Bug reports**: 24-48 小时 | 24-48 hours
- **功能建议** | **Feature requests**: 3-7 天 | 3-7 days
- **Pull Request** | **Pull requests**: 2-5 天 | 2-5 days
- **一般问题** | **General questions**: 1-3 天 | 1-3 days

## 📜 行为准则 | Code of Conduct

### 我们的承诺 | Our Pledge
我们致力于为每个人提供友好、安全和受欢迎的环境，无论年龄、身体大小、残疾、种族、性别认同和表达、经验水平、教育、社会经济地位、国籍、个人外貌、种族、宗教或性取向如何。

We are committed to providing a friendly, safe and welcoming environment for all, regardless of age, body size, disability, ethnicity, gender identity and expression, level of experience, education, socio-economic status, nationality, personal appearance, race, religion, or sexual orientation.

### 我们的标准 | Our Standards
#### 积极行为 | Positive Behavior
- 使用友好和包容的语言 | Using welcoming and inclusive language
- 尊重不同的观点和经验 | Being respectful of differing viewpoints and experiences
- 优雅地接受建设性批评 | Gracefully accepting constructive criticism
- 专注于对社区最有利的事情 | Focusing on what is best for the community
- 对其他社区成员表现出同理心 | Showing empathy towards other community members

#### 不当行为 | Unacceptable Behavior
- 使用性化的语言或图像 | The use of sexualized language or imagery
- 人身攻击或政治攻击 | Personal or political attacks
- 公开或私下骚扰 | Public or private harassment
- 未经明确许可发布他人的私人信息 | Publishing others' private information without explicit permission
- 在专业环境中可能被认为不当的其他行为 | Other conduct which could reasonably be considered inappropriate in a professional setting

### 执行 | Enforcement
不当行为可以通过 conduct@bhtiktok-unified.com 向项目团队报告。所有投诉都将被审查和调查，并将导致被认为必要和适当的回应。

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by contacting the project team at conduct@bhtiktok-unified.com. All complaints will be reviewed and investigated and will result in a response that is deemed necessary and appropriate to the circumstances.

## 🙏 感谢 | Acknowledgments

感谢所有为 BHTikTok Unified 做出贡献的人！您的努力使这个项目变得更好。

Thank you to everyone who contributes to BHTikTok Unified! Your efforts make this project better.

### 特别感谢 | Special Thanks
- **[@hahios-2506](https://github.com/hahios-2506)** | **BHTiktok 项目原始开发者** - [项目地址](https://github.com/hahios-2506/BHTiktok)
- **[@dayanch96](https://github.com/dayanch96)** | **BHTikTok-Plus 项目开发者** - [项目地址](https://github.com/dayanch96/BHTikTok-Plus)
- **所有翻译贡献者** | **All translation contributors**
- **测试和反馈提供者** | **Testers and feedback providers**
- **开源社区** | **Open source community**

---

**再次感谢您的贡献！让我们一起让 BHTikTok Unified 变得更好！**

**Thank you again for your contributions! Let's make BHTikTok Unified better together!**