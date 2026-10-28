# CozyClay 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/NomaDamas/CozyClay/blob/main/README.md
# 更新日期：2026-10-28
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

node -e "const [a,b]=process.versions.node.split('.').map(Number); if(a<22||(a===22&&b<19)){console.error('需要 Node.js 22.19 或更高，当前 '+process.versions.node);process.exit(1)}"
Start-Process -FilePath "npx.cmd" -ArgumentList "-y","cozyclay" -WindowStyle Hidden -RedirectStandardOutput cozyclay.log -RedirectStandardError cozyclay.err.log
Write-Host '已启动，地址：http://127.0.0.1:5180/app/'

Write-Host ''
$url = 'http://127.0.0.1:5180/app/'
Write-Host "等待服务启动：$url"
$ready = $false
for ($i = 0; $i -lt 30; $i++) {
  try {
    Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec 3 | Out-Null
    $ready = $true
    break
  } catch {
    Start-Sleep -Seconds 2
  }
}
if (-not $ready) { throw "60 秒内未探测到 $url，请手动打开确认或查看日志" }
Write-Host '服务已就绪'
Write-Host '部署完成：浏览器打开 http://127.0.0.1:5180/app/，先搭场景再导出关键帧给视频模型'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/NomaDamas/CozyClay/blob/main/README.md'
