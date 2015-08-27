; Use key stroke to change the Encoding type, it need a list.txt file that list the targets
;
;
FilesFolder = C:\Users\e463773\Desktop\Export_conns
;
;
; Welcome message
TrayTip, ahk-Encoding, The script will start in few second `n don't use keyboard and mouse. Open Notepad++ open a file in the target folder and then close it.,,1

; Lock the Keyboard and Mouse
Sleep, 15000

WinWait, new  1 - Notepad++, 
IfWinNotActive, new  1 - Notepad++, , WinActivate, new  1 - Notepad++, 
WinWaitActive, new  1 - Notepad++, 


Loop, read, %FilesFolder%\list.txt
{
    Loop, parse, A_LoopReadLine, %A_Tab%
    {
		; Open the file
		FileName = %A_LoopField%
		Send, {alt down}fo{alt up}

		WinWait, Open, 
		IfWinNotActive, Open, , WinActivate, Open, 
		WinWaitActive, Open, 
		Send, %FileName%{Enter}
		
		
		WinWait, %FilesFolder%\%FileName% - Notepad++, 
		IfWinNotActive, %FilesFolder%\%FileName% - Notepad++, , WinActivate, %FilesFolder%\%FileName% - Notepad++, 
		WinWaitActive, %FilesFolder%\%FileName% - Notepad++, 	

		
		;Send, {ctrl down}rsw{ctrl up} ; Change Encoding and close, build a custom shortcut using Marco->Modify Shortcut
		Send, {ctrl down}esw{ctrl up} ; Change Encoding and close, build a custom shortcut using Marco->Modify Shortcut
	}
}