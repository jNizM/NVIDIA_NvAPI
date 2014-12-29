class NvAPI
{
    static hmod
    static DllFile := (A_PtrSize = 8) ? "nvapi64.dll" : "nvapi.dll"

    static NVAPI_MAX_PHYSICAL_GPUS    := 64
    static NVAPI_SHORT_STRING_MAX     := 64

    __New()
    {
        if !(NvAPI.hmod)
        {
            if !(NvAPI.hmod := DllCall("kernel32.dll\LoadLibrary", "Str", NvAPI.DllFile, "UPtr"))
                MsgBox % "LoadLibrary Error: " DllCall("kernel32.dll\GetLastError")

            if !(NvStatus := DllCall(DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x0150E828, "CDECL UPtr"), "CDECL"))
            {
                NvAPI._DISP_GetGDIPrimaryDisplayId          := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x1E9D8A31, "CDECL UPtr")
                NvAPI._EnumNvidiaDisplayHandle              := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x9ABDD40D, "CDECL UPtr")
                NvAPI._EnumNvidiaUnAttachedDisplayHandle    := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x20DE9260, "CDECL UPtr")
                NvAPI._EnumPhysicalGPUs                     := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xE5AC921F, "CDECL UPtr")
                NvAPI._GetAssociatedDisplayOutputId         := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xD995937E, "CDECL UPtr")
                NvAPI._GetAssociatedNvidiaDisplayHandle     := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x35C29134, "CDECL UPtr")
                NvAPI._GetAssociatedNvidiaDisplayName       := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x22A78B05, "CDECL UPtr")
                NvAPI._GetDisplayDriverMemoryInfo           := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x774AA982, "CDECL UPtr")
                NvAPI._GetDisplayDriverVersion              := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xF951A4D1, "CDECL UPtr")
                NvAPI._GetDVCInfo                           := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x4085DE45, "CDECL UPtr")
                NvAPI._GetDVCInfoEx                         := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x0E45002D, "CDECL UPtr")
                NvAPI._GetInterfaceVersionString            := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x01053FA5, "CDECL UPtr")
                NvAPI._GetUnAttachedAssociatedDisplayName   := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x4888D790, "CDECL UPtr")
                NvAPI._GetVBlankCounter                     := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x67B5DB55, "CDECL UPtr")
                NvAPI._GPU_GetAGPAperture                   := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x6E042794, "CDECL UPtr")
                NvAPI._GPU_GetAllClockFrequencies           := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xDCB616C3, "CDECL UPtr")
                NvAPI._GPU_GetBoardInfo                     := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x22D54523, "CDECL UPtr")
                NvAPI._GPU_GetBusId                         := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x1BE0B8E5, "CDECL UPtr")
                NvAPI._GPU_GetBusSlotId                     := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x2A0A350F, "CDECL UPtr")
                NvAPI._GPU_GetBusType                       := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x1BB18724, "CDECL UPtr")
                NvAPI._GPU_GetCoolerSettings                := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xDA141340, "CDECL UPtr")
                NvAPI._GPU_GetCurrentAGPRate                := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xC74925A0, "CDECL UPtr")
                NvAPI._GPU_GetCurrentPCIEDownstreamWidth    := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xD048C3B1, "CDECL UPtr")
                NvAPI._GPU_GetCurrentPstate                 := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x927DA4F6, "CDECL UPtr")
                NvAPI._GPU_GetDynamicPstatesInfoEx          := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x60DED2ED, "CDECL UPtr")
                NvAPI._GPU_GetFullName                      := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xCEEE8E9F, "CDECL UPtr")
                NvAPI._GPU_GetGpuCoreCount                  := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xC7026A87, "CDECL UPtr")
                NvAPI._GPU_GetGPUType                       := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xC33BAEB1, "CDECL UPtr")
                NvAPI._GPU_GetIRQ                           := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xE4715417, "CDECL UPtr")
                NvAPI._GPU_GetMemoryInfo                    := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x07F9B368, "CDECL UPtr")
                NvAPI._GPU_GetPerfDecreaseInfo              := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x7F7F4600, "CDECL UPtr")
                NvAPI._GPU_GetPhysicalFrameBufferSize       := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x46FBEB03, "CDECL UPtr")
                NvAPI._GPU_GetSystemType                    := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xBAAABFCC, "CDECL UPtr")
                NvAPI._GPU_GetTachReading                   := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x5F608315, "CDECL UPtr")
                NvAPI._GPU_GetThermalSettings               := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xE3640A56, "CDECL UPtr")
                NvAPI._GPU_GetUsages                        := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x189A1FDF, "CDECL UPtr")
                NvAPI._GPU_GetVbiosOEMRevision              := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x2D43FB31, "CDECL UPtr")
                NvAPI._GPU_GetVbiosRevision                 := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xACC3DA0A, "CDECL UPtr")
                NvAPI._GPU_GetVbiosVersionString            := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xA561FD7D, "CDECL UPtr")
                NvAPI._GPU_GetVirtualFrameBufferSize        := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x5A04B644, "CDECL UPtr")
                NvAPI._SetDVCLevel                          := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x172409B4, "CDECL UPtr")
                NvAPI._SetDVCLevelEx                        := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x4A82C2B1, "CDECL UPtr")
                NvAPI._Stereo_IsEnabled                     := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x348FF8E1, "CDECL UPtr")
                NvAPI._Stereo_IsWindowedModeSupported       := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x40C8ED5E, "CDECL UPtr")
                NvAPI._SYS_GetChipSetInfo                   := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x53DABBCA, "CDECL UPtr")
                NvAPI._SYS_GetDriverAndBranchVersion        := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0x2926AAAD, "CDECL UPtr")
                NvAPI._Unload                               := DllCall(NvAPI.DllFile "\nvapi_QueryInterface", "UInt", 0xD22BDD7E, "CDECL UPtr")
            }
            else
                MsgBox % "Initialize Error: " NvStatus
        }
    }

; ###############################################################################################################################

    DISP_GetGDIPrimaryDisplayId()
    {
        if !(NvStatus := DllCall(NvAPI._DISP_GetGDIPrimaryDisplayId, "UInt*", displayId, "CDECL"))
            return displayId
        return "*" NvStatus
    }

; ###############################################################################################################################

    EnumNvidiaDisplayHandle(thisEnum := 0)
    {
        if !(NvStatus := DllCall(NvAPI._EnumNvidiaDisplayHandle, "UInt", thisEnum, "UInt*", pNvDispHandle, "CDECL"))
            return pNvDispHandle
        return "*" NvStatus
    }

; ###############################################################################################################################

    EnumNvidiaUnAttachedDisplayHandle(thisEnum := 0)
    {
        if !(NvStatus := DllCall(NvAPI._EnumNvidiaUnAttachedDisplayHandle, "Int", thisEnum, "UInt*", pNvUnAttachedDispHandle, "CDECL"))
            return pNvUnAttachedDispHandle
        return "*" NvStatus
    }

; ###############################################################################################################################

    EnumPhysicalGPUs()
    {
        VarSetCapacity(nvGPUHandle, 4 * NvAPI.NVAPI_MAX_PHYSICAL_GPUS, 0)
        if !(NvStatus := DllCall(NvAPI._EnumPhysicalGPUs, "Ptr", &nvGPUHandle, "UInt*", pGpuCount, "CDECL"))
        {
            GPUH := []
            loop % pGpuCount
                GPUH[A_Index] := NumGet(nvGPUHandle, 4 * (A_Index - 1), "Int")
            return GPUH
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    GetAssociatedDisplayOutputId()
    {
        hNvDisplay := NvAPI.EnumNvidiaDisplayHandle()
        if !(NvStatus := DllCall(NvAPI._GetAssociatedDisplayOutputId, "Ptr", hNvDisplay, "UInt*", pOutputId, "CDECL"))
            return pOutputId
        return "*" NvStatus
    }

; ###############################################################################################################################

    GetAssociatedNvidiaDisplayHandle(thisEnum := 0)
    {
        szDisplayName := NvAPI.GetAssociatedNvidiaDisplayName(thisEnum)
        if !(NvStatus := DllCall(NvAPI._GetAssociatedNvidiaDisplayHandle, "AStr", szDisplayName, "Int*", pNvDispHandle, "CDECL"))
            return pNvDispHandle
        return "*" NvStatus
    }

; ###############################################################################################################################

    GetAssociatedNvidiaDisplayName(thisEnum := 0)
    {
        NvDispHandle := NvAPI.EnumNvidiaDisplayHandle(thisEnum)
        VarSetCapacity(szDisplayName, NvAPI.NVAPI_SHORT_STRING_MAX, 0)
        if !(NvStatus := DllCall(NvAPI._GetAssociatedNvidiaDisplayName, "Ptr", NvDispHandle, "Ptr", &szDisplayName, "CDECL"))
            return StrGet(&szDisplayName, "CP0")
        return "*" NvStatus
    }

; ###############################################################################################################################

    GetDisplayDriverMemoryInfo()
    {
        static NV_DISPLAY_DRIVER_MEMORY_INFO := 24
        hNvDisplay := NvAPI.EnumNvidiaDisplayHandle()
        VarSetCapacity(pMemoryInfo, NV_DISPLAY_DRIVER_MEMORY_INFO, 0), NumPut(NV_DISPLAY_DRIVER_MEMORY_INFO | 0x20000, pMemoryInfo, 0, "UInt")
        if !(NvStatus := DllCall(NvAPI._GetDisplayDriverMemoryInfo, "Ptr", hNvDisplay, "Ptr", &pMemoryInfo, "CDECL"))
        {
            MI := {}
            MI.version                          := NumGet(pMemoryInfo,  0, "UInt")
            MI.dedicatedVideoMemory             := NumGet(pMemoryInfo,  4, "UInt")
            MI.availableDedicatedVideoMemory    := NumGet(pMemoryInfo,  8, "UInt")
            MI.systemVideoMemory                := NumGet(pMemoryInfo, 12, "UInt")
            MI.sharedSystemMemory               := NumGet(pMemoryInfo, 16, "UInt")
            MI.curAvailableDedicatedVideoMemory := NumGet(pMemoryInfo, 20, "UInt")
            return MI
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    GetDisplayDriverVersion()
    {
        static NV_DISPLAY_DRIVER_VERSION := 12 + (2 * NvAPI.NVAPI_SHORT_STRING_MAX)
        hNvDisplay := NvAPI.EnumNvidiaDisplayHandle()
        VarSetCapacity(pVersion, NV_DISPLAY_DRIVER_VERSION, 0), NumPut(NV_DISPLAY_DRIVER_VERSION | 0x10000, pVersion, 0, "UInt")
        if !(NvStatus := DllCall(NvAPI._GetDisplayDriverVersion, "Ptr", hNvDisplay, "Ptr", &pVersion, "CDECL"))
        {
            DV := {}
            DV.version             := NumGet(pVersion,    0, "UInt")
            DV.drvVersion          := NumGet(pVersion,    4, "UInt")
            DV.bldChangeListNum    := NumGet(pVersion,    8, "UInt")
            DV.szBuildBranchString := StrGet(&pVersion + 12, NvAPI.NVAPI_SHORT_STRING_MAX, "CP0")
            DV.szAdapterString     := StrGet(&pVersion + 76, NvAPI.NVAPI_SHORT_STRING_MAX, "CP0")
            return DV
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    GetDVCInfo(outputId := 0)
    {
        static NV_DISPLAY_DVC_INFO := 16
        hNvDisplay := NvAPI.EnumNvidiaDisplayHandle()
        VarSetCapacity(pDVCInfo, NV_DISPLAY_DVC_INFO), NumPut(NV_DISPLAY_DVC_INFO | 0x10000, pDVCInfo, 0, "UInt")
        if !(NvStatus := DllCall(NvAPI._GetDVCInfo, "Ptr", hNvDisplay, "UInt", outputId, "Ptr", &pDVCInfo, "CDECL"))
        {
            DVC := {}
            DVC.version      := NumGet(pDVCInfo,  0, "UInt")
            DVC.currentLevel := NumGet(pDVCInfo,  4, "UInt")
            DVC.minLevel     := NumGet(pDVCInfo,  8, "UInt")
            DVC.maxLevel     := NumGet(pDVCInfo, 12, "UInt")
            return DVC
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    GetDVCInfoEx(thisEnum := 0, outputId := 0)
    {
        static NV_DISPLAY_DVC_INFO_EX := 20
        hNvDisplay := NvAPI.GetAssociatedNvidiaDisplayHandle(thisEnum)
        VarSetCapacity(pDVCInfo, NV_DISPLAY_DVC_INFO_EX), NumPut(NV_DISPLAY_DVC_INFO_EX | 0x10000, pDVCInfo, 0, "UInt")
        if !(NvStatus := DllCall(NvAPI._GetDVCInfoEx, "Ptr", hNvDisplay, "UInt", outputId, "Ptr", &pDVCInfo, "CDECL"))
        {
            DVC := {}
            DVC.version      := NumGet(pDVCInfo,  0, "UInt")
            DVC.currentLevel := NumGet(pDVCInfo,  4, "Int")
            DVC.minLevel     := NumGet(pDVCInfo,  8, "Int")
            DVC.maxLevel     := NumGet(pDVCInfo, 12, "Int")
            DVC.defaultLevel := NumGet(pDVCInfo, 16, "Int")
            return DVC
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    GetInterfaceVersionString()
    {
        VarSetCapacity(szDesc, NvAPI.NVAPI_SHORT_STRING_MAX, 0)
        if !(NvStatus := DllCall(NvAPI._GetInterfaceVersionString, "Ptr", &szDesc, "CDECL"))
            return StrGet(&szDesc, "CP0")
        return "*" NvStatus
    }

; ###############################################################################################################################

    GetUnAttachedAssociatedDisplayName()
    {
        hNvUnAttachedDisp := NvAPI.EnumNvidiaUnAttachedDisplayHandle()
        VarSetCapacity(szDisplayName, NvAPI.NVAPI_SHORT_STRING_MAX, 0)
        if !(NvStatus := DllCall(NvAPI._GetUnAttachedAssociatedDisplayName, "Int", hNvUnAttachedDisp, "Ptr", &szDisplayName, "CDECL"))
            return StrGet(&szDisplayName, "CP0")
        return "*" NvStatus
    }

; ###############################################################################################################################

    GetVBlankCounter()
    {
        hNvDisplay := NvAPI.EnumNvidiaDisplayHandle()
        if !(NvStatus := DllCall(NvAPI._GetVBlankCounter, "Ptr", hNvDisplay, "UInt*", pCounter))
            return pCounter
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetAGPAperture(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetAGPAperture, "Ptr", hPhysicalGpu, "UInt*", pSize))
            return pSize
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetAllClockFrequencies(hPhysicalGPU := 0, ClockType := 0)
    {
        static NVAPI_MAX_GPU_PUBLIC_CLOCKS := 32
        static NV_GPU_CLOCK_FREQUENCIES := 8 + (8 * NVAPI_MAX_GPU_PUBLIC_CLOCKS)
        static NV_GPU_PUBLIC_CLOCK_ID := {0: "GRAPHICS", 4: "MEMORY", 7: "PROCESSOR"}
        static NV_GPU_CLOCK_FREQUENCIES_CLOCK_TYPE := {0: "CURRENT_FREQ", 1: "BASE_CLOCK", 2: "BOOST_CLOCK", 3: "CLOCK_TYPE_NUM"}
        if !(hPhysicalGPU)
            hPhysicalGPU := NvAPI.EnumPhysicalGPUs().1
        if !(NV_GPU_CLOCK_FREQUENCIES_CLOCK_TYPE.HasKey(ClockType))
            ClockType := 0
        VarSetCapacity(pClkFreqs, NV_GPU_CLOCK_FREQUENCIES, 0), NumPut(NV_GPU_CLOCK_FREQUENCIES | 0x20000, pClkFreqs, 0, "UInt")
        NumPut(ClockType, pClkFreqs, 4, "UInt")
        if !(NvStatus := DllCall(NvAPI._GPU_GetAllClockFrequencies, "Ptr", hPhysicalGPU, "Ptr", &pClkFreqs, "CDECL"))
        {
            CF := {}
            CF.Type := NV_GPU_CLOCK_FREQUENCIES_CLOCK_TYPE[ClockType]
            for Index, Domain in NV_GPU_PUBLIC_CLOCK_ID
            {
                Offset := 8 + (8 * Index)
                CF[Domain, "bIsPresent"] := NumGet(pClkFreqs, Offset, "UInt") & 1
                CF[Domain, "frequency"]  := NumGet(pClkFreqs, Offset + 4, "UInt")
            }
            return CF
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetBoardInfo(hPhysicalGpu := 0)
    {
        static NV_BOARD_INFO := 20
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        VarSetCapacity(pBoardInfo, NV_BOARD_INFO, 0), NumPut(NV_BOARD_INFO | 0x10000, pBoardInfo, 0, "UInt")
        if !(NvStatus := DllCall(NvAPI._GPU_GetBoardInfo, "Ptr", hPhysicalGpu, "Ptr" &pBoardInfo, "CDECL"))
            return  NumGet(pBoardInfo, 4, "UChar")
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetBusId(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetBusId, "Ptr", hPhysicalGpu, "UInt*", pBusId))
            return pBusId
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetBusSlotId(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetBusSlotId, "Ptr", hPhysicalGpu, "UInt*", pBusSlotId))
            return pBusSlotId
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetBusType(hPhysicalGpu := 0)
    {
        static NV_GPU_BUS_TYPE := {0: "UNDEFINED", 1: "PCI", 2: "AGP", 3: "PCI_EXPRESS", 4: "FPCI", 5: "AXI"}
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetBusType, "Ptr", hPhysicalGpu, "Int*", pBusType, "CDECL"))
            return NV_GPU_BUS_TYPE[pBusType]
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetCoolerSettings(hPhysicalGpu := 0)
    {
        static NVAPI_MAX_COOLERS_PER_GPU := 20
        static NV_GPU_GETCOOLER_SETTINGS := 8 + (64 * NVAPI_MAX_COOLERS_PER_GPU)
        static NV_COOLER_TYPE := {0: "NONE", 1: "FAN", 2: "WATER", 3: "LIQUID_NO2"}
        static NV_COOLER_CONTROLLER := {0: "NONE", 1: "ADI", 2: "INTERNAL"}
        static NV_COOLER_POLICY := {0: "NONE", 1: "MANUAL", 2: "PERF", 4: "DISCRETE", 8: "CONTINUOUS_HW", 16: "CONTINUOUS_SW", 32: "DEFAULT"}
        static NV_COOLER_TARGET := {0: "NONE", 1: "GPU", 2: "MEMORY", 4: "POWER_SUPPLY", 7: "ALL"}
        static NV_COOLER_CONTROL := {0: "NONE", 1: "TOGGLE", 2: "VARIABLE"}
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        VarSetCapacity(pCoolerInfo, NV_GPU_GETCOOLER_SETTINGS, 0), NumPut(NV_GPU_GETCOOLER_SETTINGS | 0x30000, pCoolerInfo, 0, "UInt")
        if !(NvStatus := DllCall(NvAPI._GPU_GetCoolerSettings, "Ptr", hPhysicalGpu, "UInt", 7, "Ptr", &pCoolerInfo, "CDECL"))
        {
            CI := {}
            CI.version := NumGet(pCoolerInfo, 0, "UInt")
            CI.count   := NumGet(pCoolerInfo, 4, "UInt")
            Offset := 8
            loop % CI.count
            {
                CI[A_Index, "type"]            := (T := NV_COOLER_TYPE[NumGet(pCoolerInfo, Offset, "UInt")]) ? T : "UNKNOWN"
                CI[A_Index, "controller"]      := (C := NV_COOLER_CONTROLLER[NumGet(pCoolerInfo, Offset + 4, "UInt")]) ? C : "UNKNOWN"
                CI[A_Index, "defaultMinLevel"] := NumGet(pCoolerInfo, Offset + 8, "UInt")
                CI[A_Index, "defaultMaxLevel"] := NumGet(pCoolerInfo, Offset + 12, "UInt")
                CI[A_Index, "currentMinLevel"] := NumGet(pCoolerInfo, Offset + 16, "UInt")
                CI[A_Index, "currentMaxLevel"] := NumGet(pCoolerInfo, Offset + 20, "UInt")
                CI[A_Index, "currentLevel"]    := NumGet(pCoolerInfo, Offset + 24, "UInt")
                CI[A_Index, "defaultPolicy"]   := (P := NV_COOLER_POLICY[NumGet(pCoolerInfo, Offset + 28, "UInt")]) ? P : "UNKNOWN"
                CI[A_Index, "currentPolicy"]   := (P := NV_COOLER_POLICY[NumGet(pCoolerInfo, Offset + 32, "UInt")]) ? P : "UNKNOWN"
                CI[A_Index, "target"]          := (T := NV_COOLER_TARGET[NumGet(pCoolerInfo, Offset + 36, "UInt")]) ? T : "UNKNOWN"
                CI[A_Index, "controlType"]     := (C := NV_COOLER_CONTROL[NumGet(pCoolerInfo, Offset + 40, "UInt")]) ? C : "UNKNOWN"
                CI[A_Index, "active"]          := NumGet(pCoolerInfo, Offset + 44, "UInt")
                CI[A_Index, "speedRPM"]        := NumGet(pCoolerInfo, Offset + 48, "UInt")
                CI[A_Index, "bSupported"]      := NumGet(pCoolerInfo, Offset + 52, "UChar")
                CI[A_Index, "maxSpeedRPM"]     := NumGet(pCoolerInfo, Offset + 56, "UInt")
                CI[A_Index, "minSpeedRPM"]     := NumGet(pCoolerInfo, Offset + 60, "UInt")
                Offset += 64
            }
            return CI
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetCurrentAGPRate(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetCurrentAGPRate, "Ptr", hPhysicalGpu, "UInt*", pRate))
            return pRate
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetCurrentPCIEDownstreamWidth(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetCurrentPCIEDownstreamWidth, "Ptr", hPhysicalGpu, "UInt*", pWidth))
            return pWidth
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetCurrentPstate(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetCurrentPstate, "Ptr", hPhysicalGpu, "Int*", pCurrentPstate, "CDECL"))
            return pCurrentPstate
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetDynamicPstatesInfoEx(hPhysicalGpu := 0)
    {
        static NVAPI_MAX_GPU_UTILIZATIONS := 8
        static NV_GPU_UTILIZATION_DOMAIN_ID := ["GPU", "FB", "VID", "BUS"]
        static NV_GPU_DYNAMIC_PSTATES_INFO_EX := 8 + (8 * NVAPI_MAX_GPU_UTILIZATIONS)
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        VarSetCapacity(pDynamicPstatesInfoEx, NV_GPU_DYNAMIC_PSTATES_INFO_EX, 0), NumPut(NV_GPU_DYNAMIC_PSTATES_INFO_EX | 0x10000, pDynamicPstatesInfoEx, 0, "UInt")
        if !(NvStatus := DllCall(NvAPI._GPU_GetDynamicPstatesInfoEx, "Ptr", hPhysicalGpu, "Ptr", &pDynamicPstatesInfoEx, "CDECL"))
        {
            PSTATES := {}
            PSTATES.Enabled := NumGet(pDynamicPstatesInfoEx, 4, "UInt") & 1
            OffSet := 8
            for Index, Domain in NV_GPU_UTILIZATION_DOMAIN_ID
            {
                PSTATES[Domain, "bIsPresent"]  := NumGet(pDynamicPstatesInfoEx, Offset, "UInt") & 1
                PSTATES[Domain, "percentage"] := NumGet(pDynamicPstatesInfoEx, Offset + 4, "UInt")
                Offset += 8
            }
            return PSTATES
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetFullName(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        VarSetCapacity(szName, NvAPI.NVAPI_SHORT_STRING_MAX, 0)
        if !(NvStatus := DllCall(NvAPI._GPU_GetFullName, "Ptr", hPhysicalGpu, "Ptr", &szName, "CDECL"))
            return StrGet(&szName, "CP0")
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetGpuCoreCount(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetGpuCoreCount, "Ptr", hPhysicalGpu, "UInt*", pCount))
            return pCount
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetGPUType(hPhysicalGpu := 0)
    {
        static NV_GPU_TYPE := {0: "GPU_UNKNOWN", 1: "IGPU", 2: "DGPU"}
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetGPUType, "Ptr", hPhysicalGpu, "Int*", pGpuType, "CDECL"))
            return NV_GPU_TYPE[pGpuType]
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetIRQ(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetIRQ, "Ptr", hPhysicalGpu, "UInt*", pIRQ))
            return pIRQ
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetMemoryInfo(hPhysicalGpu := 0)
    {
        static NV_DISPLAY_DRIVER_MEMORY_INFO := 24
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        VarSetCapacity(pMemoryInfo, NV_DISPLAY_DRIVER_MEMORY_INFO, 0), NumPut(NV_DISPLAY_DRIVER_MEMORY_INFO | 0x20000, pMemoryInfo, 0, "UInt")
        if !(NvStatus := DllCall(NvAPI._GPU_GetMemoryInfo, "Ptr", hPhysicalGpu, "Ptr", &pMemoryInfo, "CDECL"))
        {
            MI := {}
            MI.version                          := NumGet(pMemoryInfo,  0, "UInt")
            MI.dedicatedVideoMemory             := NumGet(pMemoryInfo,  4, "UInt")
            MI.availableDedicatedVideoMemory    := NumGet(pMemoryInfo,  8, "UInt")
            MI.systemVideoMemory                := NumGet(pMemoryInfo, 12, "UInt")
            MI.sharedSystemMemory               := NumGet(pMemoryInfo, 16, "UInt")
            MI.curAvailableDedicatedVideoMemory := NumGet(pMemoryInfo, 20, "UInt")
            return MI
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetPerfDecreaseInfo(hPhysicalGpu := 0)
    {
        static NVAPI_GPU_PERF_DECREASE := {0: "NONE", 1: "REASON_THERMAL_PROTECTION", 2: "REASON_POWER_CONTROL", 4: "REASON_AC_BATT"
                                          ,8: "REASON_API_TRIGGERED", 16: "REASON_INSUFFICIENT_POWER", 2147483648: "REASON_UNKNOWN"}
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetPerfDecreaseInfo, "Ptr", hPhysicalGpu, "UInt*", pPerfDecrInfo, "CDECL"))
            return NVAPI_GPU_PERF_DECREASE[pPerfDecrInfo]
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetPhysicalFrameBufferSize(hPhysicalGPU := 0)
    {
        if !(hPhysicalGPU)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetPhysicalFrameBufferSize, "Ptr", hPhysicalGpu, "UInt*", pSize))
            return pSize
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetSystemType(hPhysicalGpu := 0)
    {
        static NV_SYSTEM_TYPE := {0: "UNKNOWN", 1: "LAPTOP", 2: "DESKTOP"}
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetSystemType, "Ptr", hPhysicalGpu, "Int*", pSystemType, "CDECL"))
            return NV_SYSTEM_TYPE[pSystemType]
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetTachReading(hPhysicalGPU := 0)
    {
        if !(hPhysicalGPU)
            hPhysicalGPU := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetTachReading, "Ptr", hPhysicalGPU, "UInt*", pValue, "CDECL"))
            return pValue
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetThermalSettings(hPhysicalGpu := 0)
    {
        static NVAPI_MAX_THERMAL_SENSORS_PER_GPU := 3
        static NV_GPU_THERMAL_SETTINGS := 8 + (20 * NVAPI_MAX_THERMAL_SENSORS_PER_GPU)
        static NV_THERMAL_CONTROLLER := {-1: "UNKNOWN", 0: "NONE", 1: "GPU_INTERNAL", 2: "ADM1032", 3: "MAX6649"
                                        , 4: "MAX1617", 5: "LM99", 6: "LM89", 7: "LM64", 8: "ADT7473", 9: "SBMAX6649"
                                        ,10: "VBIOSEVT", 11: "OS"}
        static NV_THERMAL_TARGET := {-1: "UNKNOWN", 0: "NONE", 1: "GPU", 2: "MEMORY", 4: "POWERSUPPLY", 8: "BOARD"
                                    , 9: "VCD_BOARD", 10: "VCD_INLET", 11: "VCD_OUTLET", 15: "ALL"}
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        VarSetCapacity(pThermalSettings, NV_GPU_THERMAL_SETTINGS, 0), NumPut(NV_GPU_THERMAL_SETTINGS | 0x20000, pThermalSettings, 0, "UInt")
        if !(NvStatus := DllCall(NvAPI._GPU_GetThermalSettings, "Ptr", hPhysicalGpu, "UInt", 15, "Ptr", &pThermalSettings, "CDECL"))
        {
            TS := {}
            TS.version := NumGet(pThermalSettings, 0, "UInt")
            TS.count   := NumGet(pThermalSettings, 4, "UInt")
            OffSet := 8
            loop % NVAPI_MAX_THERMAL_SENSORS_PER_GPU
            {
                TS[A_Index, "controller"]     := (C := NV_THERMAL_CONTROLLER[NumGet(pThermalSettings, Offset, "UInt")]) ? C : "UNKNOWN"
                TS[A_Index, "defaultMinTemp"] := NumGet(pThermalSettings, Offset +  4, "Int")
                TS[A_Index, "defaultMaxTemp"] := NumGet(pThermalSettings, Offset +  8, "Int")
                TS[A_Index, "currentTemp"]    := NumGet(pThermalSettings, Offset + 12, "Int")
                TS[A_Index, "target"]         := (T := NV_THERMAL_TARGET[NumGet(pThermalSettings, Offset + 16, "UInt")]) ? T : "UNKNOWN"
                OffSet += 20
            }
            return TS
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetUsages(hPhysicalGPU := 0)
    {
        static MAX_USAGES_PER_GPU := 33
        static NV_USAGES := 4 + (MAX_USAGES_PER_GPU * 4)
        if !(hPhysicalGPU)
            hPhysicalGPU := NvAPI.EnumPhysicalGPUs().1
        VarSetCapacity(currentUsage, NV_USAGES, 0), NumPut(NV_USAGES | 0x10000, currentUsage, 0, "UInt")
        if !(NvStatus := DllCall(NvAPI._GPU_GetUsages, "Ptr", hPhysicalGPU, "Ptr", &currentUsage, "CDECL"))
            return NumGet(currentUsage, 12, "UInt")
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetVbiosOEMRevision(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetVbiosOEMRevision, "Ptr", hPhysicalGpu, "UInt*", pBiosRevision))
            return pBiosRevision
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetVbiosRevision(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetVbiosRevision, "Ptr", hPhysicalGpu, "UInt*", pBiosRevision))
            return pBiosRevision
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetVbiosVersionString(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        VarSetCapacity(szBiosRevision, NvAPI.NVAPI_SHORT_STRING_MAX, 0)
        if !(NvStatus := DllCall(NvAPI._GPU_GetVbiosVersionString, "Ptr", hPhysicalGpu, "Ptr", &szBiosRevision, "CDECL"))
            return StrGet(&szBiosRevision, "CP0")
        return "*" NvStatus
    }

; ###############################################################################################################################

    GPU_GetVirtualFrameBufferSize(hPhysicalGpu := 0)
    {
        if !(hPhysicalGpu)
            hPhysicalGpu := NvAPI.EnumPhysicalGPUs().1
        if !(NvStatus := DllCall(NvAPI._GPU_GetVirtualFrameBufferSize, "Ptr", hPhysicalGpu, "UInt*", pSize))
            return pSize
        return "*" NvStatus
    }

; ###############################################################################################################################

    SetDVCLevel(level, outputId := 0)
    {
        hNvDisplay := NvAPI.EnumNvidiaDisplayHandle()
        return DllCall(NvAPI._SetDVCLevel, "Ptr", hNvDisplay, "UInt", outputId, "UInt", level, "CDECL")
    }

; ###############################################################################################################################

    SetDVCLevelEx(currentLevel, thisEnum := 0, outputId := 0)
    {
        static NV_DISPLAY_DVC_INFO_EX := 20
        hNvDisplay := NvAPI.GetAssociatedNvidiaDisplayHandle(thisEnum)
        VarSetCapacity(pDVCInfo, NV_DISPLAY_DVC_INFO_EX)
        , NumPut(NvAPI.GetDVCInfoEx(thisEnum).version,      pDVCInfo,  0, "UInt")
        , NumPut(currentLevel,                              pDVCInfo,  4, "Int")
        , NumPut(NvAPI.GetDVCInfoEx(thisEnum).minLevel,     pDVCInfo,  8, "Int")
        , NumPut(NvAPI.GetDVCInfoEx(thisEnum).maxLevel,     pDVCInfo, 12, "Int")
        , NumPut(NvAPI.GetDVCInfoEx(thisEnum).defaultLevel, pDVCInfo, 16, "Int")
        return DllCall(NvAPI._SetDVCLevelEx, "Ptr", hNvDisplay, "UInt", outputId, "Ptr", &pDVCInfo, "CDECL")
    }

; ###############################################################################################################################

    Stereo_IsEnabled()
    {
        if !(NvStatus := DllCall(NvAPI._Stereo_IsEnabled, "UChar*", pIsStereoEnabled, "CDECL"))
            return pIsStereoEnabled
        return "*" NvStatus
    }

; ###############################################################################################################################

    Stereo_IsWindowedModeSupported()
    {
        if !(NvStatus := DllCall(NvAPI._Stereo_IsWindowedModeSupported, "UChar*", bSupported, "CDECL"))
            return bSupported
        return "*" NvStatus
    }

; ###############################################################################################################################

    SYS_GetChipSetInfo()
    {
        static NV_CHIPSET_INFO := 40 + (3 * NvAPI.NVAPI_SHORT_STRING_MAX)
        VarSetCapacity(pChipSetInfo, NV_CHIPSET_INFO, 0), NumPut(NV_CHIPSET_INFO | 0x40000, pChipSetInfo, 0, "UInt")
        if !(NvStatus := DllCall(NvAPI._SYS_GetChipSetInfo, "Ptr", &pChipSetInfo, "CDECL"))
        {
            CSI := {}
            CSI.version            := NumGet(pChipSetInfo,     0, "UInt")
            CSI.vendorId           := NumGet(pChipSetInfo,     4, "UInt")
            CSI.deviceId           := NumGet(pChipSetInfo,     8, "UInt")
            CSI.szVendorName       := StrGet(&pChipSetInfo +  12, NvAPI.NVAPI_SHORT_STRING_MAX, "CP0")
            CSI.szChipsetName      := StrGet(&pChipSetInfo +  76, NvAPI.NVAPI_SHORT_STRING_MAX, "CP0")
            CSI.flags              := NumGet(pChipSetInfo,   140, "UInt")
            CSI.subSysVendorId     := NumGet(pChipSetInfo,   144, "UInt")
            CSI.subSysDeviceId     := NumGet(pChipSetInfo,   148, "UInt")
            CSI.szSubSysVendorName := StrGet(&pChipSetInfo + 152, NvAPI.NVAPI_SHORT_STRING_MAX, "CP0")
            CSI.HBvendorId         := NumGet(pChipSetInfo,   216, "UInt")
            CSI.HBdeviceId         := NumGet(pChipSetInfo,   220, "UInt")
            CSI.HBsubSysVendorId   := NumGet(pChipSetInfo,   224, "UInt")
            CSI.HBsubSysDeviceId   := NumGet(pChipSetInfo,   228, "UInt")
            return CSI
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    SYS_GetDriverAndBranchVersion()
    {
        VarSetCapacity(szBuildBranchString, NvAPI.NVAPI_SHORT_STRING_MAX, 0)
        if !(NvStatus := DllCall(NvAPI._SYS_GetDriverAndBranchVersion, "UInt*", pDriverVersion, "Ptr", &szBuildBranchString, "CDECL"))
        {
            DB := {}
            DB.pDriverVersion       := pDriverVersion
            DB.szBuildBranchString  := StrGet(&szBuildBranchString, "CP0")
            return DB
        }
        return "*" NvStatus
    }

; ###############################################################################################################################

    __Delete()
    {
        return DllCall(NvAPI._Unload, "CDECL")
    }

    OnExit()
    {
        DllCall("kernel32.dll\FreeLibrary", "Ptr", NvAPI.hmod)
    }
}