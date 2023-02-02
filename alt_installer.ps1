# use irm x.gd/altscutl | iex

[System.Net.ServicePointManager]::SecurityProtocol = 'Tls12'
    # Forces TLS 1.2
Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Host @"
please use 'irm x.gd/scutl2 | iex' if you dont have scoop.
"@ -ForegroundColor Yellow

$option = Read-Host -Prompt "install additional scutl features ~500mb? (y/n)"

# apps dl

scoop.cmd install git aria2
scoop.cmd bucket add extras
scoop.cmd bucket add scutl https://github.com/47vvt/scutl
scoop.cmd install scutl

if ($option -eq "y"){
    scoop.cmd install docto ffmpeg yt-dlp everything text-grab 
}

Write-Host @"
Downloads complete! You may close the window.
Type 's' in Run to show scutl commands.
"@ -ForegroundColor Green
