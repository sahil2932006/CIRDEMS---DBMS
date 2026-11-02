$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$envFile = Join-Path $projectRoot '.env'
$pythonw = Join-Path $projectRoot '.venv\Scripts\pythonw.exe'
if (-not (Test-Path -LiteralPath $pythonw)) {
    $pythonw = Join-Path $env:LOCALAPPDATA 'Programs\Python\Python313\pythonw.exe'
}
if (-not (Test-Path -LiteralPath $envFile)) {
    throw 'The project .env file is missing.'
}
if (-not (Test-Path -LiteralPath $pythonw)) {
    throw 'Python 3.13 was not found.'
}

$envLines = Get-Content -LiteralPath $envFile
$passwordLine = $envLines | Where-Object { $_ -match '^\s*CIRDEMS_DB_PASS\s*=\s*.+\s*$' } | Select-Object -First 1
if (-not $passwordLine) { throw 'CIRDEMS_DB_PASS is missing from .env.' }

$logs = Join-Path $projectRoot 'logs'
New-Item -ItemType Directory -Path $logs -Force | Out-Null
$stdout = Join-Path $logs 'server.out.log'
$stderr = Join-Path $logs 'server.err.log'
$appPath = Join-Path $projectRoot 'app\app.py'
Start-Process -FilePath $pythonw -ArgumentList ('"' + $appPath + '"') -WorkingDirectory $projectRoot -RedirectStandardOutput $stdout -RedirectStandardError $stderr

$deadline = (Get-Date).AddSeconds(20)
$ready = $false
while ((Get-Date) -lt $deadline) {
    try {
        $client = [Net.Sockets.TcpClient]::new()
        $pending = $client.BeginConnect('127.0.0.1', 5000, $null, $null)
        if ($pending.AsyncWaitHandle.WaitOne(500) -and $client.Connected) { $ready = $true }
        $client.Close()
    } catch { }
    if ($ready) { break }
    Start-Sleep -Milliseconds 250
}
if ($ready) {
    Start-Process 'http://127.0.0.1:5000'
    Write-Host 'CIRDEMS is running at http://127.0.0.1:5000'
} else {
    Write-Host 'The app did not start. See logs\server.err.log for the error.'
}
