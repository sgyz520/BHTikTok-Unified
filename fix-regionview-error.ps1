# 修复BHRegionInfoView编译错误的快速更新脚本
# 用户: sgyz520

Write-Host "🔧 修复 BHRegionInfoView 编译错误..." -ForegroundColor Yellow

Set-Location "g:\程序代码\BHTikTok-Unified"

# 配置git
git config user.name "sgyz520"
git config user.email "136120110@qq.com"

# 添加修复并提交
git add Views/BHRegionInfoView.m
git commit -m "修复BHRegionInfoView编译错误

🔧 修复内容:
- 移除对不存在的createTimeStr方法的调用
- TikTok的AWEAwemeModel只有createTime属性(NSNumber)，没有createTimeStr方法
- 简化时间获取逻辑，使用现有的createTime和uploadDate属性

🧪 影响:
- 解决Views/BHRegionInfoView.m:122行编译错误
- 地区信息视图功能保持正常

Fixes: #编译错误"

# 推送修复
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 编译错误修复已推送！" -ForegroundColor Green
    Write-Host "🔗 查看构建状态: https://github.com/sgyz520/BHTikTok-Unified/actions" -ForegroundColor Cyan
} else {
    Write-Host "❌ 推送失败" -ForegroundColor Red
}

Write-Host "按任意键继续..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")