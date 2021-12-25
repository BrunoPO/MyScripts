#include auxiliary/xinput.ahk

toggleMouse := 0
; Example: Control the vibration motors using the analog triggers of each controller.
XInput_Init()
Loop {
	Loop, 4 {
		if State := XInput_GetState(A_Index-1) {
				;LT := State.bLeftTrigger
				;RT := State.bRightTrigger
				RT := State.bRightTrigger
				BT := State.wButtons
				
				
				if BT = 772  
				{
					Send {Media_Play_Pause}
				}
				if BT = 770  
				{
					Send #d
					Sleep, 100
				}
				
				;buttons pressed together will have a specific return
				;776 means rt lt and right
				if BT = 776  
				{
					Sleep, 1000
					if BT = 776  
					{
						toggleMouse := !toggleMouse
					}
				}
				;if BT = 769  
				;{
				;	MsgBox, Cima
				;}
				
				lxval := 1
				lyval := 1
				divisor := 1000
				
				if (State.sThumbLX < 0) {
					lxval := -1
				}
				if (State.sThumbLY < 0) {
					lyval := -1
				}
				LY := State.sThumbLY
				LX := State.sThumbLX
				if toggleMouse
				{
					
					if BT = 4096  
					{
						MouseClick, left
					}
					if BT = 8192
					{
						MouseClick, right
					}
					if BT = 8192
					{
						MouseClick, right
					}
					
					if RT > 200
					{
						divisor := divisor / 4
					}
					
					if ((State.sThumbLX * lxval) > 8000 || (State.sThumbLY * lyval) > 9000)
					{
						Tooltip %LX% %LY%  %BT% %toggleMouse% %RT%
						MouseMove, State.sThumbLX/divisor, -1 * State.sThumbLY/divisor, 2, R
					}
					
				}
					

				;left down right up
				;772 770 776 769
				;XInput_SetState(A_Index-1, LT*257, RT*257)
		}
	}
	;Tooltip %LX% %LY% %BT% - %toggleMouse%
	Sleep, 100
}