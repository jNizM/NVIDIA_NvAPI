; ===============================================================================================================================
; Title .........: NvAPI GUI SetDVC
; AHK Version ...: 1.1.22.09 x64 Unicode
; Win Version ...: Windows 7 Ultimate 64-bit SP1
; Description ...: NvAPI GUI SetDVC
; Version .......: v1.02
; Modified ......: 2015.12.01-2037
; Author(s) .....: jNizM
; ===============================================================================================================================
;@Ahk2Exe-SetName NvAPI GUI SetDVC
;@Ahk2Exe-SetDescription NvAPI GUI SetDVC
;@Ahk2Exe-SetVersion v1.02
;@Ahk2Exe-SetCopyright Copyright (c) 2014-2015`, jNizM
;@Ahk2Exe-SetOrigFilename Class_NvAPI_GUI_SetDVC.ahk
; ===============================================================================================================================

; GLOBAL SETTINGS ===============================================================================================================

;#Warn
#NoEnv
#SingleInstance Force
SetBatchLines -1

#Include Class_NvAPI.ahk

; GUI ===========================================================================================================================

cnt := 0, arrCur := [], arrDef := []

while (NvAPI.EnumNvidiaDisplayHandle(cnt) != "*-7")
{
    arrCur.Insert(NvAPI.GetDVCInfoEx(cnt).currentLevel)
    arrDef.Insert(NvAPI.GetDVCInfoEx(cnt).defaultLevel)
    ++cnt
}

gbh := 93 + 27 * (cnt - 1)

Gui, Margin, 5, 5
Gui, Font, s16 w800 q4 c76B900, MS Shell Dlg 2
Gui, Add, Text, xm ym w240 0x201, % NvAPI.GPU_GetFullName()

Gui, Font, s9 w400 q1 c000000, MS Shell Dlg 2
Gui, Add, GroupBox, xm y+10 w240 h%gbh%, % "Digital Vibrance Control (DVC)"

Gui, Add, Text, xm+11 ym+60 w60 h22 0x0200, % "Display #1"
Gui, Add, Edit, x+10 yp w80 h22 0x2002 Limit3 vDVCS1, % arrCur[1]
Gui, Font, s9 w400 q1 csilver, MS Shell Dlg 2
Gui, Add, Text, x+10 yp w60 h22 0x0200, % "(0 - 100)"

loop % arrCur.MaxIndex() - 1
{
    cur := A_Index + 1
    Gui, Font, s9 w400 q1 c000000, MS Shell Dlg 2
    Gui, Add, Text, xm+11 y+5 w60 h22 0x0200, % "Display #" cur
    Gui, Add, Edit, x+10 yp w80 h22 0x2002 Limit3 vDVCS%cur%, % arrCur[cur]
    Gui, Font, s9 w400 q1 csilver, MS Shell Dlg 2
    Gui, Add, Text, x+10 yp w60 h22 0x0200, % "(0 - 100)"
}

Gui, Add, Button, xm+10 y+10 w60 gDVCSet, % "Set"
Gui, Add, Button, x+10 yp w60 gDVCReset, % "Reset"

Gui, Show, AutoSize

return

; UPDATE ========================================================================================================================

DVCSet:
    Gui, Submit, NoHide
    loop % arrCur.MaxIndex()
	{
        DVCS := DVCS%A_Index% > 100 ? 100 : DVCS%A_Index% < 0 ? 0 : DVCS%A_Index%
        NvAPI.SetDVCLevelEx(DVCS, A_Index - 1)
        GuiControl,, DVCS%A_Index%, % DVCS
	}
return

DVCReset:
    loop % arrDef.MaxIndex()
    {
        NvAPI.SetDVCLevelEx(arrDef[A_Index], A_Index - 1)
        GuiControl,, DVCS%A_Index%, % arrCur[A_Index]
    }
return

; EXIT ==========================================================================================================================

GuiClose:
GuiEscape:
ExitApp