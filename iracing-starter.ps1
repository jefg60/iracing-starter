[CmdletBinding(DefaultParametersetname="help")]
Param (
     [Parameter(ParameterSetName='help')]
     [switch]$help = $true,
     [Parameter(ParameterSetName='solorace')]
     [switch]$solorace,
     [Parameter(ParameterSetName='teamrace')]
     [switch]$teamrace,
     [Parameter(ParameterSetName='paint')]
     [switch]$paint,
     [Parameter(ParameterSetName='replay')]
     [switch]$replay
)

if ( $help ) {
    Write-Host Helping
    Exit
    }

$gimp2_exe = get-childitem "C:\Program Files\GIMP 2\bin\gimp-2.*.exe"

# $App = directory,executable (without .exe)
$iRacing = "C:\Program Files (x86)\iRacing\ui","iRacingUI"
$JoelRealTiming = "E:\Joel Real Timing - no CUDA","Timing"
$CrewChief = "C:\Program Files (x86)\Britton IT Ltd\CrewChiefV4","CrewChiefV4"
$TradingPaints = "C:\Program Files (x86)\Rhinode LLC\Trading Paints","Trading Paints"
$OBS_Studio = "C:\Program Files\obs-studio\bin\64bit","obs64"
$GIMP2 = "C:\Program Files\GIMP 2\bin",$gimp2_exe[0].BaseName

$solorace_apps = $iRacing,$JoelRealTiming,$OBS_Studio,$CrewChief,$TradingPaints
$runlist = $solorace_apps

function start-app {
    param (
        [Parameter(Mandatory=$true)]
        [string]$workingdir,
        [Parameter(Mandatory=$true)]
        [string]$executable
    )
    Start-Process -WorkingDirectory $workingdir -FilePath "$workingdir\$executable.exe"
}

ForEach ($app in $runlist) {
    Write-Host "Checking for $app"
    $alreadyrunning = Get-Process $app[1] -ErrorAction SilentlyContinue
    if ( -Not $alreadyrunning ) {
        Write-Host "Starting $app"
        start-app -workingdir $app[0] -executable $app[1]
    }
}