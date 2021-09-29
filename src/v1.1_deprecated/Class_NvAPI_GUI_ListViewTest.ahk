; ===============================================================================================================================
; Title .........: NvAPI GUI ListView Test
; AHK Version ...: 1.1.22.09 x64 Unicode
; Win Version ...: Windows 7 Ultimate 64-bit SP1
; Description ...: NvAPI GUI ListView Test
; Version .......: v1.02
; Modified ......: 2015.12.01-2037
; Author(s) .....: jNizM
; ===============================================================================================================================
;@Ahk2Exe-SetName NvAPI GUI ListView Test
;@Ahk2Exe-SetDescription NvAPI GUI ListView Test
;@Ahk2Exe-SetVersion v1.02
;@Ahk2Exe-SetCopyright Copyright (c) 2014-2015`, jNizM
;@Ahk2Exe-SetOrigFilename Class_NvAPI_GUI_ListViewTest.ahk
; ===============================================================================================================================

; GLOBAL SETTINGS ===============================================================================================================

;#Warn
#NoEnv
#SingleInstance Force
SetBatchLines -1

#Include Class_NvAPI.ahk

NvAPI.ErrorMessage := True

; TEST SCRIPT ===================================================================================================================

cENDH := cENUADH := 0

while (NvAPI.EnumNvidiaDisplayHandle(cENDH) != "*-7")
    ++cENDH
cENDH := !cENDH ? 1 : cENDH
while (NvAPI.EnumNvidiaUnAttachedDisplayHandle(cENUADH) != "*-7")
    ++cENUADH
cENUADH := !cENUADH ? 1 : cENUADH


Gui, Margin, 5, 5
Gui, Add, ListView, xm ym w600 h400, Functions|Returns
LV_ModifyCol(1, 330)
LV_ModifyCol(2, 220)

LV_Add( "", "", "")
LV_Add( "", "DISP_GetGDIPrimaryDisplayId()",                                    NvAPI.DISP_GetGDIPrimaryDisplayId() )
LV_Add( "", "", "")
LV_Add( "", "EnumLogicalGPUs()[1]",                                             NvAPI.EnumLogicalGPUs()[1] )
LV_Add( "", "", "")
loop % cENDH
    LV_Add( "", "EnumNvidiaDisplayHandle(" A_Index - 1 ")",                     NvAPI.EnumNvidiaDisplayHandle(A_Index - 1) )
LV_Add( "", "", "")
loop % cENUADH
    LV_Add( "", "EnumNvidiaUnAttachedDisplayHandle(" A_Index - 1 ")",           NvAPI.EnumNvidiaUnAttachedDisplayHandle(A_Index - 1) )
LV_Add( "", "", "")
LV_Add( "", "EnumPhysicalGPUs()[1]",                                            NvAPI.EnumPhysicalGPUs()[1] )
LV_Add( "", "", "")
loop % cENDH
    LV_Add( "", "GetAssociatedDisplayOutputId(" A_Index - 1 ")",                NvAPI.GetAssociatedDisplayOutputId(A_Index - 1) )
LV_Add( "", "", "")
loop % cENDH
    LV_Add( "", "GetAssociatedNvidiaDisplayHandle(" A_Index - 1 ")",            NvAPI.GetAssociatedNvidiaDisplayHandle(A_Index - 1) )
LV_Add( "", "", "")
loop % cENDH
    LV_Add( "", "GetAssociatedNvidiaDisplayName(" A_Index - 1 ")",              NvAPI.GetAssociatedNvidiaDisplayName(A_Index - 1) )
LV_Add( "", "", "")
LV_Add( "", "GetDisplayDriverMemoryInfo().version",                             NvAPI.GetDisplayDriverMemoryInfo().version )
LV_Add( "", "GetDisplayDriverMemoryInfo().dedicatedVideoMemory",                NvAPI.GetDisplayDriverMemoryInfo().dedicatedVideoMemory )
LV_Add( "", "GetDisplayDriverMemoryInfo().availableDedicatedVideoMemory",       NvAPI.GetDisplayDriverMemoryInfo().availableDedicatedVideoMemory )
LV_Add( "", "GetDisplayDriverMemoryInfo().systemVideoMemory",                   NvAPI.GetDisplayDriverMemoryInfo().systemVideoMemory )
LV_Add( "", "GetDisplayDriverMemoryInfo().sharedSystemMemory",                  NvAPI.GetDisplayDriverMemoryInfo().sharedSystemMemory )
LV_Add( "", "GetDisplayDriverMemoryInfo().curAvailableDedicatedVideoMemory",    NvAPI.GetDisplayDriverMemoryInfo().curAvailableDedicatedVideoMemory )
LV_Add( "", "", "")
LV_Add( "", "GetDisplayDriverVersion().version",                                NvAPI.GetDisplayDriverVersion().version )
LV_Add( "", "GetDisplayDriverVersion().drvVersion",                             NvAPI.GetDisplayDriverVersion().drvVersion )
LV_Add( "", "GetDisplayDriverVersion().bldChangeListNum",                       NvAPI.GetDisplayDriverVersion().bldChangeListNum )
LV_Add( "", "GetDisplayDriverVersion().szBuildBranchString",                    NvAPI.GetDisplayDriverVersion().szBuildBranchString )
LV_Add( "", "GetDisplayDriverVersion().szAdapterString",                        NvAPI.GetDisplayDriverVersion().szAdapterString )
LV_Add( "", "", "")
LV_Add( "", "GetDisplayPortInfo().version",                                     NvAPI.GetDisplayPortInfo().version )
LV_Add( "", "GetDisplayPortInfo().dpcd_ver",                                    NvAPI.GetDisplayPortInfo().dpcd_ver )
LV_Add( "", "GetDisplayPortInfo().maxLinkRate",                                 NvAPI.GetDisplayPortInfo().maxLinkRate )
LV_Add( "", "GetDisplayPortInfo().maxLaneCount",                                NvAPI.GetDisplayPortInfo().maxLaneCount )
LV_Add( "", "GetDisplayPortInfo().curLinkRate",                                 NvAPI.GetDisplayPortInfo().curLinkRate )
LV_Add( "", "GetDisplayPortInfo().curLaneCount",                                NvAPI.GetDisplayPortInfo().curLaneCount )
LV_Add( "", "GetDisplayPortInfo().colorFormat",                                 NvAPI.GetDisplayPortInfo().colorFormat )
LV_Add( "", "GetDisplayPortInfo().dynamicRange",                                NvAPI.GetDisplayPortInfo().dynamicRange )
LV_Add( "", "GetDisplayPortInfo().colorimetry",                                 NvAPI.GetDisplayPortInfo().colorimetry )
LV_Add( "", "GetDisplayPortInfo().bpc",                                         NvAPI.GetDisplayPortInfo().bpc )
LV_Add( "", "GetDisplayPortInfo().isDp",                                        NvAPI.GetDisplayPortInfo().isDp )
LV_Add( "", "GetDisplayPortInfo().isInternalDp",                                NvAPI.GetDisplayPortInfo().isInternalDp )
LV_Add( "", "GetDisplayPortInfo().isColorCtrlSupported",                        NvAPI.GetDisplayPortInfo().isColorCtrlSupported )
LV_Add( "", "GetDisplayPortInfo().is6BPCSupported",                             NvAPI.GetDisplayPortInfo().is6BPCSupported )
LV_Add( "", "GetDisplayPortInfo().is8BPCSupported",                             NvAPI.GetDisplayPortInfo().is8BPCSupported )
LV_Add( "", "GetDisplayPortInfo().is10BPCSupported",                            NvAPI.GetDisplayPortInfo().is10BPCSupported )
LV_Add( "", "GetDisplayPortInfo().is12BPCSupported",                            NvAPI.GetDisplayPortInfo().is12BPCSupported )
LV_Add( "", "GetDisplayPortInfo().is16BPCSupported",                            NvAPI.GetDisplayPortInfo().is16BPCSupported )
LV_Add( "", "GetDisplayPortInfo().isYCrCb422Supported",                         NvAPI.GetDisplayPortInfo().isYCrCb422Supported )
LV_Add( "", "GetDisplayPortInfo().isYCrCb444Supported",                         NvAPI.GetDisplayPortInfo().isYCrCb444Supported )
LV_Add( "", "GetDisplayPortInfo().isRgb444SupportedOnCurrentMode",              NvAPI.GetDisplayPortInfo().isRgb444SupportedOnCurrentMode )
LV_Add( "", "GetDisplayPortInfo().isYCbCr444SupportedOnCurrentMode",            NvAPI.GetDisplayPortInfo().isYCbCr444SupportedOnCurrentMode )
LV_Add( "", "GetDisplayPortInfo().isYCbCr422SupportedOnCurrentMode",            NvAPI.GetDisplayPortInfo().isYCbCr422SupportedOnCurrentMode )
LV_Add( "", "GetDisplayPortInfo().is6BPCSupportedOnCurrentMode",                NvAPI.GetDisplayPortInfo().is6BPCSupportedOnCurrentMode )
LV_Add( "", "GetDisplayPortInfo().is8BPCSupportedOnCurrentMode",                NvAPI.GetDisplayPortInfo().is8BPCSupportedOnCurrentMode )
LV_Add( "", "GetDisplayPortInfo().is10BPCSupportedOnCurrentMode",               NvAPI.GetDisplayPortInfo().is10BPCSupportedOnCurrentMode )
LV_Add( "", "GetDisplayPortInfo().is12BPCSupportedOnCurrentMode",               NvAPI.GetDisplayPortInfo().is12BPCSupportedOnCurrentMode )
LV_Add( "", "GetDisplayPortInfo().is16BPCSupportedOnCurrentMode",               NvAPI.GetDisplayPortInfo().is16BPCSupportedOnCurrentMode )
LV_Add( "", "", "")
LV_Add( "", "GetDVCInfo().version",                                             NvAPI.GetDVCInfo().version )
LV_Add( "", "GetDVCInfo().currentLevel",                                        NvAPI.GetDVCInfo().currentLevel )
LV_Add( "", "GetDVCInfo().minLevel",                                            NvAPI.GetDVCInfo().minLevel )
LV_Add( "", "GetDVCInfo().maxLevel",                                            NvAPI.GetDVCInfo().maxLevel )
LV_Add( "", "", "")
loop % cENDH
{
    LV_Add( "", "GetDVCInfoEx(" A_Index - 1 ").version",                        NvAPI.GetDVCInfoEx(A_Index - 1).version )
    LV_Add( "", "GetDVCInfoEx(" A_Index - 1 ").currentLevel",                   NvAPI.GetDVCInfoEx(A_Index - 1).currentLevel )
    LV_Add( "", "GetDVCInfoEx(" A_Index - 1 ").minLevel",                       NvAPI.GetDVCInfoEx(A_Index - 1).minLevel )
    LV_Add( "", "GetDVCInfoEx(" A_Index - 1 ").maxLevel",                       NvAPI.GetDVCInfoEx(A_Index - 1).maxLevel )
    LV_Add( "", "GetDVCInfoEx(" A_Index - 1 ").defaultLevel",                   NvAPI.GetDVCInfoEx(A_Index - 1).defaultLevel )
}
LV_Add( "", "", "")
LV_Add( "", "GetHDMISupportInfo().version",                                     NvAPI.GetHDMISupportInfo().version )
LV_Add( "", "GetHDMISupportInfo().isGpuHDMICapable",                            NvAPI.GetHDMISupportInfo().isGpuHDMICapable )
LV_Add( "", "GetHDMISupportInfo().isMonUnderscanCapable",                       NvAPI.GetHDMISupportInfo().isMonUnderscanCapable )
LV_Add( "", "GetHDMISupportInfo().isMonBasicAudioCapable",                      NvAPI.GetHDMISupportInfo().isMonBasicAudioCapable )
LV_Add( "", "GetHDMISupportInfo().isMonYCbCr444Capable",                        NvAPI.GetHDMISupportInfo().isMonYCbCr444Capable )
LV_Add( "", "GetHDMISupportInfo().isMonYCbCr422Capable",                        NvAPI.GetHDMISupportInfo().isMonYCbCr422Capable )
LV_Add( "", "GetHDMISupportInfo().isMonxvYCC601Capable",                        NvAPI.GetHDMISupportInfo().isMonxvYCC601Capable )
LV_Add( "", "GetHDMISupportInfo().isMonxvYCC709Capable",                        NvAPI.GetHDMISupportInfo().isMonxvYCC709Capable )
LV_Add( "", "GetHDMISupportInfo().isMonHDMI",                                   NvAPI.GetHDMISupportInfo().isMonHDMI )
LV_Add( "", "GetHDMISupportInfo().isMonsYCC601Capable",                         NvAPI.GetHDMISupportInfo().isMonsYCC601Capable )
LV_Add( "", "GetHDMISupportInfo().isMonAdobeYCC601Capable",                     NvAPI.GetHDMISupportInfo().isMonAdobeYCC601Capable )
LV_Add( "", "GetHDMISupportInfo().isMonAdobeRGBCapable",                        NvAPI.GetHDMISupportInfo().isMonAdobeRGBCapable )
LV_Add( "", "GetHDMISupportInfo().EDID861ExtRev",                               NvAPI.GetHDMISupportInfo().EDID861ExtRev )
LV_Add( "", "", "")
LV_Add( "", "GetHUEInfo().version",                                             NvAPI.GetHUEInfo().version )
LV_Add( "", "GetHUEInfo().currentHueAngle",                                     NvAPI.GetHUEInfo().currentHueAngle )
LV_Add( "", "GetHUEInfo().defaultHueAngle",                                     NvAPI.GetHUEInfo().defaultHueAngle )
LV_Add( "", "", "")
LV_Add( "", "GetInterfaceVersionString()",                                      NvAPI.GetInterfaceVersionString() )
LV_Add( "", "", "")
loop % cENUADH
    LV_Add( "", "GetUnAttachedAssociatedDisplayName(" A_Index - 1 ")",          NvAPI.GetUnAttachedAssociatedDisplayName(A_Index - 1) )
LV_Add( "", "", "")
LV_Add( "", "GetVBlankCounter()",                                               NvAPI.GetVBlankCounter() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetAGPAperture()",                                             NvAPI.GPU_GetAGPAperture() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetAllClockFrequencies().version",                             NvAPI.GPU_GetAllClockFrequencies().version )
LV_Add( "", "GPU_GetAllClockFrequencies().Type",                                NvAPI.GPU_GetAllClockFrequencies().Type )
LV_Add( "", "GPU_GetAllClockFrequencies().GRAPHICS.bIsPresent",                 NvAPI.GPU_GetAllClockFrequencies().GRAPHICS.bIsPresent )
LV_Add( "", "GPU_GetAllClockFrequencies().GRAPHICS.frequency",                  NvAPI.GPU_GetAllClockFrequencies().GRAPHICS.frequency )
LV_Add( "", "GPU_GetAllClockFrequencies().MEMORY.bIsPresent",                   NvAPI.GPU_GetAllClockFrequencies().MEMORY.bIsPresent )
LV_Add( "", "GPU_GetAllClockFrequencies().MEMORY.frequency",                    NvAPI.GPU_GetAllClockFrequencies().MEMORY.frequency )
LV_Add( "", "GPU_GetAllClockFrequencies().PROCESSOR.bIsPresent",                NvAPI.GPU_GetAllClockFrequencies().PROCESSOR.bIsPresent )
LV_Add( "", "GPU_GetAllClockFrequencies().PROCESSOR.frequency",                 NvAPI.GPU_GetAllClockFrequencies().PROCESSOR.frequency )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetBoardInfo()",                                               NvAPI.GPU_GetBoardInfo() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetBusId()",                                                   NvAPI.GPU_GetBusId() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetBusSlotId()",                                               NvAPI.GPU_GetBusSlotId() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetBusType()",                                                 NvAPI.GPU_GetBusType() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetCoolerSettings().version",                                  NvAPI.GPU_GetCoolerSettings().version )
LV_Add( "", "GPU_GetCoolerSettings().count",                                    NvAPI.GPU_GetCoolerSettings().count )
loop % NvAPI.GPU_GetCoolerSettings().count
{
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].type",                    NvAPI.GPU_GetCoolerSettings()[A_Index].type )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].controller",              NvAPI.GPU_GetCoolerSettings()[A_Index].controller )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].defaultMinLevel",         NvAPI.GPU_GetCoolerSettings()[A_Index].defaultMinLevel )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].defaultMaxLevel",         NvAPI.GPU_GetCoolerSettings()[A_Index].defaultMaxLevel )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].currentMinLevel",         NvAPI.GPU_GetCoolerSettings()[A_Index].currentMinLevel )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].currentMaxLevel",         NvAPI.GPU_GetCoolerSettings()[A_Index].currentMaxLevel )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].currentLevel",            NvAPI.GPU_GetCoolerSettings()[A_Index].currentLevel )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].defaultPolicy",           NvAPI.GPU_GetCoolerSettings()[A_Index].defaultPolicy )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].currentPolicy",           NvAPI.GPU_GetCoolerSettings()[A_Index].currentPolicy )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].target",                  NvAPI.GPU_GetCoolerSettings()[A_Index].target )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].controlType",             NvAPI.GPU_GetCoolerSettings()[A_Index].controlType )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].active",                  NvAPI.GPU_GetCoolerSettings()[A_Index].active )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].speedRPM",                NvAPI.GPU_GetCoolerSettings()[A_Index].speedRPM )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].bSupported",              NvAPI.GPU_GetCoolerSettings()[A_Index].bSupported )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].maxSpeedRPM",             NvAPI.GPU_GetCoolerSettings()[A_Index].maxSpeedRPM )
    LV_Add( "", "GPU_GetCoolerSettings()[" A_Index "].minSpeedRPM",             NvAPI.GPU_GetCoolerSettings()[A_Index].minSpeedRPM )
}
LV_Add( "", "", "")
LV_Add( "", "GPU_GetCurrentAGPRate()",                                          NvAPI.GPU_GetCurrentAGPRate() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetCurrentPCIEDownstreamWidth()",                              NvAPI.GPU_GetCurrentPCIEDownstreamWidth() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetCurrentPstate()",                                           NvAPI.GPU_GetCurrentPstate() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().version",                            NvAPI.GPU_GetDynamicPstatesInfoEx().version )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().Enabled",                            NvAPI.GPU_GetDynamicPstatesInfoEx().Enabled )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().GPU.bIsPresent",                     NvAPI.GPU_GetDynamicPstatesInfoEx().GPU.bIsPresent )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().GPU.percentage",                     NvAPI.GPU_GetDynamicPstatesInfoEx().GPU.percentage )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().FB.bIsPresent",                      NvAPI.GPU_GetDynamicPstatesInfoEx().FB.bIsPresent )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().FB.percentage",                      NvAPI.GPU_GetDynamicPstatesInfoEx().FB.percentage )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().VID.bIsPresent",                     NvAPI.GPU_GetDynamicPstatesInfoEx().VID.bIsPresent )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().VID.percentage",                     NvAPI.GPU_GetDynamicPstatesInfoEx().VID.percentage )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().BUS.bIsPresent",                     NvAPI.GPU_GetDynamicPstatesInfoEx().BUS.bIsPresent )
LV_Add( "", "GPU_GetDynamicPstatesInfoEx().BUS.percentage",                     NvAPI.GPU_GetDynamicPstatesInfoEx().BUS.percentage )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetFullName()",                                                NvAPI.GPU_GetFullName() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetGpuCoreCount()",                                            NvAPI.GPU_GetGpuCoreCount() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetGPUType()",                                                 NvAPI.GPU_GetGPUType() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetHDCPSupportStatus().version",                               NvAPI.GPU_GetHDCPSupportStatus().version )
LV_Add( "", "GPU_GetHDCPSupportStatus().hdcpFuseState",                         NvAPI.GPU_GetHDCPSupportStatus().hdcpFuseState )
LV_Add( "", "GPU_GetHDCPSupportStatus().hdcpKeySource",                         NvAPI.GPU_GetHDCPSupportStatus().hdcpKeySource )
LV_Add( "", "GPU_GetHDCPSupportStatus().hdcpKeySourceState",                    NvAPI.GPU_GetHDCPSupportStatus().hdcpKeySourceState )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetIRQ()",                                                     NvAPI.GPU_GetIRQ() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetMemoryInfo().version",                                      NvAPI.GPU_GetMemoryInfo().version )
LV_Add( "", "GPU_GetMemoryInfo().dedicatedVideoMemory",                         NvAPI.GPU_GetMemoryInfo().dedicatedVideoMemory )
LV_Add( "", "GPU_GetMemoryInfo().availableDedicatedVideoMemory",                NvAPI.GPU_GetMemoryInfo().availableDedicatedVideoMemory )
LV_Add( "", "GPU_GetMemoryInfo().systemVideoMemory",                            NvAPI.GPU_GetMemoryInfo().systemVideoMemory )
LV_Add( "", "GPU_GetMemoryInfo().sharedSystemMemory",                           NvAPI.GPU_GetMemoryInfo().sharedSystemMemory )
LV_Add( "", "GPU_GetMemoryInfo().curAvailableDedicatedVideoMemory",             NvAPI.GPU_GetMemoryInfo().curAvailableDedicatedVideoMemory )
LV_Add( "", "", "")
loop % cENDH
    LV_Add( "", "GPU_GetOutputType(" A_Index ")",                               NvAPI.GPU_GetOutputType(A_Index) )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetPerfDecreaseInfo()",                                        NvAPI.GPU_GetPerfDecreaseInfo() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetPhysicalFrameBufferSize()",                                 NvAPI.GPU_GetPhysicalFrameBufferSize() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetSystemType()",                                              NvAPI.GPU_GetSystemType() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetTachReading()",                                             NvAPI.GPU_GetTachReading() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetThermalSettings().version",                                 NvAPI.GPU_GetThermalSettings().version )
LV_Add( "", "GPU_GetThermalSettings().count",                                   NvAPI.GPU_GetThermalSettings().count )
loop % NvAPI.GPU_GetThermalSettings().count
{
    LV_Add( "", "GPU_GetThermalSettings()[" A_Index "].controller",             NvAPI.GPU_GetThermalSettings()[A_Index].controller )
    LV_Add( "", "GPU_GetThermalSettings()[" A_Index "].defaultMinTemp",         NvAPI.GPU_GetThermalSettings()[A_Index].defaultMinTemp )
    LV_Add( "", "GPU_GetThermalSettings()[" A_Index "].defaultMaxTemp",         NvAPI.GPU_GetThermalSettings()[A_Index].defaultMaxTemp )
    LV_Add( "", "GPU_GetThermalSettings()[" A_Index "].currentTemp",            NvAPI.GPU_GetThermalSettings()[A_Index].currentTemp )
    LV_Add( "", "GPU_GetThermalSettings()[" A_Index "].target",                 NvAPI.GPU_GetThermalSettings()[A_Index].target )
}
LV_Add( "", "", "")
LV_Add( "", "GPU_GetUsages()",                                                  NvAPI.GPU_GetUsages() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetVbiosOEMRevision()",                                        NvAPI.GPU_GetVbiosOEMRevision() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetVbiosRevision()",                                           NvAPI.GPU_GetVbiosRevision() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetVbiosVersionString()",                                      NvAPI.GPU_GetVbiosVersionString() )
LV_Add( "", "", "")
LV_Add( "", "GPU_GetVirtualFrameBufferSize()",                                  NvAPI.GPU_GetVirtualFrameBufferSize() )
LV_Add( "", "", "")
LV_Add( "", "Stereo_IsEnabled()",                                               NvAPI.Stereo_IsEnabled() )
LV_Add( "", "", "")
LV_Add( "", "Stereo_IsWindowedModeSupported()",                                 NvAPI.Stereo_IsWindowedModeSupported() )
LV_Add( "", "", "")
LV_Add( "", "SYS_GetChipSetInfo().version",                                     NvAPI.SYS_GetChipSetInfo().version )
LV_Add( "", "SYS_GetChipSetInfo().vendorId",                                    NvAPI.SYS_GetChipSetInfo().vendorId )
LV_Add( "", "SYS_GetChipSetInfo().deviceId",                                    NvAPI.SYS_GetChipSetInfo().deviceId )
LV_Add( "", "SYS_GetChipSetInfo().szVendorName",                                NvAPI.SYS_GetChipSetInfo().szVendorName )
LV_Add( "", "SYS_GetChipSetInfo().szChipsetName",                               NvAPI.SYS_GetChipSetInfo().szChipsetName )
LV_Add( "", "SYS_GetChipSetInfo().flags",                                       NvAPI.SYS_GetChipSetInfo().flags )
LV_Add( "", "SYS_GetChipSetInfo().subSysVendorId",                              NvAPI.SYS_GetChipSetInfo().subSysVendorId )
LV_Add( "", "SYS_GetChipSetInfo().subSysDeviceId",                              NvAPI.SYS_GetChipSetInfo().subSysDeviceId )
LV_Add( "", "SYS_GetChipSetInfo().szSubSysVendorName",                          NvAPI.SYS_GetChipSetInfo().szSubSysVendorName )
LV_Add( "", "SYS_GetChipSetInfo().HBvendorId",                                  NvAPI.SYS_GetChipSetInfo().HBvendorId )
LV_Add( "", "SYS_GetChipSetInfo().HBdeviceId",                                  NvAPI.SYS_GetChipSetInfo().HBdeviceId )
LV_Add( "", "SYS_GetChipSetInfo().HBsubSysVendorId",                            NvAPI.SYS_GetChipSetInfo().HBsubSysVendorId )
LV_Add( "", "SYS_GetChipSetInfo().HBsubSysDeviceId",                            NvAPI.SYS_GetChipSetInfo().HBsubSysDeviceId )
LV_Add( "", "", "")
LV_Add( "", "SYS_GetDriverAndBranchVersion().pDriverVersion",                   NvAPI.SYS_GetDriverAndBranchVersion().pDriverVersion )
LV_Add( "", "SYS_GetDriverAndBranchVersion().szBuildBranchString",              NvAPI.SYS_GetDriverAndBranchVersion().szBuildBranchString )

Gui, Show, AutoSize
return

; EXIT ==========================================================================================================================

GuiClose:
GuiEscape:
ExitApp