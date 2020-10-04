# $App = directory,executable,
$iRacing = "C:\Program Files (x86)\iRacing\ui","iRacingUI.exe"
$JoelRealTiming = "E:\Joel Real Timing - no CUDA","Timing.exe"
$CrewChief = "C:\Program Files (x86)\Britton IT Ltd\CrewChiefV4","CrewChiefV4.exe"
$TradingPaints = "C:\Program Files (x86)\Rhinode LLC\Trading Paints","Trading Paints.exe"
$OBS_Studio = "C:\Program Files\obs-studio\bin\64bit","obs64.exe"

$solorace = $iRacing,$JoelRealTiming,$OBS_Studio,$CrewChief,$TradingPaints

function start-app {
    param (
        [Parameter(Mandatory=$true)]
        [string]$workingdir,
        [Parameter(Mandatory=$true)]
        [string]$executable
    )
    Start-Process -WorkingDirectory $workingdir -FilePath "$workingdir\$executable"
}

ForEach ($app in $solorace) {
    Write-Host "Checking for $app"
    $alreadyrunning = Get-Process $app[1].Split(".")[0] -ErrorAction SilentlyContinue
    if ( -Not $alreadyrunning ) {
        Write-Host "Starting $app"
        start-app -workingdir $app[0] -executable $app[1]
    }
}