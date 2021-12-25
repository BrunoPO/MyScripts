#include auxiliary/joystick.ahk

;StartUpFolder - Common
;shell:common startup
;C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
;StartUpFolder - Current
;shell:startup

!3::
Send {Media_Play_Pause}
return

;show cursor
F9::
	if (flag := !flag) {
	   MouseGetPos, , , hwnd
	   Gui Cursor:+Owner%hwnd%
	   BlockInput MouseMove
	   DllCall("ShowCursor", Int,0)
	} else {
	   BlockInput MouseMoveOff
	   DllCall("ShowCursor", Int,1)
	}
return
