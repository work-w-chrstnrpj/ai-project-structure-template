$ErrorActionPreference = "Stop"

$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

function Join-RepoPath {
    param([Parameter(Mandatory = $true, Position = 0, ValueFromRemainingArguments = $true)][string[]]$Parts)

    $path = $Parts[0]
    for ($i = 1; $i -lt $Parts.Length; $i++) {
        $path = Join-Path $path $Parts[$i]
    }
    return $path
}

function Write-Utf8NoBom {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Content
    )

    $directory = Split-Path -Parent $Path
    if ($directory -and -not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }

    $encoding = [System.Text.UTF8Encoding]::new($false)
    [System.IO.File]::WriteAllText($Path, $Content, $encoding)
}

function Quote-Yaml {
    param([Parameter(Mandatory = $true)][string]$Value)
    return "'" + ($Value -replace "'", "''") + "'"
}

function Quote-Toml {
    param([Parameter(Mandatory = $true)][string]$Value)
    $escaped = $Value.Replace('\', '\\').Replace('"', '\"')
    return '"' + $escaped + '"'
}

function Get-RoleMetadata {
    param([Parameter(Mandatory = $true)][System.IO.FileInfo]$File)

    $content = Get-Content -Raw $File.FullName
    $nameMatch = [regex]::Match($content, "(?m)^- \*\*Name:\*\*\s*(.+?)\s*$")
    $roleMatch = [regex]::Match($content, "(?m)^- \*\*Role:\*\*\s*(.+?)\s*$")
    $descriptionMatch = [regex]::Match($content, "(?m)^- \*\*Description:\*\*\s*(.+?)\s*$")

    if (-not $nameMatch.Success -or -not $descriptionMatch.Success) {
        throw "Role metadata missing in $($File.FullName)"
    }

    $title = if ($roleMatch.Success) { $roleMatch.Groups[1].Value.Trim() } else { $nameMatch.Groups[1].Value.Trim() }

    return [pscustomobject]@{
        Name = $nameMatch.Groups[1].Value.Trim()
        Title = $title
        Description = $descriptionMatch.Groups[1].Value.Trim()
        FileName = $File.Name
        Content = $content.Trim()
    }
}

function Get-SkillMetadata {
    param([Parameter(Mandatory = $true)][System.IO.DirectoryInfo]$Directory)

    $skillPath = Join-Path $Directory.FullName "SKILL.md"
    $content = Get-Content -Raw $skillPath
    $frontmatterMatch = [regex]::Match($content, "(?s)^---\s*\r?\n(.*?)\r?\n---")

    if (-not $frontmatterMatch.Success) {
        throw "Skill frontmatter missing in $skillPath"
    }

    $metadata = @{}
    foreach ($line in ($frontmatterMatch.Groups[1].Value -split "\r?\n")) {
        $match = [regex]::Match($line, "^\s*([^:#]+):\s*(.*?)\s*$")
        if ($match.Success) {
            $metadata[$match.Groups[1].Value.Trim()] = $match.Groups[2].Value.Trim().Trim('"').Trim("'")
        }
    }

    if (-not $metadata.ContainsKey("name")) {
        $metadata["name"] = $Directory.Name
    }
    if (-not $metadata.ContainsKey("description")) {
        throw "Skill description missing in $skillPath"
    }

    return [pscustomobject]@{
        Name = $metadata["name"]
        Description = $metadata["description"]
        Directory = $Directory
    }
}

function Copy-SkillDirectory {
    param(
        [Parameter(Mandatory = $true)][System.IO.DirectoryInfo]$Source,
        [Parameter(Mandatory = $true)][string]$Destination
    )

    if (-not (Test-Path $Destination)) {
        New-Item -ItemType Directory -Path $Destination | Out-Null
    }

    Get-ChildItem -Path $Source.FullName -Recurse -File | ForEach-Object {
        $relative = $_.FullName.Substring($Source.FullName.Length).TrimStart("\", "/")
        $target = Join-Path $Destination $relative
        $targetDirectory = Split-Path -Parent $target
        if ($targetDirectory -and -not (Test-Path $targetDirectory)) {
            New-Item -ItemType Directory -Path $targetDirectory | Out-Null
        }
        Copy-Item -LiteralPath $_.FullName -Destination $target -Force
    }
}

function New-AgentAdapterBody {
    param(
        [Parameter(Mandatory = $true)][object]$Role,
        [Parameter(Mandatory = $true)][string]$CanonicalPath
    )

    return @(
        "# Tool Adapter: $($Role.Title)"
        ""
        "Generated from ``$CanonicalPath``. Edit the canonical role, then run ``scripts/generate-ai-adapters.ps1``."
        ""
        $Role.Content
    ) -join "`n"
}

function Write-ClaudeAgent {
    param([Parameter(Mandatory = $true)][object]$Role)

    $canonicalPath = ".agents/roles/$($Role.FileName)"
    $body = New-AgentAdapterBody -Role $Role -CanonicalPath $canonicalPath
    $content = @(
        "---"
        "name: $($Role.Name)"
        "description: $(Quote-Yaml $Role.Description)"
        "tools:"
        "  - Read"
        "  - Glob"
        "  - Grep"
        "  - Edit"
        "  - MultiEdit"
        "  - Bash"
        "---"
        ""
        $body
        ""
    ) -join "`n"

    Write-Utf8NoBom -Path (Join-RepoPath $Root ".claude" "agents" "$($Role.Name).md") -Content $content
}

function Write-OpenCodeAgent {
    param([Parameter(Mandatory = $true)][object]$Role)

    $canonicalPath = ".agents/roles/$($Role.FileName)"
    $body = New-AgentAdapterBody -Role $Role -CanonicalPath $canonicalPath
    $content = @(
        "---"
        "name: $($Role.Name)"
        "description: $(Quote-Yaml $Role.Description)"
        "mode: subagent"
        "permission:"
        "  edit: allow"
        "  bash: ask"
        "---"
        ""
        $body
        ""
    ) -join "`n"

    Write-Utf8NoBom -Path (Join-RepoPath $Root ".opencode" "agents" "$($Role.Name).md") -Content $content
}

function Write-CodexAgent {
    param([Parameter(Mandatory = $true)][object]$Role)

    $canonicalPath = ".agents/roles/$($Role.FileName)"
    $instructions = New-AgentAdapterBody -Role $Role -CanonicalPath $canonicalPath
    if ($instructions.Contains("'''")) {
        throw "Cannot write TOML literal string for $($Role.Name); canonical role contains triple single quotes."
    }

    $content = @(
        "name = $(Quote-Toml $Role.Name)"
        "description = $(Quote-Toml $Role.Description)"
        ""
        "developer_instructions = '''"
        $instructions
        "'''"
        ""
    ) -join "`n"

    Write-Utf8NoBom -Path (Join-RepoPath $Root ".codex" "agents" "$($Role.Name).toml") -Content $content
}

function Write-CursorRule {
    param([Parameter(Mandatory = $true)][object]$Role)

    $canonicalPath = ".agents/roles/$($Role.FileName)"
    $body = New-AgentAdapterBody -Role $Role -CanonicalPath $canonicalPath
    $content = @(
        "---"
        "description: $(Quote-Yaml $Role.Description)"
        "globs: '**/*'"
        "alwaysApply: false"
        "---"
        ""
        $body
        ""
    ) -join "`n"

    Write-Utf8NoBom -Path (Join-RepoPath $Root ".cursor" "rules" "$($Role.Name).mdc") -Content $content
}

function Write-GitHubCopilotAgent {
    param([Parameter(Mandatory = $true)][object]$Role)

    $canonicalPath = ".agents/roles/$($Role.FileName)"
    $body = New-AgentAdapterBody -Role $Role -CanonicalPath $canonicalPath
    $content = @(
        "---"
        "name: $(Quote-Yaml $Role.Title)"
        "description: $(Quote-Yaml $Role.Description)"
        "tools:"
        "  - read"
        "  - edit"
        "  - terminal"
        "  - search"
        "---"
        ""
        $body
        ""
    ) -join "`n"

    Write-Utf8NoBom -Path (Join-RepoPath $Root ".github" "agents" "$($Role.Name).agent.md") -Content $content
}

$roleRoot = Join-RepoPath $Root ".agents" "roles"
$skillRoot = Join-RepoPath $Root ".agents" "skills"

$roles = Get-ChildItem -Path $roleRoot -Filter "*.md" | Sort-Object Name | ForEach-Object { Get-RoleMetadata -File $_ }
$skills = Get-ChildItem -Path $skillRoot -Directory | Where-Object {
    Test-Path (Join-Path $_.FullName "SKILL.md")
} | Sort-Object Name | ForEach-Object { Get-SkillMetadata -Directory $_ }

foreach ($role in $roles) {
    Write-ClaudeAgent -Role $role
    Write-OpenCodeAgent -Role $role
    Write-CodexAgent -Role $role
    Write-CursorRule -Role $role
    Write-GitHubCopilotAgent -Role $role
}

$skillTargets = @(
    (Join-RepoPath $Root ".claude" "skills"),
    (Join-RepoPath $Root ".opencode" "skills"),
    (Join-RepoPath $Root ".cursor" "skills"),
    (Join-RepoPath $Root ".github" "skills")
)

foreach ($skill in $skills) {
    foreach ($targetRoot in $skillTargets) {
        Copy-SkillDirectory -Source $skill.Directory -Destination (Join-Path $targetRoot $skill.Name)
    }
}

Write-Host "Generated $($roles.Count) agent adapters for Claude, OpenCode, Codex, Cursor, and GitHub Copilot."
Write-Host "Copied $($skills.Count) skills for Claude, OpenCode, Cursor, and GitHub Copilot. Codex and Antigravity use .agents/skills as canonical skill input."
