;----------------------------------
; Backup the ERDB Database
;----------------------------------

;	This application make an export of the ERDB database automatically,
;	to work fine need on the Desktop a folder with "y" as first char, e.g.: yERDB
;	no other folders with "y" as first char are allowed on the Desktop.

; Variables
ERDBfolder = C:\Documents and Settings\Administrator\Desktop\yERDB

; Lock the Keyboard and Mouse
Sleep, 10000
BlockInput On
Sleep, 1000

Sleep 10000
Send, {LWINDOWN}{LWINUP}
Sleep 1000
Send, r
WinWait, Run, 
IfWinNotActive, Run, , WinActivate, Run, 
WinWaitActive, Run, 
Send, mmc.exe{ENTER}
WinWait, Console1, 
IfWinNotActive, Console1, , WinActivate, Console1, 
WinWaitActive, Console1, 

Send, {ALTDOWN}f{ALTUP}
Sleep, 100
Send, {ALTDOWN}fo{ALTUP}
WinWait, Open, 
IfWinNotActive, Open, , WinActivate, Open, 
WinWaitActive, Open, 
Send {DEL 150}
Send, C:\Program Files\Honeywell\Experion PKS\Engineering Tools\system\bin\DbAdmin.msc {Enter}
WinWait,DbAdmin, 
IfWinNotActive, DbAdmin, , WinActivate, DbAdmin, 
WinWaitActive, DbAdmin,
WinMaximize, DbAdmin, 
Sleep 100,
Send {ALTDOWN}wt{ALTUP}


Send, d
Sleep 100
Send, {RIGHT}
Sleep 100
Send, s,
Sleep 100
Send, {RIGHT}
Sleep, 100
Send, eee
Sleep, 1000
MouseClick, left,  873,  233
Sleep, 1000
WinWait, Select and/or Create a folder to store backup set:, 
IfWinNotActive, Select and/or Create a folder to store backup set:, , WinActivate, Select and/or Create a folder to store backup set:, 
WinWaitActive, Select and/or Create a folder to store backup set:, 

Send, {TAB}{TAB}{TAB}{DOWN}ddy{ENTER}
Sleep, 1000
Send, {ENTER}
Sleep, 1000
Send, {ENTER}
Sleep, 1000

WinWait, AdminFuncs, 
IfWinNotActive, AdminFuncs, , WinActivate, AdminFuncs, 
WinWaitActive, AdminFuncs,
Sleep, 100
Send, {ALTDOWN}{PRINTSCREEN}{ALTUP}
Sleep, 1000
Send {Enter}
WinClose, DbAdmin
Sleep, 100

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
Send, %ERDBfolder%\Log.bmp{ENTER}
WinWait, Log.bmp - Paint, 
IfWinNotActive, Log.bmp - Paint, , WinActivate, Log.bmp - Paint, 
WinWaitActive, Log.bmp - Paint, 
Send, {ALTDOWN}f{ALTUP}s{ALTDOWN}f{ALTUP}x


BlockInput Off
ExitApp