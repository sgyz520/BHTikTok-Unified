# BHTikTok-Unified 项目上传到GitHub脚本
# 用户: sgyz520
# 仓库: https://github.com/sgyz520/BHTikTok-Unified.git

Write-Host "🚀 开始上传 BHTikTok-Unified 项目到 GitHub..." -ForegroundColor Green
Write-Host "用户: sgyz520" -ForegroundColor Cyan
Write-Host "仓库: https://github.com/sgyz520/BHTikTok-Unified.git" -ForegroundColor Cyan
Write-Host ""

# 切换到项目目录
Set-Location "g:\程序代码\BHTikTok-Unified"
Write-Host "📁 当前目录: $(Get-Location)" -ForegroundColor Yellow

# 检查git是否已初始化
if (!(Test-Path ".git")) {
    Write-Host "🔧 初始化Git仓库..." -ForegroundColor Yellow
    git init
} else {
    Write-Host "✅ Git仓库已初始化" -ForegroundColor Green
}

# 配置git用户信息
Write-Host "👤 配置Git用户信息..." -ForegroundColor Yellow
git config user.name "sgyz520"
git config user.email "136120110@qq.com"
Write-Host "✅ Git用户信息配置完成" -ForegroundColor Green

# 检查并添加远程仓库
Write-Host "🌐 检查远程仓库配置..." -ForegroundColor Yellow
$remoteExists = git remote get-url origin 2>$null
if (!$remoteExists) {
    Write-Host "🔗 添加远程仓库..." -ForegroundColor Yellow
    git remote add origin https://github.com/sgyz520/BHTikTok-Unified.git
    Write-Host "✅ 远程仓库添加成功" -ForegroundColor Green
} else {
    Write-Host "✅ 远程仓库已存在: $remoteExists" -ForegroundColor Green
}

# 检查项目状态
Write-Host ""
Write-Host "📊 检查项目状态..." -ForegroundColor Yellow
$gitStatus = git status --porcelain
if ($gitStatus) {
    Write-Host "📝 发现未提交的更改:" -ForegroundColor Yellow
    git status --short
} else {
    Write-Host "✅ 工作目录干净，没有未提交的更改" -ForegroundColor Green
}

# 添加所有文件
Write-Host ""
Write-Host "📦 添加所有文件到暂存区..." -ForegroundColor Yellow
git add .

# 创建提交
Write-Host "💾 创建提交..." -ForegroundColor Yellow
$commitMessage = @"
修复SettingsViewController编译错误和关键bug

🔧 主要修复:
- 修复SettingsViewController.h中@dynamic语句位置错误
- 移除重复的tableView属性声明（父类已提供）
- 修复拼写错误: show_progress_bar, copy_description
- 改进BHDownload内存管理，使用weak引用
- 增强运行时安全性，添加@try-@catch异常处理
- 改善应用退出机制，避免直接使用exit(0)

📁 新增文件:
- BHTikTokUnifiedPrefs/Entry.plist (修复PreferenceLoader)
- .github/workflows/build-and-test.yml (自动化构建)
- COMPILE_FIX.md (编译问题解决方案)
- BUGFIX_REPORT.md (详细修复报告)
- scripts/validate.sh (本地验证脚本)
- .gitignore (忽略不必要文件)

✅ 编译状态: 应该可以正常编译
🧪 测试状态: 等待GitHub Actions验证
🛡️ 安全状态: 运行时安全已增强

Fixes: 编译错误, 内存泄漏, 运行时安全
"@

git commit -m $commitMessage

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 提交创建成功" -ForegroundColor Green
} else {
    Write-Host "❌ 提交创建失败" -ForegroundColor Red
    Write-Host "可能原因: 没有更改需要提交" -ForegroundColor Yellow
}

# 推送到GitHub
Write-Host ""
Write-Host "🚀 推送到GitHub..." -ForegroundColor Yellow
Write-Host "目标: https://github.com/sgyz520/BHTikTok-Unified.git" -ForegroundColor Cyan

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "🎉 上传成功！" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
    Write-Host "📊 下一步操作:" -ForegroundColor Yellow
    Write-Host "1. 查看GitHub Actions构建状态:" -ForegroundColor White
    Write-Host "   https://github.com/sgyz520/BHTikTok-Unified/actions" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "2. 查看项目主页:" -ForegroundColor White
    Write-Host "   https://github.com/sgyz520/BHTikTok-Unified" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "3. 等待自动构建完成，下载.deb安装包" -ForegroundColor White
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
    
    # 尝试打开GitHub Actions页面
    Write-Host ""
    $openBrowser = Read-Host "是否要打开GitHub Actions页面查看构建状态？(y/n)"
    if ($openBrowser -eq "y" -or $openBrowser -eq "Y") {
        Start-Process "https://github.com/sgyz520/BHTikTok-Unified/actions"
    }
} else {
    Write-Host ""
    Write-Host "❌ 推送失败！" -ForegroundColor Red
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Red
    Write-Host "可能的解决方案:" -ForegroundColor Yellow
    Write-Host "1. 检查网络连接" -ForegroundColor White
    Write-Host "2. 验证GitHub认证信息" -ForegroundColor White
    Write-Host "3. 检查远程仓库权限" -ForegroundColor White
    Write-Host ""
    Write-Host "如果需要认证，可能需要使用个人访问令牌:" -ForegroundColor Yellow
    Write-Host "https://github.com/settings/tokens" -ForegroundColor Cyan
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Red
}

Write-Host ""
Write-Host "按任意键继续..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")