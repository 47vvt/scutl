[System.Net.ServicePointManager]::SecurityProtocol = 'Tls12'
    # Forces TLS 1.2
Set-ExecutionPolicy Bypass -Scope Process -Force

Invoke-RestMethod https://get.scoop.sh | Invoke-Expression


# apps dl

scoop.cmd install git aria2
scoop.cmd bucket add extras
scoop.cmd bucket add scutl https://github.com/47vvt/scutl
scoop.cmd install ffmpeg yt-dlp everything scutl

Write-Host @"
Installations complete! You may close the window.
Type 's' in Run to show scutl commands.
"@ -ForegroundColor Green
