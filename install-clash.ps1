# ==================================================
# Clash for Windows 安装脚本（智能路径 + 自动启动）
# ==================================================

$ErrorActionPreference = "Stop"

Write-Host "🚀 开始安装 Clash for Windows..."

# ========= 判断 D 盘是否存在 =========
if (Test-Path "D:\") {
    $installDir = "D:\clash01"
    Write-Host "📂 检测到 D 盘，使用安装路径：$installDir"
} else {
    $installDir = "$env:LOCALAPPDATA\Clash"
    Write-Host "📂 未检测到 D 盘，使用安装路径：$installDir"
}

# ========= Clash 下载地址（GitHub Releases）=========
$exeUrl = "https://github.com/itspommeweb/clash-download/releases/download/v2.4.4/Clash.for.Windows_v2.4.4.exe"

# 本地 exe 路径
$exePath = Join-Path $installDir "Clash.exe"

# ========= 创建安装目录 =========
if (!(Test-Path $installDir)) {
    Write-Host "📁 创建目录 $installDir"
    New-Item -ItemType Directory -Path $installDir | Out-Null
}

# ========= 下载 Clash =========
Write-Host "⬇️ 正在下载 Clash..."
Invoke-WebRequest $exeUrl -OutFile $exePath

# ========= 创建桌面快捷方式 =========
Write-Host "📎 创建桌面快捷方式..."

$desktop = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktop "Clash.lnk"

$wsh = New-Object -ComObject WScript.Shell
$shortcut = $wsh.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $exePath
$shortcut.WorkingDirectory = $installDir
$shortcut.IconLocation = $exePath
$shortcut.Save()

# ========= 自动启动 Clash =========
Write-Host "▶️ 启动 Clash..."
Start-Process -FilePath $exePath

Write-Host ""
Write-Host "✅ 安装完成！"
Write-Host "📌 安装目录：$installDir"
Write-Host "🖥️ 桌面已生成 Clash 快捷方式"
Write-Host "🚀 Clash 已自动启动"
