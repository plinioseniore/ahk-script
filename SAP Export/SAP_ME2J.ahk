ProjectRefFolder = C:\Users\e463773\Desktop\
SaveExportFolder = C:\Users\e463773\Desktop\

Loop, read, %ProjectRefFolder%Project.txt
{
    Loop, parse, A_LoopReadLine, %A_Tab%
    {
		ProjectName = %A_LoopField%
	
		; ME2J Enter into project in ALV mode

		WinWait, BRP(1)/900 SAP Easy Access, 
		IfWinNotActive, BRP(1)/900 SAP Easy Access, , WinActivate, BRP(1)/900 SAP Easy Access, 
		WinWaitActive, BRP(1)/900 SAP Easy Access,
		Sleep, 1000
		Send, me2j{ENTER}
		Sleep, 1000
		
		WinWait, BRP(1)/900 Purchasing Documents per Project, 
		IfWinNotActive, BRP(1)/900 Purchasing Documents per Project, , WinActivate, BRP(1)/900 Purchasing Documents per Project, 
		WinWaitActive, BRP(1)/900 Purchasing Documents per Project, 
		Send, {DEL 15}%ProjectName%{TAB 20}{DEL 7}ALV{F8}

		; Change layout to Delivery Schedule with All Columns
		WinWait, BRP(1)/900 Purchasing Documents per Project, 
		IfWinNotActive, BRP(1)/900 Purchasing Documents per Project, , WinActivate, BRP(1)/900 Purchasing Documents per Project, 
		WinWaitActive, BRP(1)/900 Purchasing Documents per Project,
		Sleep, 2000
		Send, {SHIFTDOWN}{F11}{SHIFTUP}
		WinWait, BRP(1)/900 Purchasing Documents per Project, 
		IfWinNotActive, BRP(1)/900 Purchasing Documents per Project, , WinActivate, BRP(1)/900 Purchasing Documents per Project, 
		WinWaitActive, BRP(1)/900 Purchasing Documents per Project, 
		Sleep, 1000


		; Add all possible columns

		;Send, {CTRLDOWN}{F8}{CTRLUP}
		;WinWait, BRP(1)/900 Change Layout, 
		;IfWinNotActive, BRP(1)/900 Change Layout, , WinActivate, BRP(1)/900 Change Layout, 
		;WinWaitActive, BRP(1)/900 Change Layout,
		;Sleep, 1000
		;Send, {CTRLDOWN}{F9}{CTRLUP}
		;Sleep, 1000
		;Send, {TAB 7}
		;Sleep, 1000
		;Send, {CTRLDOWN}a{CTRLUP}{F7}
		;Sleep, 1000
		;Send, {TAB}{TAB}{TAB}{ENTER}

		; Export Excel

		WinWait, BRP(1)/900 Purchasing Documents per Project, 
		IfWinNotActive, BRP(1)/900 Purchasing Documents per Project, , WinActivate, BRP(1)/900 Purchasing Documents per Project, 
		WinWaitActive, BRP(1)/900 Purchasing Documents per Project, 
		Sleep, 1000
		Send, {CTRLDOWN}{SHIFTDOWN}{F7}{SHIFTUP}{CTRLUP}
		Sleep, 1000
		Send, {ENTER}
		WinWait, Save As, 
		IfWinNotActive, Save As, , WinActivate, Save As, 
		WinWaitActive, Save As, 
		Sleep, 2000
		Send, {DEL 15}
		Send, %SaveExportFolder%%ProjectName%_ME2J{ENTER}
		Sleep, 2000
		WinWait, BRP(1)/900 Purchasing Documents per Project, 
		IfWinNotActive, BRP(1)/900 Purchasing Documents per Project, , WinActivate, BRP(1)/900 Purchasing Documents per Project, 
		WinWaitActive, BRP(1)/900 Purchasing Documents per Project, 
		Sleep, 2000
		Send, {SHIFTDOWN}{F3}{SHIFTUP}
		Sleep, 2000
		Send, {SHIFTDOWN}{F3}{SHIFTUP}
		WinWait, BRP(1)/900 SAP Easy Access, 
		IfWinNotActive, BRP(1)/900 SAP Easy Access, , WinActivate, BRP(1)/900 SAP Easy Access, 
		WinWaitActive, BRP(1)/900 SAP Easy Access, 

	}
}

; Welcome message
TrayTip, ahk-SAP, ME2J Export completed,,1


		