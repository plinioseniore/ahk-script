;----------------------------------
; HMI Display Builder Save As
;----------------------------------
;
;	This script build several copies of an HMI page
;
;	A file called SaveAs.txt is needed, the last line must have the name of the display to copy,
;	the others lines must have the new name for the displays.

; Variables
AbstractFolder = C:\Program Files\Honeywell\Experion PKS\Client\Abstract

IfNotExist, %AbstractFolder%\SaveAs.txt
{
	TrayTip, ahk-HMI Save As, The file SaveAs.txt have to be created `n and must contain the names for the SaveAs.,,2
	WinWait, NeverEnd
}

IfWinNotExist, HMIWeb Display Builder
{
	TrayTip, ahk-HMI Save As, Please open the HMI Disp Builder `n and load the page to SaveAs.,,2
	WinWait, NeverEnd
}

; Welcome message
TrayTip, ahk-HMI Save As, The script will start in few second `n keyboard and mouse will be locked.,,1

; Lock the Keyboard and Mouse
Sleep, 10000
BlockInput On
Sleep, 1000

WinActivate, HMIWeb Display Builder

Loop, read, %AbstractFolder%\SaveAs.txt
{
    Loop, parse, A_LoopReadLine, %A_Tab%
    {	
	HMIdisplay = %A_LoopField%
	
	Send, {ALTDOWN}fa{ALTUP}
	Sleep, 1000
	Send, %AbstractFolder%\%HMIdisplay%{ENTER}
		
	WinWait, HMIWeb Display Builder - %HMIdisplay%, 
	IfWinNotActive, HMIWeb Display Builder - %HMIdisplay%, , WinActivate, HMIWeb Display Builder - %HMIdisplay%, 
	WinWaitActive, HMIWeb Display Builder - %HMIdisplay%, 	

    }

}

BlockInput Off
ExitApp