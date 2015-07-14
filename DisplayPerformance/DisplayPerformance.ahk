;----------------------------------
; Auto DisplayPerformance
;----------------------------------
;
;	This script make the screenshoots of the display performance all the HMI pages
;	of the Experion System
;

; Variables
AbstractFolder = C:\Program Files\Honeywell\Experion PKS\Client\Abstract
DisplayPerformanceFolder = C:\Program Files\Honeywell\Experion PKS\Client\Abstract\DisplayPerformance

; Position of the Station's "Command Line" for a 1200*1024 screen, adapt in case of other resolution.
X = 695	
Y = 62

; Text to search for in Display Performance Tab
DisplaySmall = Overall performance impact: small

; Welcome message
TrayTip, ahk-ADP, The ADP will start in few second `n keyboard and mouse will be locked.,,1

; Lock the Keyboard and Mouse
Sleep, 10000
BlockInput On
Sleep, 1000

TrayTip	; Remove the traytip

; Check for the root folder
IfExist, %DisplayPerformanceFolder%
{
	TrayTip, ahk-ADP, The folder "DisplayPerformanceFolder" `n must be deleted before start.,,2
	BlockInput Off
	WinWait, NeverEnd
}	

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
Send, mkdir DisplayPerformance{Enter}
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
Send, C:\Program Files\Common Files\Honeywell\HMIWeb\Hdb.exe{ENTER}
WinWait, HMIWeb Display Builder - Display1, 
IfWinNotActive, HMIWeb Display Builder - Display1, , WinActivate, HMIWeb Display Builder - Display1, 
WinWaitActive, HMIWeb Display Builder - Display1, 
WinMaximize
Sleep, 100
Send, {ALTDOWN}fc{ALTUP}

Loop, read, %AbstractFolder%\list.txt
{
    Loop, parse, A_LoopReadLine, %A_Tab%
    {
        
	HMIdisplay = %A_LoopField%
	
	Send, {ALTDOWN}fo{ALTUP}
	Sleep, 1000
	Send, %AbstractFolder%\%HMIdisplay%{ENTER}

	WinWait, HMIWeb Display Builder - %HMIdisplay%, 
	IfWinNotActive, HMIWeb Display Builder - %HMIdisplay%, , WinActivate, HMIWeb Display Builder - %HMIdisplay%, 
	WinWaitActive, HMIWeb Display Builder - %HMIdisplay%, 	

	Sleep, 1000
	Send, {ALTDOWN}o{ALTUP}d{Enter}
	WinWait, Display Performance Analysis, 
	IfWinNotActive, Display Performance Analysis, , WinActivate, Display Performance Analysis, 
	WinWaitActive, Display Performance Analysis, 	

	WinGetText, Text  ; Capture the windows text content
	IfInString, Text, %DisplaySmall%
	{
		Send, {Enter}
		Send, {ALTDOWN}fc{ALTUP}
		WinActivate, HMIWeb Display Builder	
	}
	Else 
	{
		Send, {ALTDOWN}{PRINTSCREEN}{ALTUP}
		Sleep, 1000
		Send, {Enter}
		Sleep, 100	
		Send, {ALTDOWN}fc{ALTUP}
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
		Send, %DisplayPerformanceFolder%\%HMIdisplay%.jpg
		Sleep, 100

		Send, {TAB}j{Enter} ; Set JPEG compression
		WinWait, %HMIdisplay%.jpg - Paint, 
		IfWinNotActive, %HMIdisplay%.jpg - Paint, , WinActivate, %HMIdisplay%.jpg - Paint, 
		WinWaitActive, %HMIdisplay%.jpg - Paint, 
		Send, {ALTDOWN}f{ALTUP}s{ALTDOWN}f{ALTUP}x
	
		WinActivate, HMIWeb Display Builder
	}
	}
}


; Build a list of screenshoots made

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
Send, cd DisplayPerformance{Enter}
Send, dir /b > log.txt{Enter}
Send, exit{Enter}
Sleep, 100

BlockInput Off
ExitApp