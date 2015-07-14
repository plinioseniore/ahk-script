#Persistent
SetTimer, CheckTime, 60000 ;check time every minute
Return

CheckTime:
if (A_HOUR = 00)
 Msgbox Ecchime!
Return