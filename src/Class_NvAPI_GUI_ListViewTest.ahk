; ===============================================================================================================================
; Title .........: NvAPI GUI ListView Test
; AHK Version ...: 1.1.17.01 x64 Unicode
; Win Version ...: Windows 7 Professional x64 SP1
; Description ...: NvAPI GUI ListView Test
; Version .......: v1.01
; Modified ......: 2014.12.28-1327
; Author(s) .....: jNizM
; ===============================================================================================================================
;@Ahk2Exe-SetName NvAPI GUI ListView Test
;@Ahk2Exe-SetDescription NvAPI GUI ListView Test
;@Ahk2Exe-SetVersion v1.00
;@Ahk2Exe-SetCopyright Copyright (c) 2014-2014`, jNizM
;@Ahk2Exe-SetOrigFilename Class_NvAPI_GUI_ListViewTest.ahk
; ===============================================================================================================================

; GLOBAL SETTINGS ===============================================================================================================

;#Warn
#NoEnv
#SingleInstance Force
SetBatchLines -1
#Include Class_NvAPI.ahk

; TEST SCRIPT ===================================================================================================================

OnExit, reset
NVIDIA := new NvAPI()

cENDH := cENUADH := 0

while (NVIDIA.EnumNvidiaDisplayHandle(cENDH) != "*-7")
    ++cENDH
cENDH := cENDH = 0 ? 1 : cENDH
while (NVIDIA.EnumNvidiaUnAttachedDisplayHandle(cENUADH) != "*-7")
    ++cENUADH
cENUADH := cENUADH = 0 ? 1 : cENUADH


Gui, Margin, 5, 5
Gui, Add, ListView, xm ym w600 h400, Function|Return
LV_ModifyCol(1, 330)
LV_ModifyCol(2, 220)

LV_Add( "", "", "")
LV_Add( "", "DISP_GetGDIPrimaryDisplayId()",                                    NVIDIA.DISP_GetGDIPrimaryDisplayId() )
LV_Add( "", "", "")
loop % cENDH
    LV_Add( "", "EnumNvidiaDisplayHandle(" A_Index - 1 ")",                     NVIDIA.EnumNvidiaDisplayHandle(A_Index - 1) )
LV_Add( "", "", "")
loop % cENUADH
    LV_Add( "", "EnumNvidiaUnAttachedDisplayHandle(" A_Index - 1 ")",           NVIDIA.EnumNvidiaUnAttachedDisplayHandle(A_Index - 1) )
LV_Add( "", "", "")
LV_Add( "", "EnumPhysicalGPUs().1",                                             NVIDIA.EnumPhysicalGPUs().1 )
LV_Add( "", "", "")
loop % cENDH
    LV_Add( "", "GetAssociatedDisplayOutputId(" A_Index - 1 ")",                NVIDIA.GetAssociatedDisplayOutputId(A_Index - 1) )
LV_Add( "", "", "")
loop % cENDH
    LV_Add( "", "GetAssociatedNvidiaDisplayHandle(" A_Index - 1 ")",            NVIDIA.GetAssociatedNvidiaDisplayHandle(A_Index - 1) )
LV_Add( "", "", "")
loop % cENDH
    LV_Add( "", "GetAssociatedNvidiaDisplayName(" A_Index - 1 ")",              NVIDIA.GetAssociatedNvidiaDisplayName(A_Index - 1) )
LV_Add( "", "", "")
LV_Add( "", "GetDisplayDriverMemoryInfo().dedicatedVideoMemory",                NVIDIA.GetDisplayDriverMemoryInfo().dedicatedVideoMemory )
LV_Add( "", "GetDisplayDriverMemoryInfo().availableDedicatedVideoMemory",       NVIDIA.GetDisplayDriverMemoryInfo().availableDedicatedVideoMemory )
LV_Add( "", "GetDisplayDriverMemoryInfo().systemVideoMemory",                   NVIDIA.GetDisplayDriverMemoryInfo().systemVideoMemory )
LV_Add( "", "GetDisplayDriverMemoryInfo().sharedSystemMemory",                  NVIDIA.GetDisplayDriverMemoryInfo().sharedSystemMemory )
LV_Add( "", "GetDisplayDriverMemoryInfo().curAvailableDedicatedVideoMemory",    NVIDIA.GetDisplayDriverMemoryInfo().curAvailableDedicatedVideoMemory )
LV_Add( "", "", "")
LV_Add( "", "GetDisplayDriverVersion().drvVersion",                             NVIDIA.GetDisplayDriverVersion().drvVersion )
LV_Add( "", "GetDisplayDriverVersion().bldChangeListNum",                       NVIDIA.GetDisplayDriverVersion().bldChangeListNum )
LV_Add( "", "GetDisplayDriverVersion().szBuildBranchString",                    NVIDIA.GetDisplayDriverVersion().szBuildBranchString )
LV_Add( "", "GetDisplayDriverVersion().szAdapterString",                        NVIDIA.GetDisplayDriverVersion().szAdapterString )
LV_Add( "", "", "")
LV_Add( "", "GetDVCInfo().currentLevel",                                        NVIDIA.GetDVCInfo().currentLevel )
LV_Add( "", "GetDVCInfo().minLevel",                                            NVIDIA.GetDVCInfo().minLevel )
LV_Add( "", "GetDVCInfo().maxLevel",                                            NVIDIA.GetDVCInfo().maxLevel )
LV_Add( "", "", "")
loop % cENDH
{
    LV_Add( "", "GetDVCInfoEx(" A_Index - 1 ").currentLevel",                   NVIDIA.GetDVCInfoEx(A_Index - 1).currentLevel )
    LV_Add( "", "GetDVCInfoEx(" A_Index - 1 ").minLevel",                       NVIDIA.GetDVCInfoEx(A_Index - 1).minLevel )
    LV_Add( "", "GetDVCInfoEx(" A_Index - 1 ").maxLevel",                       NVIDIA.GetDVCInfoEx(A_Index - 1).maxLevel )
    LV_Add( "", "GetDVCInfoEx(" A_Index - 1 ").defaultLevel",                   NVIDIA.GetDVCInfoEx(A_Index - 1).defaultLevel )
}
LV_Add( "", "", "")
LV_Add( "", "GetInterfaceVersionString()",                                      NVIDIA.GetInterfaceVersionString() )
LV_Add( "", "", "")
loop % cENUADH
    LV_Add( "", "GetUnAttachedAssociatedDisplayName(" A_Index - 1 ")",          NVIDIA.GetUnAttachedAssociatedDisplayName(A_Index - 1) )
LV_Add( "", "", "")
LV_Add( "", "GetVBlankCounter()",                                               NVIDIA.GetVBlankCounter() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetAGPAperture()",                                             NVIDIA.GPU_GetAGPAperture() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetAllClockFrequencies().Type",                                NVIDIA.GPU_GetAllClockFrequencies().Type )
LV_Add( "", "GPU_GetAllClockFrequencies().GRAPHICS.bIsPresent",                 NVIDIA.GPU_GetAllClockFrequencies().GRAPHICS.bIsPresent )
LV_Add( "", "GPU_GetAllClockFrequencies().GRAPHICS.frequency",                  NVIDIA.GPU_GetAllClockFrequencies().GRAPHICS.frequency )
LV_Add( "", "GPU_GetAllClockFrequencies().MEMORY.bIsPresent",                   NVIDIA.GPU_GetAllClockFrequencies().MEMORY.bIsPresent )
LV_Add( "", "GPU_GetAllClockFrequencies().MEMORY.frequency",                    NVIDIA.GPU_GetAllClockFrequencies().MEMORY.frequency )
LV_Add( "", "GPU_GetAllClockFrequencies().PROCESSOR.bIsPresent",                NVIDIA.GPU_GetAllClockFrequencies().PROCESSOR.bIsPresent )
LV_Add( "", "GPU_GetAllClockFrequencies().PROCESSOR.frequency",                 NVIDIA.GPU_GetAllClockFrequencies().PROCESSOR.frequency )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetBoardInfo()",                                               NVIDIA.GPU_GetBoardInfo() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetBusId()",                                                   NVIDIA.GPU_GetBusId() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetBusSlotId()",                                               NVIDIA.GPU_GetBusSlotId() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetBusType()",                                                 NVIDIA.GPU_GetBusType() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetCoolerSettings().count",                                    NVIDIA.GPU_GetCoolerSettings().count )
LV_Add( "", "GPU_GetCoolerSettings().1.type",                                   NVIDIA.GPU_GetCoolerSettings().1.type )
LV_Add( "", "GPU_GetCoolerSettings().1.controller",                             NVIDIA.GPU_GetCoolerSettings().1.controller )
LV_Add( "", "GPU_GetCoolerSettings().1.defaultMinLevel",                        NVIDIA.GPU_GetCoolerSettings().1.defaultMinLevel )
LV_Add( "", "GPU_GetCoolerSettings().1.defaultMaxLevel",                        NVIDIA.GPU_GetCoolerSettings().1.defaultMaxLevel )
LV_Add( "", "GPU_GetCoolerSettings().1.currentMinLevel",                        NVIDIA.GPU_GetCoolerSettings().1.currentMinLevel )
LV_Add( "", "GPU_GetCoolerSettings().1.currentMaxLevel",                        NVIDIA.GPU_GetCoolerSettings().1.currentMaxLevel )
LV_Add( "", "GPU_GetCoolerSettings().1.currentLevel",                           NVIDIA.GPU_GetCoolerSettings().1.currentLevel )
LV_Add( "", "GPU_GetCoolerSettings().1.defaultPolicy",                          NVIDIA.GPU_GetCoolerSettings().1.defaultPolicy )
LV_Add( "", "GPU_GetCoolerSettings().1.currentPolicy",                          NVIDIA.GPU_GetCoolerSettings().1.currentPolicy )
LV_Add( "", "GPU_GetCoolerSettings().1.target",                                 NVIDIA.GPU_GetCoolerSettings().1.target )
LV_Add( "", "GPU_GetCoolerSettings().1.controlType",                            NVIDIA.GPU_GetCoolerSettings().1.controlType )
LV_Add( "", "GPU_GetCoolerSettings().1.active",                                 NVIDIA.GPU_GetCoolerSettings().1.active )
LV_Add( "", "GPU_GetCoolerSettings().1.speedRPM",                               NVIDIA.GPU_GetCoolerSettings().1.speedRPM )
LV_Add( "", "GPU_GetCoolerSettings().1.bSupported",                             NVIDIA.GPU_GetCoolerSettings().1.bSupported )
LV_Add( "", "GPU_GetCoolerSettings().1.maxSpeedRPM",                            NVIDIA.GPU_GetCoolerSettings().1.maxSpeedRPM )
LV_Add( "", "GPU_GetCoolerSettings().1.minSpeedRPM",                            NVIDIA.GPU_GetCoolerSettings().1.minSpeedRPM )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetCurrentAGPRate()",                                          NVIDIA.GPU_GetCurrentAGPRate() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetCurrentPCIEDownstreamWidth()",                              NVIDIA.GPU_GetCurrentPCIEDownstreamWidth() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetCurrentPstate()",                                           NVIDIA.GPU_GetCurrentPstate() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().Enabled",                            NVIDIA.GPU_GetDynamicPstatesInfoEx().Enabled )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().GPU.bIsPresent",                     NVIDIA.GPU_GetDynamicPstatesInfoEx().GPU.bIsPresent )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().GPU.percentage",                     NVIDIA.GPU_GetDynamicPstatesInfoEx().GPU.percentage )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().FB.bIsPresent",                      NVIDIA.GPU_GetDynamicPstatesInfoEx().FB.bIsPresent )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().FB.percentage",                      NVIDIA.GPU_GetDynamicPstatesInfoEx().FB.percentage )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().VID.bIsPresent",                     NVIDIA.GPU_GetDynamicPstatesInfoEx().VID.bIsPresent )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().VID.percentage",                     NVIDIA.GPU_GetDynamicPstatesInfoEx().VID.percentage )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().BUS.bIsPresent",                     NVIDIA.GPU_GetDynamicPstatesInfoEx().BUS.bIsPresent )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().BUS.percentage",                     NVIDIA.GPU_GetDynamicPstatesInfoEx().BUS.percentage )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetFullName()",                                                NVIDIA.GPU_GetFullName() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetGpuCoreCount()",                                            NVIDIA.GPU_GetGpuCoreCount() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetGPUType()",                                                 NVIDIA.GPU_GetGPUType() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetIRQ()",                                                     NVIDIA.GPU_GetIRQ() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetMemoryInfo().dedicatedVideoMemory",                         NVIDIA.GPU_GetMemoryInfo().dedicatedVideoMemory )
LV_Add( "", "GPU_GetMemoryInfo().availableDedicatedVideoMemory",                NVIDIA.GPU_GetMemoryInfo().availableDedicatedVideoMemory )
LV_Add( "", "GPU_GetMemoryInfo().systemVideoMemory",                            NVIDIA.GPU_GetMemoryInfo().systemVideoMemory )
LV_Add( "", "GPU_GetMemoryInfo().sharedSystemMemory",                           NVIDIA.GPU_GetMemoryInfo().sharedSystemMemory )
LV_Add( "", "GPU_GetMemoryInfo().curAvailableDedicatedVideoMemory",             NVIDIA.GPU_GetMemoryInfo().curAvailableDedicatedVideoMemory )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetPerfDecreaseInfo()",                                        NVIDIA.GPU_GetPerfDecreaseInfo() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetPhysicalFrameBufferSize()",                                 NVIDIA.GPU_GetPhysicalFrameBufferSize() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetSystemType()",                                              NVIDIA.GPU_GetSystemType() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetTachReading()",                                             NVIDIA.GPU_GetTachReading() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetThermalSettings().count",                                   NVIDIA.GPU_GetThermalSettings().count )
LV_Add( "", "GPU_GetThermalSettings().1.controller",                            NVIDIA.GPU_GetThermalSettings().1.controller )
LV_Add( "", "GPU_GetThermalSettings().1.defaultMinTemp",                        NVIDIA.GPU_GetThermalSettings().1.defaultMinTemp )
LV_Add( "", "GPU_GetThermalSettings().1.defaultMaxTemp",                        NVIDIA.GPU_GetThermalSettings().1.defaultMaxTemp )
LV_Add( "", "GPU_GetThermalSettings().1.currentTemp",                           NVIDIA.GPU_GetThermalSettings().1.currentTemp )
LV_Add( "", "GPU_GetThermalSettings().1.target",                                NVIDIA.GPU_GetThermalSettings().1.target )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetUsages()",                                                  NVIDIA.GPU_GetUsages() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetVbiosOEMRevision()",                                        NVIDIA.GPU_GetVbiosOEMRevision() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetVbiosRevision()",                                           NVIDIA.GPU_GetVbiosRevision() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetVbiosVersionString()",                                      NVIDIA.GPU_GetVbiosVersionString() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetVirtualFrameBufferSize()",                                  NVIDIA.GPU_GetVirtualFrameBufferSize() )
LV_Add( "", "", "")
LV_Add( "", "Stereo_IsEnabled()",                                               NVIDIA.Stereo_IsEnabled() )
LV_Add( "", "", "")
LV_Add( "", "Stereo_IsWindowedModeSupported()",                                 NVIDIA.Stereo_IsWindowedModeSupported() )
LV_Add( "", "", "")
LV_Add( "", "SYS_GetChipSetInfo().vendorId",                                    NVIDIA.SYS_GetChipSetInfo().vendorId )
LV_Add( "", "SYS_GetChipSetInfo().deviceId",                                    NVIDIA.SYS_GetChipSetInfo().deviceId )
LV_Add( "", "SYS_GetChipSetInfo().szVendorName",                                NVIDIA.SYS_GetChipSetInfo().szVendorName )
LV_Add( "", "SYS_GetChipSetInfo().szChipsetName",                               NVIDIA.SYS_GetChipSetInfo().szChipsetName )
LV_Add( "", "SYS_GetChipSetInfo().flags",                                       NVIDIA.SYS_GetChipSetInfo().flags )
LV_Add( "", "SYS_GetChipSetInfo().subSysVendorId",                              NVIDIA.SYS_GetChipSetInfo().subSysVendorId )
LV_Add( "", "SYS_GetChipSetInfo().subSysDeviceId",                              NVIDIA.SYS_GetChipSetInfo().subSysDeviceId )
LV_Add( "", "SYS_GetChipSetInfo().szSubSysVendorName",                          NVIDIA.SYS_GetChipSetInfo().szSubSysVendorName )
LV_Add( "", "SYS_GetChipSetInfo().HBvendorId",                                  NVIDIA.SYS_GetChipSetInfo().HBvendorId )
LV_Add( "", "SYS_GetChipSetInfo().HBdeviceId",                                  NVIDIA.SYS_GetChipSetInfo().HBdeviceId )
LV_Add( "", "SYS_GetChipSetInfo().HBsubSysVendorId",                            NVIDIA.SYS_GetChipSetInfo().HBsubSysVendorId )
LV_Add( "", "SYS_GetChipSetInfo().HBsubSysDeviceId",                            NVIDIA.SYS_GetChipSetInfo().HBsubSysDeviceId )
LV_Add( "", "", "")
LV_Add( "", "SYS_GetDriverAndBranchVersion().pDriverVersion",                   NVIDIA.SYS_GetDriverAndBranchVersion().pDriverVersion )
LV_Add( "", "SYS_GetDriverAndBranchVersion().szBuildBranchString",              NVIDIA.SYS_GetDriverAndBranchVersion().szBuildBranchString )

Gui, Show, AutoSize
return

; EXIT ==========================================================================================================================

GuiClose:
reset:
NVIDIA.OnExit()
ExitApp