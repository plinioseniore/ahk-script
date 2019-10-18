; Search and Replace
;	Open Notepad++ and open a file in the FilesFolder folder (so that all next files will be opened in that folder)
;	Have a dummy search and set all the search options that are required.
;
FilesFolder = C:\Users\e463773\Desktop\0. Backoffice Modification After FAT\C12C30005\modified
;
; All file should contains the same number of entries, for each file the line number ID is used as key
; to identify the valute to search and the relevant replacement in a given file.
SearchFile = searchfile.txt
SearchString = searchstring.txt
ReplaceString = replacestring.txt
;
;
; Welcome message
TrayTip, ahk-Encoding, The script will start in few second `n don't use keyboard and mouse. Open Notepad++ open a file in the target folder and then close it.,,1

; Lock the Keyboard and Mouse
Sleep, 5000

TrayTip, dont sleep

numOfRows = 1

; Read items in SearchFile
Loop, read, %FilesFolder%\%SearchFile%
{
		SearchFile%A_index% := A_LoopReadLine
		numOfRows := numOfRows + 1
}

; Read items in SearchString
Loop, read, %FilesFolder%\%SearchString%
{
		SearchString%A_index% := A_LoopReadLine

}

; Read items in ReplaceString
Loop, read, %FilesFolder%\%ReplaceString%
{
		ReplaceString%A_index% := A_LoopReadLine
}

; Focus on Npp
WinWait, new 1 - Notepad++, 
IfWinNotActive, new 1 - Notepad++, , WinActivate, new 1 - Notepad++, 
WinWaitActive, new 1 - Notepad++, 

i = 1
while (i < numOfRows) {

	; Open the file
	FileName := % SearchFile%i%
	Send, {alt down}fo{alt up}

	WinWait, Open, 
	IfWinNotActive, Open, , WinActivate, Open, 
	WinWaitActive, Open, 
	Send, %FileName%{Enter}	
		
	WinWait, %FilesFolder%\%FileName% - Notepad++, 
	IfWinNotActive, %FilesFolder%\%FileName% - Notepad++, , WinActivate, %FilesFolder%\%FileName% - Notepad++, 
	WinWaitActive, %FilesFolder%\%FileName% - Notepad++, 

	Send, {ctrl down}h{ctrl up}
	Send, % SearchString%i%
	Send, {tab}
	Send, % ReplaceString%i%
	Send, {alt down}a{alt up}
	
	IfEqual, i, 1, Sleep, 5000	; The first run we sleep just to have time to see that search/replace is working
	
	Send, {esc}
	Send, {ctrl down}sw{ctrl up}
	
	i := i + 1
}