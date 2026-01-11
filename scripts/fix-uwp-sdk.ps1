- name: Fix UWP Platform Versions
  shell: pwsh
  run: |
    $target = "10.0.19041.0"

    Write-Host "Forcing UWP TargetPlatformVersion and MinVersion to $target"

    $files = Get-ChildItem -Recurse -Include *.csproj,*.props,*.targets

    foreach ($file in $files) {
      $content = Get-Content $file.FullName -Raw
      $changed = $false

      if ($content -match '<TargetPlatformVersion>') {
        $content = $content -replace '<TargetPlatformVersion>.*?</TargetPlatformVersion>', "<TargetPlatformVersion>$target</TargetPlatformVersion>"
        $changed = $true
      }

      if ($content -match '<TargetPlatformMinVersion>') {
        $content = $content -replace '<TargetPlatformMinVersion>.*?</TargetPlatformMinVersion>', "<TargetPlatformMinVersion>$target</TargetPlatformMinVersion>"
        $changed = $true
      }

      if ($changed) {
        Write-Host "Updated $($file.FullName)"
        Set-Content $file.FullName $content -Encoding UTF8
      }
    }
