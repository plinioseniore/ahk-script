;----------------------------------
; Auto ScreenShoots
;----------------------------------
;
;	This script make the screenshoots of all the HMI pages
;	of the Experion System
;

; Variables
AbstractFolder = C:\Program Files\Honeywell\Experion PKS\Client\Abstract
ScreenShootsFolder = C:\Program Files\Honeywell\Experion PKS\Client\Abstract\ScreenShoots

; Position of the Station's "Command Line" for a 1200*1024 screen, adapt in case of other resolution.
X = 695	
Y = 62

; Lock the Keyboard and Mouse
Sleep, 10000
BlockInput On
Sleep, 1000

; Make a folder for the ScreenShoots

Send, {LWINDOWN}{LWINUP}
Sleep, 1000
Send, r
WinWait, Run, 
IfWinNotActive, Run, , WinActivate, Run, 
WinWaitActive, Run, 
Send, cmd{ENTER}
WinWait, C:\WINDOWS\system32\cmd.exe, 
IfWinNotActive, C:\WINDOWS\system32\cmd.exe, , WinActivate, C:\WINDOWS\system32\cmd.exe, 
WinWaitActive, C:\WINDOWS\system32\cmd.exe, 
Send, cd{SPACE}%AbstractFolder%{Enter}
Send, mkdir ScreenShoots{Enter}
Send, dir /b *.htm > list.txt{Enter}
Send, exit{Enter}
Sleep, 100

; Build the screen shoots



Send, {LWINDOWN}{LWINUP}
Sleep, 1000
Send, r
WinWait, Run, 
IfWinNotActive, Run, , WinActivate, Run, 
WinWaitActive, Run, 
Send, station{ENTER}
WinWait, Station - Default - sysStartupPage.htm(sysStartupPage.htm), 
IfWinNotActive, Station - Default - sysStartupPage.htm(sysStartupPage.htm), , WinActivate, Station - Default - sysStartupPage.htm(sysStartupPage.htm), 
WinWaitActive, Station - Default - sysStartupPage.htm(sysStartupPage.htm), 

Loop, read, %AbstractFolder%\list.txt
{
    Loop, parse, A_LoopReadLine, %A_Tab%
    {
        
	HMIdisplay = %A_LoopField%
	
	MouseClick, left,  X,  Y
	Sleep, 1000
	Send, %HMIdisplay%{ENTER}
	Sleep, 5000
	Send, {PRINTSCREEN}{LWINDOWN}{LWINUP}
	Sleep, 1000
	WinMinimizeAll

	; Save the file with Paint

	Send, {LWINDOWN}r{LWINUP}
	Sleep, 1000
	;Send, r
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
	Send, %ScreenShootsFolder%\%HMIdisplay%.jpg
	Sleep, 100

	Send, {TAB}j{Enter} ; Set JPEG compression
	WinWait, %HMIdisplay%.jpg - Paint, 
	IfWinNotActive, %HMIdisplay%.jpg - Paint, , WinActivate, %HMIdisplay%.jpg - Paint, 
	WinWaitActive, %HMIdisplay%.jpg - Paint, 
	Send, {ALTDOWN}f{ALTUP}s{ALTDOWN}f{ALTUP}x
	
	WinActivate, Station - Default

	}
}

BlockInput Off
ExitApp