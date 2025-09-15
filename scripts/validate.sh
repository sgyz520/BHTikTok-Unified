#!/bin/bash

# BHTikTok Unified 本地验证脚本
# 用于检查常见的编译问题

echo "🔍 BHTikTok Unified 项目验证"
echo "================================"

# 检查必需文件
echo "📁 检查必需文件..."
required_files=(
    "Makefile"
    "control" 
    "BHTikTokUnified.plist"
    "Tweak.x"
    "BHTikTokUnifiedPrefs/Entry.plist"
    "Core/BHIManager.h"
    "Core/BHIManager.m"
    "Core/BHDownload.h" 
    "Core/BHDownload.m"
    "Controllers/SettingsViewController.h"
    "Controllers/SettingsViewController.m"
    "Controllers/SecurityViewController.h"
    "Controllers/SecurityViewController.m"
)

missing_files=0
for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file - 缺失"
        missing_files=$((missing_files + 1))
    fi
done

if [ $missing_files -eq 0 ]; then
    echo "✅ 所有必需文件都存在"
else
    echo "❌ 缺失 $missing_files 个文件"
fi

echo ""

# 检查键值一致性
echo "🔑 检查键值一致性..."
spelling_errors=0

if grep -r "show_porgress_bar" . --include="*.m" --include="*.x" --include="*.h" > /dev/null 2>&1; then
    echo "❌ 发现拼写错误: show_porgress_bar"
    spelling_errors=$((spelling_errors + 1))
else
    echo "✅ show_progress_bar 拼写正确"
fi

if grep -r "copy_decription" . --include="*.m" --include="*.x" --include="*.h" > /dev/null 2>&1; then
    echo "❌ 发现拼写错误: copy_decription" 
    spelling_errors=$((spelling_errors + 1))
else
    echo "✅ copy_description 拼写正确"
fi

if [ $spelling_errors -eq 0 ]; then
    echo "✅ 所有键值拼写正确"
else
    echo "❌ 发现 $spelling_errors 个拼写错误"
fi

echo ""

# 检查@dynamic位置
echo "📍 检查@dynamic语句位置..."
dynamic_in_header=0

if grep -r "@dynamic" . --include="*.h" > /dev/null 2>&1; then
    echo "❌ 在头文件中发现@dynamic语句"
    dynamic_in_header=1
else
    echo "✅ 没有在头文件中发现@dynamic语句"
fi

echo ""

# 检查内存管理
echo "🧠 检查内存管理..."
memory_issues=0

# 检查delegate是否使用weak
if grep -A 2 -B 2 "delegate" Core/BHDownload.h | grep -q "weak"; then
    echo "✅ BHDownload delegate使用weak引用"
else
    echo "⚠️  BHDownload delegate可能没有使用weak引用"
    memory_issues=$((memory_issues + 1))
fi

echo ""

# 检查运行时安全
echo "🛡️ 检查运行时安全..."
safety_issues=0

if grep -q "exit(0)" Controllers/SecurityViewController.m; then
    echo "⚠️  发现exit(0)调用，建议使用更安全的退出方式"
    safety_issues=$((safety_issues + 1))
else
    echo "✅ 没有发现不安全的exit(0)调用"
fi

if grep -q "@try" Tweak.x; then
    echo "✅ 发现异常处理代码"
else
    echo "⚠️  建议添加更多异常处理"
    safety_issues=$((safety_issues + 1))
fi

echo ""

# 总结
echo "📊 验证总结"
echo "================================"
total_issues=$((missing_files + spelling_errors + dynamic_in_header + memory_issues + safety_issues))

if [ $total_issues -eq 0 ]; then
    echo "🎉 所有检查都通过了！项目状态良好。"
    echo "✅ 可以尝试编译"
else
    echo "⚠️  发现 $total_issues 个潜在问题，建议修复后再编译"
fi

echo ""
echo "📝 下一步建议："
echo "1. 在macOS环境中使用Theos进行编译"
echo "2. 使用GitHub Actions进行自动化构建" 
echo "3. 在真实设备上测试功能"

exit $total_issues