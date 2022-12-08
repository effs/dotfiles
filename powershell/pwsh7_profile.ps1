
# Setup

# scoop bucket add extras
# PowerShellGet\Install-Module posh-git -Scope CurrentUser
# PowerShellGet\Install-Module posh-sshell -Scope CurrentUser
# Add-PoshGitToProfile -AllHosts

# ssh-keygen -t ed25519 -C "fo@bar"
#
# Get-Service ssh-agent | Set-Service -StartupType Automatic -PassThru | Start-Service

$OutputEncoding = New-Object -typename System.Text.UTF8Encoding
[Console]::OutputEncoding = New-Object -typename System.Text.UTF8Encoding

# Run POSH
oh-my-posh init pwsh --config 'C:/Users/effs/.oh-my-posh.json' | Invoke-Expression

Import-Module posh-sshell
Import-Module posh-git

# Convenience functions

function Get-ChildItemUnix {
    Get-ChildItem -Force $Args[0] |
        Format-Table Mode, @{N='Owner';E={(Get-Acl $_.FullName).Owner}}, Length, LastWriteTime, @{N='Name';E={if($_.Target) {$_.Name+' -> '+$_.Target} else {$_.Name}}}
}

function New-UnixLinkSoft {
    New-Item -ItemType SymbolicLink -Path $ARGS[1] -Target $ARGS[0]
}

# Aliases
Set-Alias -Name g       -Value git
Set-Alias -Name open    -Value Invoke-Item
Set-Alias -Name ll      -Value Get-ChildItemUnix
Set-Alias -Name lns     -Value New-UnixLinkSoft
Set-Alias -Name code    -Value 'C:\Users\effs\AppData\Local\Programs\Microsoft VS Code\Code.exe'