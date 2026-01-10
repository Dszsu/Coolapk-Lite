Write-Host "Fixing UWP SDK references (full fix)..."

$old = "10.0.22621.0"
$new = "10.0.19041.0"

$files = Get-ChildItem -Recurse -Include *.csproj,*.props,*.targets

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $updated = $false

    if ($content -match $old) {
        $content = $content -replace $old, $new
        $updated = $true
    }

    if ($content -match "uap10\.0\.22621") {
        $content = $content -replace "uap10\.0\.22621", "uap10.0.19041"
        $updated = $true
    }

    if ($updated) {
        Write-Host "Patching $($file.FullName)"
        Set-Content $file.FullName $content -Encoding UTF8
    }
}

Write-Host "UWP SDK fix completed."
