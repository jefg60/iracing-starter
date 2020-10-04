# iRacing
$iRacingdir = "C:\Program Files (x86)\iRacing\ui\"
Start-Process -WorkingDirectory $iRacingdir -FilePath "$iRacingdir\iRacingUI.exe"

# JRT
$JRTdir = 'E:\Joel Real Timing - no CUDA\'
Start-Process -WorkingDirectory $JRTdir -FilePath "$JRTdir\Timing.exe"

# CrewChief
$CCdir = "C:\Program Files (x86)\Britton IT Ltd\CrewChiefV4\"
Start-Process -WorkingDirectory $CCdir -FilePath "$CCdir\CrewChiefV4.exe"