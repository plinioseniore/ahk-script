; Use key stroke to change the Encoding type
;
Sleep 10000                 ; Wait to focus on the Notepad++ Windows (manually)
Loop, 100					; Loop for 100 Tabs
{
Send, {ctrl down}E{ctrl up} ; Change Encoding, build a custom shortcut using Marco->Modify Shortcut
Send, {ctrl down}S{ctrl up} ; Save
Send, {ctrl down}{PgDn down}{ctrl up}{PgDn up} ; Move to next Tab
}