Set WshShell = CreateObject("WScript.Shell" )
WshShell.CurrentDirectory = "F:\codigo"
WshShell.Run """F:\codigo\shortcut.ahk""", 0 'Must quote command if it has spaces; must escape quotes
Set WshShell = Nothing