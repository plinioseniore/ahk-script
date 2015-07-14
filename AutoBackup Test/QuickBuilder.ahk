; --------------------------------------
; Quick Builder AutoBackup
; --------------------------------------
;

;	This application make an export of the Quick Builder points, channels and controller 
;	automatically to work fine need on the Desktop a folder named: qdbBackup.

; Variables
qcbSrvName = SIMPKS
qcbFolder = C:\Program Files\Honeywell\Experion PKS\Client\qckbld\qckbld.exe
qcbBackup = C:\Documents and Settings\Administrator\Desktop\qdbBackup

; Lock the Keyboard and Mouse
Sleep, 10000
BlockInput On
Sleep, 1000

; Open Quick Builder 
Send, {LWINDOWN}{LWINUP}
Sleep 1000
Send, r
WinWait, Run, 
IfWinNotActive, Run, , WinActivate, Run, 
WinWaitActive, Run, 
Send, %qcbFolder% {Enter}
Sleep, 10000
Send {Enter}
WinWait, Quick Builder - \\%qcbSrvName%\QDB$\QBDatabase.qdb, 
IfWinNotActive, Quick Builder - \\%qcbSrvName%\QDB$\QBDatabase.qdb, , WinActivate, Quick Builder - \\%qcbSrvName%\QDB$\QBDatabase.qdb, 
WinWaitActive, Quick Builder - \\%qcbSrvName%\QDB$\QBDatabase.qdb, 

; Export Quick Builder Contents
Send, {ALTDOWN}f{ALTUP}e{ENTER}
WinWait, Export, 
IfWinNotActive, Export, , WinActivate, Export, 
WinWaitActive, Export, 
;MouseClick, left,  189,  56
;MouseClick, left,  189,  56
Send {DEL 150}
Sleep, 100
Send, %qcbBackup% {Enter}
Sleep, 100
WinWait Results
Sleep, 1000

; Build a sreenshot as log
Send, {ALTDOWN}{PRINTSCREEN}{ALTUP}
Send {Enter}
WinClose Quick Builder - \\%qcbSrvName%\QDB$\QBDatabase.qdb, 

; Save the screenshot
Send, {LWINDOWN}{LWINUP}
Send, r
WinWait, Run, 
IfWinNotActive, Run, , WinActivate, Run, 
WinWaitActive, Run, 
Send, mspaint{ENTER}
WinWait, untitled - Paint, 
IfWinNotActive, untitled - Paint, , WinActivate, untitled - Paint, 
WinWaitActive, untitled - Paint, 
Send, {CTRLDOWN}v{CTRLUP}
Sleep, 1000
Send {ALTDOWN}f{ALTUP}s
WinWait, Save As, 
IfWinNotActive, Save As, , WinActivate, Save As, 
WinWaitActive, Save As, 
Send, %qcbBackup%\Log.bmp{ENTER}
WinWait, Log.bmp - Paint, 
IfWinNotActive, Log.bmp - Paint, , WinActivate, Log.bmp - Paint, 
WinWaitActive, Log.bmp - Paint, 
Send, {ALTDOWN}f{ALTUP}s{ALTDOWN}f{ALTUP}x

BlockInput Off
ExitApp