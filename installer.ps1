# use irm x.gd/scutl2 | iex

[System.Net.ServicePointManager]::SecurityProtocol = 'Tls12'
    # Forces TLS 1.2
Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Host @"
please use 'irm x.gd/alt_scutl | iex' if you already have scoop
"@

$option = Read-Host -Prompt "install additional scutl features ~500mb? (y/n)"

Invoke-RestMethod https://get.scoop.sh | Invoke-Expression

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
