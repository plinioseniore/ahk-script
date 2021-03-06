;----------------------------------
; Fast ScreenShoots Script
;----------------------------------
;
;	This script make the screenshoots of all the HMI pages without invalid reference error
;	
;

; Variables
AbstractFolder = C:\ProgramData\Honeywell\Experion PKS\Client\Abstract
ScreenShootsFolder = C:\ProgramData\Honeywell\Experion PKS\Client\Abstract\ScreenShoots

; Position of the Station's "Command Line" for a 1920*1280 screen, adapt in case of other resolution.
X = 775	
Y = 58

; Position of the Station's "Error Line" for 1920*1280 screen, adapt in case of other resolution
XX = 600
YY = 85

; Color of the Station's "Error Line"
ErrColor = 0xE1FFFF

; Delay before check the color of the "Error Line"
DetDelay = 2000

; Welcome message
TrayTip, ahk-Screenshots, The script will start in few second `n don't use keyboard and mouse.,,1

; Lock the Keyboard and Mouse
Sleep, 10000
BlockInput On
Sleep, 1000

; Make a folder for the ScreenShoots

Send, {LWINDOWN}{LWINUP}
Sleep, 1000
Send, run{ENTER}
WinWait, Run, 
IfWinNotActive, Run, , WinActivate, Run, 
WinWaitActive, Run, 
Send, cmd{ENTER}
WinWait, C:\Windows\system32\cmd.exe, 
IfWinNotActive, C:\Windows\system32\cmd.exe, , WinActivate, C:\Windows\system32\cmd.exe, 
WinWaitActive, C:\Windows\system32\cmd.exe, 
Send, cd{SPACE}%AbstractFolder%{Enter}
Send, mkdir ScreenShoots{Enter}
Send, dir /b *.htm > list.txt{Enter}
Send, exit{Enter}
Sleep, 100

; Build the screen shoots



Send, {LWINDOWN}{LWINUP}
Sleep, 1000
Send, run{ENTER}
WinWait, Run, 
IfWinNotActive, Run, , WinActivate, Run, 
WinWaitActive, Run, 
Send, station{ENTER}
WinWait, Station - Default - Startup Page(sysStartupPage.htm), 
IfWinNotActive, Station - Default - Startup Page(sysStartupPage.htm), , WinActivate, Station - Default - Startup Page(sysStartupPage.htm), 
WinWaitActive, Station - Default - Startup Page(sysStartupPage.htm), 

Loop, read, %AbstractFolder%\list.txt
{
    Loop, parse, A_LoopReadLine, %A_Tab%
    {
        
	HMIdisplay = %A_LoopField%
	
	;MouseClick, left,  X,  Y
	;Send, {F5}
	Sleep, 1000
	Send, {F5}%HMIdisplay%{ENTER}	
	Sleep, %DetDelay%
	MouseClick, left,  1694,  110
ClrChk:	
	PixelGetColor, Color, XX, YY
	
	If Color = %ErrColor%
	{
		Sleep, 100	; Wait until the error message disapper
		Goto, ClrChk
	}
	Else
	{
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
		WinWait, Untitled - Paint, 
		IfWinNotActive, Untitled - Paint, , WinActivate, Untitled - Paint, 
		WinWaitActive, Untitled - Paint, 
		Send, {CTRLDOWN}v{CTRLUP}
		Sleep, 1000
		Send {ALTDOWN}f{ALTUP}s
		WinWait, Save As, 
		IfWinNotActive, Save As, , WinActivate, Save As, 
		WinWaitActive, Save As, 
		Send, %ScreenShootsFolder%\%HMIdisplay%.bmp
		Sleep, 100

		;Send, {TAB}j{Enter} ; Set JPEG compression
		Send, {Enter}
		WinWait, %HMIdisplay%.bmp - Paint, 
		IfWinNotActive, %HMIdisplay%.bmp - Paint, , WinActivate, %HMIdisplay%.bmp - Paint, 
		WinWaitActive, %HMIdisplay%.bmp - Paint, 
		Send, {ALTDOWN}f{ALTUP}s{ALTDOWN}f{ALTUP}x
	
		WinActivate, Station - Default
	}	

	}
}

BlockInput Off
ExitApp