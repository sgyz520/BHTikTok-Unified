# 🔄 更新到GitHub并重新打包指南

## 步骤1：提交更改到GitHub

```bash
# 添加所有更改
git add .

# 提交更改
git commit -m "fix: 修复Preference Bundle配置和清理项目结构

- 修复Makefile中的Preference Bundle包含问题
- 清理无关的测试脚本和修复文件
- 优化项目结构，专注于核心功能
- 更新核心代码文件"

# 推送到GitHub
git push origin main
```

## 步骤2：重新打包deb（本地构建）

```bash
# 清理旧构建
make clean

# 重新构建（包含Preference Bundle）
make package FINALPACKAGE=1

# 检查构建结果
ls -la packages/
```

## 步骤3：验证构建结果

构建完成后，检查以下文件：
- `packages/`目录中的.deb文件
- 确保包含Preference Bundle

## 步骤4：GitHub Actions自动构建

推送到main分支后，GitHub Actions会自动：
- 构建新的deb包
- 创建发布版本
- 生成下载链接

## 📱 安装测试

将新构建的deb文件安装到iOS设备：

```bash
# 通过SSH安装到设备
scp packages/*.deb root@YOUR_DEVICE_IP:/var/mobile/Documents/

# 在设备上安装
ssh root@YOUR_DEVICE_IP
su mobile -c "dpkg -i /var/mobile/Documents/*.deb"
```

## ✅ 验证安装

安装完成后，在iOS设备上：
1. 打开TikTok应用
2. 检查设置中是否出现"BHTikTok Unified"选项
3. 测试各项功能是否正常