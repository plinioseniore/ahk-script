; --------------------------------------
; Control Builder AutoBackup
; --------------------------------------
;

;	This application make an export of the Control Builder CMs automatically,
;	to work fine need on the Desktop a folder with "x" as first char, e.g.: xExport
;	no other folders with "x" as first char are allowed on the Desktop.

; Variables
Exportfolder = C:\Documents and Settings\Administrator\Desktop\xExport

; Lock the Keyboard and Mouse
Sleep, 10000
BlockInput On
Sleep, 1000

;Start Control Builder
Send, {LWINDOWN}{LWINUP}
Sleep 1000 
Send, r
WinWait, Run, 
IfWinNotActive, Run, , WinActivate, Run, 
WinWaitActive, Run, 
Send, contbldr{ENTER}
WinWait, Control Builder - Library - Containment, 
IfWinNotActive, Control Builder - Library - Containment, , WinActivate, Control Builder - Library - Containment, 
WinWaitActive, Control Builder - Library - Containment, 
WinMaximize

;Set the Export path in 
Sleep 10000
MouseClick, left,  10,  25
Sleep 1000
Send, e

WinWait, Export, 
IfWinNotActive, Export, , WinActivate, Export, 
WinWaitActive, Export, 


Sleep, 1000
Send, {DOWN}{ALTDOWN}b{ALTUP}
Sleep 100
WinWait, Choose folder, 
IfWinNotActive, Choose folder, , WinActivate, Choose folder, 
WinWaitActive, Choose folder, 
Sleep 1000
Send, d{BACKSPACE}{TAB}{TAB}{TAB}{TAB}d{DOWN}x{ENTER}{ENTER}{ENTER}
Sleep 1000

;Start the complete export
Sleep 10000
MouseClick, left,  10,  25
Sleep 1000
Send, e

WinWait, Export, 
IfWinNotActive, Export, , WinActivate, Export, 
WinWaitActive, Export, 
Sleep, 1000
MouseClick, left,  320,  55
WinWaitActive, Export, 
Sleep 100
Send {ALTDOWN}e{ALTUP}
Sleep, 1000

; Build a screenshot as log
Send, {ALTDOWN}{PRINTSCREEN}{ALTUP}

WinWait, Exporting Data, 
IfWinNotActive, Exporting Data, , WinActivate, Exporting Data, 
WinWaitActive, Exporting Data, 
WinWaitClose, Exporting Data

Sleep 100
WinClose, Control Builder - Library - Containment

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
Send, %Exportfolder%\Log.bmp{ENTER}
WinWait, Log.bmp - Paint, 
IfWinNotActive, Log.bmp - Paint, , WinActivate, Log.bmp - Paint, 
WinWaitActive, Log.bmp - Paint, 
Send, {ALTDOWN}f{ALTUP}s{ALTDOWN}f{ALTUP}x

BlockInput Off
ExitApp