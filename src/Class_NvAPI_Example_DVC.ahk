; ===========================================================================================================================================================================

/*
	AutoHotkey wrapper for NVIDIA NvAPI (Example Script: DVC - Digital Vibrance)

	Author ....: jNizM
	Released ..: 2014-12-29
	Modified ..: 2020-09-30
	License ...: MIT
	GitHub ....: https://github.com/jNizM/AHK_NVIDIA_NvAPI
	Forum .....: https://www.autohotkey.com/boards/viewtopic.php?t=95112
*/

; SCRIPT DIRECTIVES =========================================================================================================================================================

#Requires AutoHotkey v2.0-


; INITIAL ===================================================================================================================================================================

Enum := 0, Displays := []
while (NvAPI.EnumNvidiaDisplayHandle(Enum) != "NVAPI_END_ENUMERATION")
{
	Display := Map()
	DVC := NvAPI.GetDVCInfoEx(Enum)
	Display["current"] := DVC["currentLevel"]
	Display["min"]     := DVC["minLevel"]
	Display["max"]     := DVC["maxLevel"]
	Display["default"] := DVC["defaultLevel"]
	Displays.Push(Display)
	Enum++
}


; GUI =======================================================================================================================================================================

hhr1 := DllCall("gdi32\CreateBitmap", "int", 1, "int", 2, "int", 0x1, "int", 32, "int64*", 0x7f5a5a5a7fa5a5a5, "ptr")

Main := Gui()
Main.MarginX := 10
Main.MarginY := 10

Main.SetFont("s16 w700 c76B900", "Segoe UI")
Main.AddText("xm ym w250", "Digital Vibrance Control")

Main.SetFont()
Main.SetFont("s10 w400", "Segoe UI")

loop Displays.Length
{
	Main.AddText("xm y+" (A_Index = 1 ? 15 : 5) " w80 h25 0x200", "Display #" A_Index)
	Main.AddEdit("x+8 yp w60 Limit3 0x2002 vEdt" A_Index, Displays[A_Index]["current"])
	Main.AddText("x+8 yp w60 h25 0x200", "(" Displays[A_Index]["min"] " - " Displays[A_Index]["max"] ")")
}

Main.AddPicture("xm y+9 w250 h1 BackgroundTrans", "HBITMAP:*" hhr1)
Main.AddButton("xm-1 y+9 w80", "Set").OnEvent("Click", Click_Set)
Main.AddButton("x+9 yp w80", "Reset").OnEvent("Click", Click_Reset)


Main.OnEvent("Close", Gui_Close)
Main.Show()


; WINDOW EVENTS =================================================================================================================

Gui_Close(thisGui)
{
	if (hhr1)
		DllCall("gdi32\DeleteObject", "ptr", hhr1)
	ExitApp
}


; CONTROL EVENTS ================================================================================================================

Click_Reset(*)
{
	loop Displays.Length
	{
		NvAPI.SetDVCLevelEx(Displays[A_Index]["default"], A_Index - 1)
		Main["Edt" A_Index].Text := Displays[A_Index]["default"]
	}
}


Click_Set(*)
{
	loop Displays.Length
	{
		if (Main["Edt" A_Index].Text != Displays[A_Index]["current"])
		{
			if (Main["Edt" A_Index].Text < Displays[A_Index]["min"]) || (Main["Edt" A_Index].Text > Displays[A_Index]["max"])
			{
				MsgBox("DVC should be within the range of min [" Displays[A_Index]["min"] "] and max [" Displays[A_Index]["max"] "].")
			}
			else
			{
				NvAPI.SetDVCLevelEx(Main["Edt" A_Index].Text, A_Index - 1)
			}
		}
	}
}


; INCLUDES ==================================================================================================================================================================

#Include Class_NvAPI.ahk


; ===========================================================================================================================================================================