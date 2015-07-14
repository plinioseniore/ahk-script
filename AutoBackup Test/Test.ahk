Run, Calc.exe
WinWait, Calculator
WinGetText, text  ; The window found above will be used.
MsgBox, The text is:`n%text%