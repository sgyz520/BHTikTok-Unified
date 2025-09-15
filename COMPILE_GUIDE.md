# BHTikTok Unified 编译指南

## 编译错误解决方案

### 问题描述
在编译 `Entry.m (arm64)` 时发生错误，这通常是由于以下原因：

1. **缺少必要的头文件引用**
2. **Cephei框架配置问题**
3. **架构兼容性问题**
4. **依赖文件路径问题**

### 解决方案

#### 方案1: 使用修复后的Entry.m
已修复的 `Entry.m` 文件包含：
- 正确的头文件引用
- 现代化的UIAlertController替代UIAlertView
- 正确的PSSpecifier初始化方法（替代了错误的HBPreferenceSpecifier）
- 与BHIManager一致的NSUserDefaults键值映射

#### 方案2: 使用简化版本
如果方案1仍有问题，可以使用 `Entry_Simple.m`：

1. 编辑 `BHTikTokUnifiedPrefs/Makefile`
2. 注释掉 `BHTikTokUnifiedPrefs_FILES = Entry.m`
3. 取消注释 `BHTikTokUnifiedPrefs_FILES = Entry_Simple.m`

#### 方案3: 自动修复脚本
运行提供的修复脚本：
```bash
chmod +x fix_compile_issues.sh
./fix_compile_issues.sh
```

### 编译步骤

1. **清理之前的编译**
   ```bash
   make clean
   ```

2. **编译项目**
   ```bash
   make package
   ```

3. **如果编译失败，运行诊断**
   ```bash
   chmod +x diagnose_compile.sh
   ./diagnose_compile.sh
   ```

### 常见编译错误及解决方法

#### 错误1: "CepheiPrefs/CepheiPrefs.h file not found"
**解决方法**: 确保安装了Cephei框架
```bash
# 在Theos环境中安装Cephei
git clone https://github.com/hbang/libcephei.git
cd libcephei
make package install
```

#### 错误2: "Undefined symbols for architecture arm64"
**解决方法**: 检查链接的框架和库
- 确保Makefile中包含所有必要的框架
- 检查BHIManager.m是否正确编译

#### 错误3: "UIAlertView is deprecated"
**解决方法**: 已在修复版本中使用UIAlertController替代

### 文件说明

- `Entry.m`: 完整功能的设置界面实现
- `Entry_Simple.m`: 简化版本，使用plist配置
- `Root.plist`: 设置界面配置文件
- `entry.plist`: PreferenceLoader配置文件

### 验证编译成功

编译成功后，应该在 `packages/` 目录下看到生成的 `.deb` 文件。

### 故障排除

如果仍然遇到问题：

1. 检查Theos版本兼容性
2. 确保iOS SDK版本正确
3. 检查设备架构设置
4. 查看详细的编译日志

### 联系支持

如果问题持续存在，请提供：
- 完整的编译错误日志
- Theos版本信息
- 操作系统版本
- 目标iOS版本