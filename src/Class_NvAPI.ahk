; SCRIPT DIRECTIVES =========================================================================================================================================================

#Requires AutoHotkey v2.0-


; ===== NvAPI CORE FUNCTIONS ================================================================================================================================================

class NvAPI
{
	static NvDLL := (A_PtrSize = 8) ? "nvapi64.dll" : "nvapi.dll"
	static _Init := NvAPI.__Initialize()


	static __Initialize()
	{
		if !(this.hModule := DllCall("LoadLibrary", "Str", this.NvDLL, "Ptr"))
		{
			MsgBox("NvAPI could not be startet!`n`nThe program will exit!", A_ThisFunc)
			ExitApp
		}
		if (NvStatus := DllCall(DllCall(this.NvDLL "\nvapi_QueryInterface", "UInt", 0x0150E828, "CDecl UPtr"), "CDecl") != 0)
		{
			MsgBox("NvAPI initialization failed: [ " NvStatus " ]`n`nThe program will exit!", A_ThisFunc)
			ExitApp
		}
	}



	static __Delete()
	{
		DllCall(DllCall(this.NvDLL "\nvapi_QueryInterface", "UInt", 0xD22BDD7E, "CDecl UPtr"), "CDecl")
		if (this.hModule)
			DllCall("FreeLibrary", "Ptr", this.hModule)
	}



	static QueryInterface(NvID)
	{
		return DllCall(this.NvDLL "\nvapi_QueryInterface", "UInt", NvID, "CDecl UPtr")
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.EnumLogicalGPUs
	; //
	; // This function returns an array of logical GPU handles.
	; // Each handle represents one or more GPUs acting in concert as a single graphics device.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static EnumLogicalGPUs()
	{
		NvLogicalGpuHandle := Buffer(4 * Const.NVAPI_MAX_LOGICAL_GPUS, 0)
		if !(NvStatus := DllCall(this.QueryInterface(0x48B3EA59), "Ptr", NvLogicalGpuHandle, "UInt*", &GPUCount := 0, "CDecl"))
		{
			Enum := []
			loop GPUCount
			{
				Enum.Push(NumGet(NvLogicalGpuHandle, 4 * (A_Index - 1), "UInt"))   ; [OUT] One or more physical GPUs acting in concert (SLI)
			}
			return Enum
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.EnumNvidiaDisplayHandle
	; //
	; // This function returns the handle of the NVIDIA display specified by the enum index (thisEnum).
	; // The client should keep enumerating until it returns error.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static EnumNvidiaDisplayHandle(thisEnum := 0)
	{
		if !(NvStatus := DllCall(this.QueryInterface(0x9ABDD40D), "UInt", thisEnum, "Ptr*", &NvDisplayHandle := 0, "CDecl"))
		{
			return NvDisplayHandle   ; [OUT] Display Device driven by NVIDIA GPU(s) (an attached display)
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.EnumNvidiaUnAttachedDisplayHandle
	; //
	; // This function returns the handle of the NVIDIA unattached display specified by the enum index (thisEnum).
	; // The client should keep enumerating until it returns error.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static EnumNvidiaUnAttachedDisplayHandle(thisEnum := 0)
	{
		if !(NvStatus := DllCall(this.QueryInterface(0x20DE9260), "UInt", thisEnum, "Ptr*", &NvUnAttachedDisplayHandle := 0, "CDecl"))
		{
			return NvUnAttachedDisplayHandle   ; [OUT] Unattached Display Device driven by NVIDIA GPU(s)
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.EnumPhysicalGPUs
	; //
	; // This function returns an array of physical GPU handles.
	; // Each handle represents a physical GPU present in the system.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static EnumPhysicalGPUs()
	{
		NvPhysicalGpuHandle := Buffer(4 * Const.NVAPI_MAX_PHYSICAL_GPUS, 0)
		if !(NvStatus := DllCall(this.QueryInterface(0xE5AC921F), "Ptr", NvPhysicalGpuHandle, "UInt*", &GPUCount := 0, "CDecl"))
		{
			Enum := []
			loop GPUCount
			{
				Enum.Push(NumGet(NvPhysicalGpuHandle, 4 * (A_Index - 1), "UInt"))   ; [OUT] A single physical GPU
			}
			return Enum
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.EnumTCCPhysicalGPUs
	; //
	; // This function returns an array of physical GPU handles that are in TCC Mode.
	; // Each handle represents a physical GPU present in the system in TCC Mode.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static EnumTCCPhysicalGPUs()
	{
		NvPhysicalGpuHandle := Buffer(4 * Const.NVAPI_MAX_PHYSICAL_GPUS, 0)
		if !(NvStatus := DllCall(this.QueryInterface(0xD9930B07), "Ptr", NvPhysicalGpuHandle, "UInt*", &GPUCount := 0, "CDecl"))
		{
			Enum := []
			loop GPUCount
			{
				Enum.Push(NumGet(NvPhysicalGpuHandle, 4 * (A_Index - 1), "UInt"))   ; [OUT] A single physical GPU
			}
			return Enum
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.GetDisplayDriverVersion
	; //
	; // This function returns a struct that describes aspects of the display driver build.
	; // Do not use this function - it is deprecated in release 290. Instead, use NvAPI_SYS_GetDriverAndBranchVersion.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static GetDisplayDriverVersion(thisEnum := 0)
	{
		static NV_DISPLAY_DRIVER_VERSION := (3 * 4) + (2 * Const.NVAPI_SHORT_STRING_MAX)

		hNvDisplay := this.EnumNvidiaDisplayHandle(thisEnum)
		pVersion := Buffer(NV_DISPLAY_DRIVER_VERSION, 0)
		NumPut("UInt", NV_DISPLAY_DRIVER_VERSION | 0x10000, pVersion, 0)     ; [IN] version info
		if !(NvStatus := DllCall(this.QueryInterface(0xF951A4D1), "Ptr", hNvDisplay, "Ptr", pVersion, "CDecl"))
		{
			DriverVersion := Map()
			DriverVersion["version"]           := NumGet(pVersion, 0, "UInt")
			DriverVersion["drvVersion"]        := NumGet(pVersion, 4, "UInt")
			DriverVersion["bldChangeListNum"]  := NumGet(pVersion, 8, "UInt")
			DriverVersion["BuildBranchString"] := StrGet(pVersion.Ptr + 12, Const.NVAPI_SHORT_STRING_MAX, "CP0")
			DriverVersion["AdapterString"]     := StrGet(pVersion.Ptr + 76, Const.NVAPI_SHORT_STRING_MAX, "CP0")
			return DriverVersion
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.GetDVCInfo
	; //
	; // This function retrieves the Digital Vibrance Control (DVC) information of the selected display.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static GetDVCInfo(thisEnum := 0)
	{
		static NV_DISPLAY_DVC_INFO := (4 * 4)

		hNvDisplay := this.EnumNvidiaDisplayHandle(thisEnum)
		DVCInfo := Buffer(NV_DISPLAY_DVC_INFO, 0)
		NumPut("UInt", NV_DISPLAY_DVC_INFO | 0x10000, DVCInfo, 0)     ; [IN] version info
		if !(NvStatus := DllCall(this.QueryInterface(0x4085DE45), "Ptr", hNvDisplay, "UInt", outputId := 0, "Ptr", DVCInfo, "CDecl"))
		{
			DVC_INFO := Map()
			DVC_INFO["currentLevel"] := NumGet(DVCInfo,  4, "UInt")   ; [OUT] current DVC level
			DVC_INFO["minLevel"]     := NumGet(DVCInfo,  8, "UInt")   ; [OUT] min range level
			DVC_INFO["maxLevel"]     := NumGet(DVCInfo, 12, "UInt")   ; [OUT] max range level
			return DVC_INFO
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.GetDVCInfoEx
	; //
	; // This API retrieves the Digital Vibrance Control(DVC) information of the selected display.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static GetDVCInfoEx(thisEnum := 0)
	{
		static NV_DISPLAY_DVC_INFO_EX := (5 * 4)

		hNvDisplay := this.EnumNvidiaDisplayHandle(thisEnum)
		DVCInfo := Buffer(NV_DISPLAY_DVC_INFO_EX, 0)
		NumPut("UInt", NV_DISPLAY_DVC_INFO_EX | 0x10000, DVCInfo, 0)    ; [IN] version info
		if !(NvStatus := DllCall(this.QueryInterface(0x0E45002D), "Ptr", hNvDisplay, "UInt", outputId := 0, "Ptr", DVCInfo, "CDecl"))
		{
			DVC_INFO_EX := Map()
			DVC_INFO_EX["currentLevel"] := NumGet(DVCInfo,  4, "Int")   ; [OUT] current DVC level
			DVC_INFO_EX["minLevel"]     := NumGet(DVCInfo,  8, "Int")   ; [OUT] min range level
			DVC_INFO_EX["maxLevel"]     := NumGet(DVCInfo, 12, "Int")   ; [OUT] max range level
			DVC_INFO_EX["defaultLevel"] := NumGet(DVCInfo, 16, "Int")   ; [OUT] default DVC level
			return DVC_INFO_EX
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.GetErrorMessage
	; //
	; // This function converts an NvAPI error code into a null terminated string.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static GetErrorMessage(ErrorCode)
	{
		Desc := Buffer(Const.NVAPI_SHORT_STRING_MAX, 0)
		DllCall(this.QueryInterface(0x6C2D048C), "Ptr", ErrorCode, "Ptr", Desc, "CDecl")
		return "Error: " StrGet(Desc, "CP0")
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.GetInterfaceVersionString
	; //
	; // This function returns a string describing the version of the NvAPI library.
	; // The contents of the string are human readable. Do not assume a fixed format.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static GetInterfaceVersionString()
	{
		Desc := Buffer(Const.NVAPI_SHORT_STRING_MAX, 0)
		if !(NvStatus := DllCall(this.QueryInterface(0x01053FA5), "Ptr", Desc, "CDecl"))
		{
			return StrGet(Desc, "CP0")
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.SetDVCLevel
	; //
	; // This function sets the DVC level for the selected display.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static SetDVCLevel(level, thisEnum := 0)
	{
		DVC := this.GetDVCInfo(thisEnum)
		if (level < DVC["minLevel"]) || (level > DVC["maxLevel"])
		{
			MsgBox("DVCLevel should be within the range of min [" DVC["minLevel"] "] and max [" DVC["maxLevel"] "].", A_ThisFunc)
			return 0
		}

		hNvDisplay := this.EnumNvidiaDisplayHandle(thisEnum)
		if !(NvStatus := DllCall(this.QueryInterface(0x172409B4), "Ptr", hNvDisplay, "UInt", outputId := 0, "UInt", level, "CDECL"))
		{
			return level
		}

		return NvAPI.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: NvAPI.SetDVCLevelEx
	; //
	; // This API retrieves the Digital Vibrance Control(DVC) information of the selected display.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static SetDVCLevelEx(currentLevel, thisEnum := 0)
	{
		static NV_DISPLAY_DVC_INFO_EX := (5 * 4) 

		DVC := this.GetDVCInfoEx(thisEnum)
		if (currentLevel < DVC["minLevel"]) || (currentLevel > DVC["maxLevel"])
		{
			MsgBox("DVCLevel should be within the range of min [" DVC["minLevel"] "] and max [" DVC["maxLevel"] "].", A_ThisFunc)
			return 0
		}

		hNvDisplay := this.EnumNvidiaDisplayHandle(thisEnum)
		DVCInfo := Buffer(NV_DISPLAY_DVC_INFO_EX, 0)
		NumPut("UInt", NV_DISPLAY_DVC_INFO_EX | 0x10000, DVCInfo, 0)   ; [IN] version info
		NumPut("Int",  currentLevel, DVCInfo, 4)                       ; [IN] current DVC level
		if !(NvStatus := DllCall(this.QueryInterface(0x4A82C2B1), "Ptr", hNvDisplay, "UInt", outputId := 0, "Ptr", DVCInfo, "CDECL"))
		{
			return currentLevel
		}

		return NvAPI.GetErrorMessage(NvStatus)
	}

}



; ===== NvAPI GPU FUNCTIONS =================================================================================================================================================

class GPU extends NvAPI
{

	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: GPU.GetFullName
	; //
	; // This function retrieves the full GPU name as an ASCII string - for example, "Quadro FX 1400".
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static GetFullName(hPhysicalGpu := 0)
	{
		if !(hPhysicalGpu)
		{
			hPhysicalGpu := this.EnumPhysicalGPUs()[1]
		}
		Name := Buffer(Const.NVAPI_SHORT_STRING_MAX, 0)
		if !(NvStatus := DllCall(this.QueryInterface(0xCEEE8E9F), "Ptr", hPhysicalGpu, "Ptr", Name, "CDecl"))
		{
			return StrGet(Name, "CP0")
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: GPU.GetGpuCoreCount
	; //
	; // Retrieves the total number of cores defined for a GPU.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static GetGpuCoreCount(hPhysicalGpu := 0)
	{
		if !(hPhysicalGpu)
		{
			hPhysicalGpu := this.EnumPhysicalGPUs()[1]
		}
		if !(NvStatus := DllCall(this.QueryInterface(0xC7026A87), "Ptr", hPhysicalGpu, "UInt*", &Count := 0, "CDecl"))
		{
			return Count
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: GPU.GetMemoryInfo
	; //
	; // This function retrieves the available driver memory footprint for the specified GPU.
	; // If the GPU is in TCC Mode, only dedicatedVideoMemory will be returned.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static GetMemoryInfo(hPhysicalGpu := 0)
	{
		static NV_DISPLAY_DRIVER_MEMORY_INFO := (8 * 4)

		if !(hPhysicalGpu)
		{
			hPhysicalGpu := this.EnumPhysicalGPUs()[1]
		}
		MemoryInfo := Buffer(NV_DISPLAY_DRIVER_MEMORY_INFO, 0)
		NumPut("UInt", NV_DISPLAY_DRIVER_MEMORY_INFO | 0x30000, MemoryInfo, 0)                   ; [IN] version info
		if !(NvStatus := DllCall(this.QueryInterface(0x07F9B368), "Ptr", hPhysicalGpu, "Ptr", MemoryInfo, "CDecl"))
		{
			MEMORY_INFO := Map()
			MEMORY_INFO["dedicatedVideoMemory"]              := NumGet(MemoryInfo,  4, "UInt")   ; [OUT] physical framebuffer (in kb)
			MEMORY_INFO["availableDedicatedVideoMemory"]     := NumGet(MemoryInfo,  8, "UInt")   ; [OUT] available physical framebuffer for allocating video memory surfaces (in kb)
			MEMORY_INFO["systemVideoMemory"]                 := NumGet(MemoryInfo, 12, "UInt")   ; [OUT] system memory the driver allocates at load time (in kb)
			MEMORY_INFO["sharedSystemMemory"]                := NumGet(MemoryInfo, 16, "UInt")   ; [OUT] shared system memory that driver is allowed to commit for surfaces across all allocations (in kb)
			MEMORY_INFO["curAvailableDedicatedVideoMemory"]  := NumGet(MemoryInfo, 20, "UInt")   ; [OUT] current available physical framebuffer for allocating video memory surfaces (in kb)
			MEMORY_INFO["dedicatedVideoMemoryEvictionsSize"] := NumGet(MemoryInfo, 24, "UInt")   ; [OUT] total size of memory released as a result of the evictions (in kb)
			MEMORY_INFO["dedicatedVideoMemoryEvictionCount"] := NumGet(MemoryInfo, 28, "UInt")   ; [OUT] number of eviction events that caused an allocation to be removed from dedicated video memory to free GPU video memory to make room for other allocations.
			return MEMORY_INFO
		}

		return this.GetErrorMessage(NvStatus)
	}

}



; ===== NvAPI SYS FUNCTIONS =================================================================================================================================================

class SYS extends NvAPI
{

	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: SYS.GetChipSetInfo
	; //
	; // This function returns information about the system's chipset.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static GetChipSetInfo()
	{
		static NV_CHIPSET_INFO := (10 * 4) + (3 * Const.NVAPI_SHORT_STRING_MAX)

		ChipSetInfo := Buffer(NV_CHIPSET_INFO, 0)
		NumPut("UInt", NV_CHIPSET_INFO | 0x40000, ChipSetInfo, 0)                                                    ; [IN] version info
		if !(NvStatus := DllCall(this.QueryInterface(0x53DABBCA), "Ptr", ChipSetInfo, "CDecl"))
		{
			CHIPSET_INFO := Map()
			CHIPSET_INFO["vendorId"]         := NumGet(ChipSetInfo,        4, "UInt")                                ; [OUT] chipset vendor identification
			CHIPSET_INFO["deviceId"]         := NumGet(ChipSetInfo,        8, "UInt")                                ; [OUT] chipset device identification
			CHIPSET_INFO["VendorName"]       := StrGet(ChipSetInfo.Ptr +  12, Const.NVAPI_SHORT_STRING_MAX, "CP0")   ; [OUT] chipset vendor Name
			CHIPSET_INFO["ChipsetName"]      := StrGet(ChipSetInfo.Ptr +  76, Const.NVAPI_SHORT_STRING_MAX, "CP0")   ; [OUT] chipset device Name
			CHIPSET_INFO["flags"]            := NumGet(ChipSetInfo,      140, "UInt")                                ; [OUT] chipset info flags - obsolete
			CHIPSET_INFO["subSysVendorId"]   := NumGet(ChipSetInfo,      144, "UInt")                                ; [OUT] chipset subsystem vendor identification
			CHIPSET_INFO["subSysDeviceId"]   := NumGet(ChipSetInfo,      148, "UInt")                                ; [OUT] chipset subsystem device identification
			CHIPSET_INFO["SubSysVendorName"] := StrGet(ChipSetInfo.Ptr + 152, Const.NVAPI_SHORT_STRING_MAX, "CP0")   ; [OUT] subsystem vendor Name
			CHIPSET_INFO["HBvendorId"]       := NumGet(ChipSetInfo,      216, "UInt")                                ; [OUT] host bridge vendor identification
			CHIPSET_INFO["HBdeviceId"]       := NumGet(ChipSetInfo,      220, "UInt")                                ; [OUT] host bridge device identification
			CHIPSET_INFO["HBsubSysVendorId"] := NumGet(ChipSetInfo,      224, "UInt")                                ; [OUT] host bridge subsystem vendor identification
			CHIPSET_INFO["HBsubSysDeviceId"] := NumGet(ChipSetInfo,      228, "UInt")                                ; [OUT] host bridge subsystem device identification
			return CHIPSET_INFO
		}

		return this.GetErrorMessage(NvStatus)
	}



	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	; //
	; // FUNCTION NAME: SYS.GetDriverAndBranchVersion
	; //
	; // This API returns display driver version and driver-branch string.
	; //
	; ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	static GetDriverAndBranchVersion()
	{
		BuildBranchString := Buffer(Const.NVAPI_SHORT_STRING_MAX, 0)
		if !(NvStatus := DllCall(this.QueryInterface(0x2926AAAD), "UInt*", &DriverVersion := 0, "Ptr", BuildBranchString, "CDecl"))
		{
			DriverAndBranchVersion := Map()
			DriverAndBranchVersion["DriverVersion"]     := DriverVersion                      ; [OUT] driver version
			DriverAndBranchVersion["BuildBranchString"] := StrGet(BuildBranchString, "CP0")   ; [OUT] driver-branch string
			return DriverAndBranchVersion
		}

		return this.GetErrorMessage(NvStatus)
	}

}



; ===== NvAPI CONSTANTS =====================================================================================================================================================

class Const extends NvAPI
{
	static NVAPI_SHORT_STRING_MAX        := 64
	static NVAPI_MAX_LOGICAL_GPUS        := 64
	static NVAPI_MAX_PHYSICAL_GPUS       := 64
}



; ===========================================================================================================================================================================

class MapX extends Map {
	CaseSense := "Off"  ; should be dafault. change my mind.
	Default   := ""
}



; ===========================================================================================================================================================================