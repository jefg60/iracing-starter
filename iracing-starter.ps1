Param (
     [Parameter(ParameterSetName='solorace')]
     [switch]$solorace,
     [Parameter(ParameterSetName='teamrace')]
     [switch]$teamrace,
     [Parameter(ParameterSetName='paint')]
     [switch]$paint,
     [Parameter(ParameterSetName='replay')]
     [switch]$replay,
     [Parameter(ParameterSetName='stopeverything')]
     [switch]$stopeverything
)

$gimp2_exe = get-childitem "C:\Program Files\GIMP 2\bin\gimp-2.*.exe"

# $App = directory,executable (without .exe)
$iRacing = "C:\Program Files (x86)\iRacing\ui","iRacingUI"
$JoelRealTiming = "E:\Joel Real Timing - no CUDA","Timing"
$CrewChief = "C:\Program Files (x86)\Britton IT Ltd\CrewChiefV4","CrewChiefV4"
$TradingPaints = "C:\Program Files (x86)\Rhinode LLC\Trading Paints","Trading Paints"
$OBS_Studio = "C:\Program Files\obs-studio\bin\64bit","obs64"
$GIMP2 = $gimp2_exe.DirectoryName,$gimp2_exe[0].BaseName

# Apps to start for each scenario
$solorace_apps = $iRacing,$JoelRealTiming,$OBS_Studio,$CrewChief,$TradingPaints
$teamrace_apps = $solorace_apps
$paint_apps = $iRacing,$GIMP2
$replay_apps = $solorace_apps
$all_apps = $solorace_apps + $paint_apps

function start-app {
    param (
        [Parameter(Mandatory=$true)]
        [string]$workingdir,
        [Parameter(Mandatory=$true)]
        [string]$executable,
        [string]$extension = 'exe'
    )
    Start-Process -WorkingDirectory $workingdir -FilePath "$workingdir\$executable.$extension"
}

function stop-app {
    param (
        [Parameter(Mandatory=$true)]
        [string]$appname
    )
    $app_process = Get-Process $appname -ErrorAction SilentlyContinue
    if ( $app_process ) { Stop-Process -Name $appname }
}

if ( $solorace ) {
    $runlist = $solorace_apps
    $stoplist = ,$GIMP2 # comma to force an array of one sub-array
}
if ( $teamrace ) {
    $runlist = $teamrace_apps
    $stoplist = ,$GIMP2 # comma to force an array of one sub-array
}
if ( $replay ) {
    $runlist = $replay_apps
    $stoplist = ,$GIMP2 # comma to force an array of one sub-array
}
if ( $paint ) {
    $runlist = $paint_apps
    $stoplist = $TradingPaints,$JoelRealTiming,$OBS_Studio,$CrewChief
}
if ($stopeverything ) {
    $runlist = $false
    $stoplist = $all_apps
}

if ( $stoplist ) {
    ForEach ($app in $stoplist ) {
        Write-Host "Stopping" $app[1]
        stop-app $app[1]
    }
}

if ( $runlist ) {
    ForEach ($app in $runlist) {
        Write-Host "Checking if" $app[1] "is running"
        $alreadyrunning = Get-Process $app[1] -ErrorAction SilentlyContinue
        if ( -Not $alreadyrunning ) {
            Write-Host "Starting $app"
            start-app -workingdir $app[0] -executable $app[1]
        }
    }
}
