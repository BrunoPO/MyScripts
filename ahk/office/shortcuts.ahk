#Persistent
toggleScreen = false
RETURN

f1::
send !{Left}
return

f3::
send !{Right}
return

!Q::
Run, screenpresso
return

!W UP::
	If (A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 300)
	{
		SetTimer, enter, off
		send {Up}
	}
	Else
	{
	  SetTimer, enter, -300
	}
return

;script vscode only
#IfWinActive, ahk_exe Code.exe
!S UP::
	If (A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 300)
	{
		SetTimer, enter, off
		send {Down}
	}
	Else
	{
	  SetTimer, enter, -300
	}
return


!2::
	send ^{f7}
return

;To any other program
#IfWinActive
!A::
send ^{;}
return

!3::
send {Media_Play_Pause}
return

!D UP::
	If (A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 300)
	{
		SetTimer, deleteChar, off
		send ^{Backspace}
	}
	Else
	{
	  SetTimer, deleteChar, -300
	}
return

!1 UP::
	If (A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 500)
	{
		SetTimer, toggleHalfScreen, off
		If (toggleScreen)
		{
			send ^#!{3}
		}
		Else
		{
			send ^#!{4}
		}
	}
	Else
	{
		toggleScreen := !toggleScreen
		SetTimer, toggleHalfScreen, -500
	}
return

deleteChar:
send {Backspace}
return

enter:
send {Enter}
return

toggleHalfScreen:
	If (toggleScreen)
	{
		;SoundBeep 500
		send ^#!{1}
	}
	Else
	{
		send ^#!{2}
	}
return

;shortcut
;f1 -> back
;f3 -> forward 
;alt + s -> tab suspender - chrome tab
;alt + a -> comment
;alt + d -> delete in two types
;alt + q -> screenpresso
;alt + w -> enter
;alt + 1 -> toggle screen
;alt + 2 -> prophet list
;alt + 3 -> stop music
