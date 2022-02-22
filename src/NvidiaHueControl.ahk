; ===========================================================================================================================================================================

/*
	Nvidia Hue Control (written in AutoHotkey)
	Author ....: jNizM
	Released ..: 2022-02-22
	Modified ..: 2022-02-22
	License ...: MIT
	GitHub ....: https://github.com/jNizM/NVIDIA_NvAPI
	Forum .....: https://www.autohotkey.com/boards/viewtopic.php?t=95112
*/


; COMPILER DIRECTIVES =======================================================================================================================================================

;@Ahk2Exe-SetDescription    Nvidia Hue Control (x64)
;@Ahk2Exe-SetFileVersion    0.1
;@Ahk2Exe-SetProductName    Nvidia Hue Control
;@Ahk2Exe-SetProductVersion 2.0-beta.3
;@Ahk2Exe-SetCopyright      (c) 2022-2022 jNizM
;@Ahk2Exe-SetLanguage       0x0407


; SCRIPT DIRECTIVES =========================================================================================================================================================

#Requires AutoHotkey v2.0-



; RUN =======================================================================================================================================================================

NvAPI_Hue()



; NvAPI_Hue =================================================================================================================================================================

NvAPI_Hue()
{
	App := Map("name", "Nvidia Hue Control", "version", "0.1", "release", "2022-02-22", "author", "jNizM", "licence", "MIT")

	; INIT ==============================================================================================================================================================

	Enum := 0, Displays := Map()
	while !(InStr(NvAPI.EnumNvidiaDisplayHandle(Enum), "Error"))
	{
		HUE := NvAPI.GetHUEInfo(Enum)
		Display := Map()
		Display["current"] := HUE["currentHueAngle"]
		Display["default"] := HUE["defaultHueAngle"]
		Displays[A_Index]   := Display
		Enum++
	}


	; GUI ===============================================================================================================================================================

	Main := Gui(, App["name"])
	Main.MarginX := 10
	Main.MarginY := 10
	Main.SetFont("s16 w700 c76B900", "Segoe UI")
	Main.AddText("xm ym w250", "NVIDIA Hue Control")
	Main.SetFont()
	Main.SetFont("s10 w400", "Segoe UI")
	for i in Displays
	{
		Main.AddText("xm y+" (A_Index = 1 ? 15 : 3) " w80 h25 0x200", "Display #" A_Index)
		Main.AddSlider("x+8 yp w200 AltSubmit Range0-360 ToolTip vSL" A_Index, Displays[i]["current"]).OnEvent("Change", ChangeHue)
	}
	Main.AddButton("xm-1 y+9 w80", "Reset").OnEvent("Click", ResetHue)

	Main.OnEvent("Close", (*) => ExitApp)
	Main.Show("AutoSize")


	; WINDOW EVENTS =====================================================================================================================================================

	ChangeHue(GuiCtrlObj, *)
	{
		NvAPI.SetHUEAngle(GuiCtrlObj.Value, SubStr(GuiCtrlObj.Name, -1) - 1)
	}

	ResetHue(*)
	{
		for i in Displays
		{
			NvAPI.SetHUEAngle(Displays[i]["default"], A_Index - 1)
			Main["SL" A_Index].Value := Displays[i]["default"]
		}
	}
}


; INCLUDES ==================================================================================================================================================================

#Include Class_NvAPI.ahk


; ===========================================================================================================================================================================