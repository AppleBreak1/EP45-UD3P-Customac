  # EP45-UD3P-OPENCORE

- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/1-0%20Tiger) for Tiger
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/1-1%20Leopard) for Leopard
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/1-2%20Snow%20Leopard) for Snow Leopard
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/1-3%20Lion) for Lion
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/1-4%20Mountain%20Lion) for Mountain Lion
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/2-1%20Mavericks) for Mavericks
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/2-2%20Yosemite) for Yosemite
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/2-3%20El%20Capitan) for EL Capitan
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/3-1%20Sierra) for Sierra
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/3-2%20High%20Sierra) for High Sierra
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/3-3%20Mojave) for Mojave
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/3-4%20Catalina) for Catalina
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/4-1%20Big%20Sur) for Big Sur
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/4-2%20Monterey) for Monterey
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/4-3%20Ventura) for Ventura
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/4-4%20Sonoma) for Sonoma
- [EFI](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/2.%20OpenCore/All-In-One-EFI) All-In-One
# OpenCore for Legacy BIOS
Must install DuetPkg to EFI partition of Installer USB or macOS disk following the [guide](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/mac-install.html#legacy-setup)

# OpenCore

- ACPI

    ADD: DSDT.aml, SSDT-EC-USBX.aml

    Quirks: FadtEnableReset -> Yes (This is required for restart to function properly)

- Booter

    Quirks: [RebuildAppleMemoryMap](https://dortania.github.io/OpenCore-Install-Guide/config.plist/penryn.html#quirks-2) -> Yes (This quirk is required to boot Tiger ~ Snow Leopard)

- Kernel 
   
   Add:
   
     - [FakeSMC3.kext](https://github.com/CloverHackyColor/FakeSMC3_with_plugins), IntelCPUMonitor, ITEIT87x.kext, GeforceSensor.kext (SMC emulator and plugins)
     - VirtualSMC.kext, SMCProcessor.kext, SMCSuperIO.kext (SMC emulator and plugins)
     - Lilu.kext, AppleALC.Kext, WhatEverGreen.Kext
     - RealtekRTL8111.Kext (Ethernet)
     - [RealtekR1000SL.kext](https://www.insanelymac.com/forum/topic/286937-realtekr1000-v3/) (RTL8111c ethernet; use this kext as an alternative if there is an issue with RealtekRTL8111.kext)
     - [telemetrap.kext](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/post-28447707) (Bypass SSE4.2 check; required for macOS Mojave+)
     - [AAAMouSSE.kext](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/) (Partial SSE4.2 Emulator; requirement for Ventura+; due to lack of SSE4.2, the kext is also required if using metal-compatible AMD GPUs in High Sierra+)
       
          Note: For Ventura+, the [patched](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/post-31238533) version of [AAAMouSSE](https://github.com/dortania/OpenCore-Legacy-Patcher/tree/main/payloads/Kexts/SSE) must be used.
         
     - [CryptexFixup.kext](https://github.com/acidanthera/CryptexFixup) (Forces Rosetta Cryptex installation and disables root hash validation; required for Ventura+ intallation) 
     - [NoAVXFSCompressionTypeZlib-AVXpel.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/commits/67a78ec4a275e0e8f8941a5ff9d64f00c28397dc/payloads/Kexts/Misc/NoAVXFSCompressionTypeZlib-v12.3.1.zip) (Resolves Zlib kernel panic; required for Ventura+)
     - [ASPP-Override.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/ASPP-Override-v1.0.1.zip) (Necessary for proper CPU powermanagement in Monterey 12.3.0+)
     - [AppleIntelCPUPowerManagement.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/AppleIntelCPUPowerManagement-v1.0.0.zip) (Necessary for proper CPU powermanagement and speedstep in Ventura+)
     - [AppleIntelCPUPowerManagementClient.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/AppleIntelCPUPowerManagementClient-v1.0.0.zip) (Necessary for proper CPU powermanagement and speedstep in Ventura+)
     - [AppleUSBUHCI.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/USB/USB1.1-Injector-v1.0.0.zip) (Necessary for UHCI controllers(USB1.1) to work in Ventura; [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) root patch also required)
     - [AppleUSBUHCIPCI.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/USB/USB1.1-Injector-v1.0.0.zip) (Necessary for UHCI controllers(USB1.1) to work in Ventura; [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) root patch also required)
        
        Note: Injecting AppleUSBUHCI.kext and AppleUSBUHCIPCI.kext causes kernel panic in Sonoma 14.1+; thus, set MaxKernel to 23.0. The [OCLP 1.1.0n+](https://github.com/dortania/OpenCore-Legacy-Patcher/tree/d83f8ee38158c5b593361e7e15ab4707e7f48f21) applies USB1.1 patch directly to on-disk binaries for Sonoma 14.1+ as explained [here](https://github.com/dortania/OpenCore-Legacy-Patcher/commit/af575965599043e59b713f266f61ddb194a0e57c). 

     - [AMFIPass.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/tree/main/payloads/Kexts/Acidanthera) (Allows to apply OCLP root patches without disabling AMFI; [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) 0.6.6+ required)
     - [KT5001USBPorts.kext](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/Inateck%20KT5001%20PCIe%20USB%203.0%20Card) (USB port mapping for Inateck KT5001 PCIe USB Expansion Card; supported in Mountain Lion+)
     - AppleMCEReporterDisabler.kext (Required when using iMacPro1,1 SMBIOS to boot Monterey 12.3.0+)
     - [RestrictEvents.kext](https://github.com/acidanthera/RestrictEvents) (Optional;  can be used to modify CPU processor name in "About This Mac")
     - AGPMInjector-GTX770.kext (Apple Graphic PowerManagment for GTX 770 10DE1184; generated using [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector))
     - AGPMInjector 9500GT.kext (Apple Graphic PowerManagment for 9500 GT 10de0640)
     - AGPMInjectorHD2400.kext (Apple Graphic PowerManagment for ATI Radeon HD2400Pro 100294c3)
     - [Natit.kext](https://www.insanelymac.com/forum/topic/94090-how-to-ati-radeon-hd-2400-2600-2900-3850-3870-on-leopard/) (For ATI Radeon HD 2400 Pro hardware acceleration in Leopard)
     - [IOSkywalkFamily.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/e21efa975c0cf228cb36e81a974bc6b4c27c7807/payloads/Kexts/Wifi/IOSkywalkFamily-v1.0.0.zip) (Needed for Broadcom WiFi modules that lost support in macOS Sonoma. [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher/pull/1077#issuecomment-1646934494) patches also required)
     - [IO80211FamilyLegacy.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/e21efa975c0cf228cb36e81a974bc6b4c27c7807/payloads/Kexts/Wifi/IO80211FamilyLegacy-v1.0.0.zip) (Needed for Broadcom WiFi modules that lost support in macOS Sonoma. [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher/pull/1077#issuecomment-1646934494) patches also required)
     - AirPortBrcmNIC.kext (Included in IO80211FamilyLegacy.kext; needed for Broadcom WiFi modules that lost support in macOS Sonoma. [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher/pull/1077#issuecomment-1646934494) patches also required)
  
    Block:

     -  IOSkywalkFamily.kext (Blocking IOSkywalkFamily of macOS Sonoma+ is required to inject IOSkywalkFamily.kext from macOS Ventura which is needed for Broadcom WiFi modules that lost support in macOS Sonoma)
       
    Emulate:

     - DummyPowerManagement -> (Set to "No" if HPET fix is applied; set to "Yes" if HPET fix is NOT applied. This helps to resolve panic complaining about HPET)

          - Note that in Ventura+, kernel panic or crash may still occur with DummyPowerManagment enabled which seems to be broken. (HPET fix is recommended)
       
    Patch:
    
     - AppleAHCIPort patch (Addresses some hard drives not being recognized in High Sierra+; apply on needed basis)
     
     - IOHIDFamily patch to fix HID(USB keyboard and mouse) devices not working in Big Sur +
    
    Quirks: 
     
     - DisableRtcChecksum -> Yes (This prevents BIOS from resetting on every restart or shutdown)
     - ThirdPartyDrives -> Yes (This enables the SSD Trim in Snow Leopard+)
     - ExternalDiskIcons -> Yes (This resolves internal disk icons shown as external)

- Misc
    
    Security: [SecureBootModel](https://dortania.github.io/OpenCore-Post-Install/universal/security/applesecureboot.html#dmgloading) -> Disabled



- Boot-args:

     - alcid=1 (Audio Layout ID for ALC889)
  
     - -no_compat_check (Bypass SMBIOS compatibility check; needed to boot Mojave+ with iMac10,1 SMBIOS) 
  
     - agdpmod=vit9696 (Fixes displayport blackscreen(iMac10,1) issue for Kepler series cards in Catalina+) 
  
     - shiki-id=Mac-7BA5B2D9E42DDD94 (May resolve JPG file not opening or previewing when using SMBIOS iMac10,1; Use if necessary)
  
     - darkwake=0 (May be needed, if Single-key wake from sleep is desired; is broken in Big Sur+)
     
     - npci=0x2000 (May help to get past "PCI Configuration Begin" if stalled; use as necessary)

     - nvda_drv=1 (Needed for enabling Nvidia WebDrivers in El Capitan and older)
     
     - keepsyms=1 debug=0x100 -v
     
     - -crypt_force_avx (Force Rosetta Cryptex)
     
     - amfi_get_out_of_my_way=1 (Disables AMFI; disabling Apple Mobile File Integrity is necessary to allow deeper root patches)
        
         Update: This boot flag may not be necessary anymore with the release of [AMFIPass](https://github.com/dortania/OpenCore-Legacy-Patcher/releases/tag/0.6.8).kext
 
     
- Drivers:

     - HfsPlusLegacy.efi

     - OpenCanopy.efi

     - OpenRuntime.efi

     - OpenUsbKbDxe.efi

     - UsbMouseDxe.efi

___
  
SMBIOS -> iMac10,1 (Needed for the proper SpeedStep of Core2Quad or Core2Duo CPUs)

SMBIOS -> iMacPro1,1 or iMac19,1 (For Installation and update in Mojave+)

SMBIOS -> iMac7,1 (Needed to boot Mac OS X Tiger)

UEFI -> APFS -> [MinDate](https://dortania.github.io/OpenCore-Install-Guide/config.plist/penryn.html#apfs) -> -1 (No restriction; for booting macOS High Sierra ~ Catalina)

UEFI -> APFS -> [MinVersion](https://dortania.github.io/OpenCore-Install-Guide/config.plist/penryn.html#apfs) -> -1 (No restriction; For booting macOS High Sierra ~ Catalina)

UEFI -> Quirks -> ReleaseUsbOwnership -> Yes (Required for EHCI(USB2) controllers to load)

___

Intel SpeedStep:

As listed in OpenCore's shortcomings [here](https://dortania.github.io/OpenCore-Install-Guide/why-oc.html#opencore-features), OpenCore does not support Cstate and Pstate generation for older CPUs. However, while it does not generate C/P States, it does provide some degree of SpeedStep by enabling emulate DummyPowerManagement.    

- Options for enabling SpeedStep in OpenCore

     - Follow the  [Vanilla SpeedStep Guide](https://www.insanelymac.com/forum/topic/181631-dsdt-vanilla-speedstep-generic-scope-_pr/) and inject the scope via DSDT or SSDT 
  
     - Inject [Clover generated](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/7.%20Miscellaneous/Misc.md) CpuPm and CpuCst tables

     - Use Emulate DummyPowerManagement option in OpenCore
___
