Write-Host "Fixing UWP TargetPlatformVersion..."

$old = "10.0.22621.0"
$new = "10.0.19041.0"

$files = Get-ChildItem -Recurse -Include *.csproj,*.props,*.targets

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match $old) {
        Write-Host "Updating $($file.FullName)"
        $content = $content -replace $old, $new
        Set-Content $file.FullName $content -Encoding UTF8
    }
}

Write-Host "Done."
