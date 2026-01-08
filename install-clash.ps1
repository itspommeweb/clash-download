# ===============================
# Clash for Windows 安装脚本
# 来源：GitHub Releases
# ===============================

$ErrorActionPreference = "Stop"

Write-Host "🚀 开始下载 Clash for Windows..."

# 安装目录（普通用户，无需管理员）
$installDir = "$env:LOCALAPPDATA\Clash"

# 下载地址（你的 GitHub）
$exeUrl = "https://github.com/itspommeweb/clash-download/releases/download/v2.4.4/Clash.for.Windows_v2.4.4.exe"

# 本地保存路径
$exePath = Join-Path $installDir "Clash.exe"

# 创建目录
if (!(Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir | Out-Null
}

Write-Host "⬇️ 正在下载..."
Invoke-WebRequest $exeUrl -OutFile $exePath

# 创建桌面快捷方式
Write-Host "📎 创建桌面快捷方式..."
$desktop = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktop "Clash.lnk"

$wsh = New-Object -ComObject WScript.Shell
$shortcut = $wsh.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $exePath
$shortcut.Save()

Write-Host "✅ 安装完成！"
Write-Host "📌 桌面已生成 Clash 快捷方式"
