# scripts/create-test-artifacts.ps1
param(
  [string]$JobId = "test-job-1"
)

$base = Join-Path -Path (Get-Location) -ChildPath "services\storage\artifacts"
$jobDir = Join-Path $base $JobId

# Создать папку
New-Item -ItemType Directory -Force -Path $jobDir | Out-Null

# Создать тестовые файлы
"Hello from Unfold EDU" | Out-File -Encoding utf8 (Join-Path $jobDir "hello.txt")
# Создаём простую картинку-заглушку (1x1 PNG) в base64
$pngBase64 = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII="
[System.Convert]::FromBase64String($pngBase64) | Set-Content -Encoding Byte -Path (Join-Path $jobDir "placeholder.png")
# JSON мета
'{"project":"demo","notes":"test artifacts"}' | Out-File -Encoding utf8 (Join-Path $jobDir "meta.json")

Write-Host "Created test artifacts in $jobDir"
