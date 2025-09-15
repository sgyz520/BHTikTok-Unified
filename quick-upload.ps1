# 快速上传脚本 - BHTikTok-Unified
# sgyz520 -> https://github.com/sgyz520/BHTikTok-Unified.git

Set-Location "g:\程序代码\BHTikTok-Unified"

# 初始化和配置
if (!(Test-Path ".git")) { git init }
git config user.name "sgyz520"
git config user.email "136120110@qq.com"

# 添加远程仓库
$remoteExists = git remote get-url origin 2>$null
if (!$remoteExists) {
    git remote add origin https://github.com/sgyz520/BHTikTok-Unified.git
}

# 提交并推送
git add .
git commit -m "修复SettingsViewController编译错误和关键bug

主要修复:
- 修复编译错误和内存管理问题
- 统一键值映射
- 增强运行时安全
- 添加GitHub Actions自动构建

✅ 应该可以正常编译"

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 上传成功！查看构建状态: https://github.com/sgyz520/BHTikTok-Unified/actions" -ForegroundColor Green
} else {
    Write-Host "❌ 上传失败，请检查网络和认证" -ForegroundColor Red
}