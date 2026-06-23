$ErrorActionPreference = "Stop"
& (Join-Path $PSScriptRoot "sync-ai-adapters.ps1") -Target all
