$arg = $args[0]
$path = $MyInvocation.MyCommand.Path | Split-Path -Parent | %{ Join-Path $_ list.xml }
$list = ([xml](Get-Content $path)).chcp.entity

if (!$arg) {
    chcp
} elseif ($arg -match '^/([h\?]|help)$') {
    Write-Host "`nCODE: simple chcp wrapper`n"  -ForegroundColor DarkGreen
    Write-Host "usage" -ForegroundColor Magenta
    Write-Host "code key`n"
    Write-Host "available keys (defined in $path)" -ForegroundColor Magenta
    foreach ($e in $list) {
        Write-Host "- $($e.key) (code: $($e.value))"
    }
} else {
    $code =  $list | ?{ $_.key -eq $arg } | %{$_.value} 
    if ($code) {
        chcp @($code)[0]
    } else {
        Write-Host "code error: unknown key $arg"
    }
}