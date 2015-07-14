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

Sleep 10000
MouseClick, left,  10,  25
Sleep 1000
Send, e

WinWait, Export, 
IfWinNotActive, Export, , WinActivate, Export, 
WinWaitActive, Export, 
MouseClick, left,  311,  247
Sleep, 100
WinWait, Choose folder, 
IfWinNotActive, Choose folder, , WinActivate, Choose folder, 
WinWaitActive, Choose folder, 
MouseClick, left,  218,  45
Sleep, 100
MouseClick, left,  114,  55
Sleep, 100
MouseClick, left,  335,  41
Sleep, 100
Send, {SHIFTDOWN}e{SHIFTUP}xport{ENTER}{ENTER}
MouseClick, left,  297,  240
Sleep, 100
WinWait, Export, 
IfWinNotActive, Export, , WinActivate, Export, 
WinWaitActive, Export, 
MouseClick, left,  301,  58
Sleep, 100
MouseClick, left,  57,  301
Sleep, 100
WinWait, Exporting Data, 
IfWinNotActive, Exporting Data, , WinActivate, Exporting Data, 
WinWaitActive, Exporting Data, 
MouseClick, left,  93,  14
Sleep, 100
ExitApp