<img width="1920" alt="Sonoma" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/3f1b2443-b04a-453b-ace3-74bbb2bd07a2">

# macOS Sonoma Installer

  - macOS Sonoma Beta (23A5301g)

Please have a read [here](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/1076) and [here](https://github.com/dortania/OpenCore-Legacy-Patcher/pull/1077) before attempting to install macOS Sonoma for experiment.


# Hardwares

CPU : Intel Core 2 Quad Q9550

GPU: EVGA GeForce GTX 770 2GB Superclocked 

RAM: G•SKIll DDR2 4GB x 4 (16GB)

Motherboard: EP45-UD3P Rev 1.1

BIOS revision: F10

Wifi/BT Card: Fenvi FV-T919 (Requires OCLP patch in macOS Sonoma)

PCIe Card: Inateck KT5001 USB 3.0 PCIe Card 

SSD: PNY CS900 250GB 


# OpenCore 

- Version 0.9.3

- ACPI

    ADD: DSDT.aml, SSDT-EC-USBX.aml, SSDT-GTX 770.aml

    Quirks: FadtEnableReset -> Yes (This is required for restart to function properly)

- Kernel 
   
   Add:
   
     - FakeSMC.kext, IntelCPUMonitor.kext, ITEIT87x.kext, GeforceSensor.kext ([FakeSMC3 with plugins](https://github.com/CloverHackyColor/FakeSMC3_with_plugins))
     - Lilu.kext, AppleALC.Kext, WhateverGreen.kext
     - AGPMInjector-GTX770.kext (AGPM injector for EVGA GTX 770 10DE1184; modified for SMBIOS iMac10,1)
     - [KT5001USBPorts.kext](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/5.%20Inateck%20KT5001%20PCIe%20USB%203.0%20Card) (USB port mapping for Inateck KT5001 PCIe USB Expansion Card)
     - [RealtekRTL8111.kext](https://github.com/Mieze/RTL8111_driver_for_OS_X) (Version 2.4.2)
     - [RestrictEvents.kext](https://github.com/acidanthera/RestrictEvents) (To [modify CPU processor name](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/7.%20Miscellaneous/Misc.md) in "About This Mac")
     - [telemetrap.kext](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/post-28447707) (Bypass SSE4.2 check; required for macOS Mojave+)
     - AppleMCEReporterDisabler.kext (Required when using iMacPro1,1 SMBIOS to boot Monterey 12.3.0+)
     - [ASPP-Override.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/ASPP-Override-v1.0.1.zip) (Necessary for proper CPU powermanagement in Monterey 12.3.0+)
     - [CryptexFixup.kext](https://github.com/acidanthera/CryptexFixup) (Forces Rosetta Cryptex installation and disables root hash validation; required for Ventura+ intallation) 
     - [AAAMouSSE.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/SSE/AAAMouSSE-v0.95-Dortania.zip) (Partial SSE4.2 Emulator; requirement for Ventura+; due to lack of SSE4.2, the kext is also required if using metal-compatible AMD GPUs in High Sierra+)
     - [NoAVXFSCompressionTypeZlib-AVXpel.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/commits/67a78ec4a275e0e8f8941a5ff9d64f00c28397dc/payloads/Kexts/Misc/NoAVXFSCompressionTypeZlib-v12.3.1.zip) (Resolves Zlib kernel panic; required for Ventura+)
     -  [AMFIPass.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/tree/main/payloads/Kexts/Acidanthera) (Allows to apply deeper root patches without disabling AMFI; [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) 0.6.6+ required)
     - [AppleIntelCPUPowerManagement.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/AppleIntelCPUPowerManagement-v1.0.0.zip) (Necessary for proper CPU powermanagement and speedstep in Ventura+)
     - [AppleIntelCPUPowerManagementClient.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/AppleIntelCPUPowerManagementClient-v1.0.0.zip) (Necessary for proper CPU powermanagement and speedstep in Ventura+)
     - [AppleUSBUHCI.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/USB/USB1.1-Injector-v1.0.0.zip) (Necessary for UHCI controllers(USB1.1) to work in Ventura; [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) root patch also required)
     - [AppleUSBUHCIPCI.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/USB/USB1.1-Injector-v1.0.0.zip) (Necessary for UHCI controllers(USB1.1) to work in Ventura; [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) root patch also required)

        Note: Injecting AppleUSBUHCI.kext and AppleUSBUHCIPCI.kext causes kernel panic in Sonoma 14.1+; thus, set MaxKernel to 23.0.0. The [OCLP 1.1.0n+](https://github.com/dortania/OpenCore-Legacy-Patcher/tree/d83f8ee38158c5b593361e7e15ab4707e7f48f21) applies USB1.1 patch directly to on-disk binaries for Sonoma 14.1+ as explained [here](https://github.com/dortania/OpenCore-Legacy-Patcher/commit/af575965599043e59b713f266f61ddb194a0e57c). 

     - [IOSkywalkFamily.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/e21efa975c0cf228cb36e81a974bc6b4c27c7807/payloads/Kexts/Wifi/IOSkywalkFamily-v1.0.0.zip) (Needed for Broadcom WiFi modules that lost support in macOS Sonoma. [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher/pull/1077#issuecomment-1646934494) patches also required)
     - [IO80211FamilyLegacy.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/e21efa975c0cf228cb36e81a974bc6b4c27c7807/payloads/Kexts/Wifi/IO80211FamilyLegacy-v1.0.0.zip) (Needed for Broadcom WiFi modules that lost support in macOS Sonoma. [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher/pull/1077#issuecomment-1646934494) patches also required)
     - AirPortBrcmNIC.kext (Included in IO80211FamilyLegacy.kext; needed for Broadcom WiFi modules that lost support in macOS Sonoma. [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher/pull/1077#issuecomment-1646934494) patches also required)
  
    Block:

     -  IOSkywalkFamily.kext (Blocking IOSkywalkFamily of macOS Sonoma+ is required to inject IOSkywalkFamily.kext from macOS Ventura which is needed for Broadcom WiFi modules that lost support in macOS Sonoma)
 
    Emulate:

     - DummyPowerManagement -> (Set to "No" if HPET fix is applied; set to "Yes" if HPET fix is NOT applied. This is used as a workaround to avoid kernel panic complaining about no HPETs available)
       
        - Note that in Ventura+, kernel panic or crash may still occur with DummyPowerManagment enabled which seems to be broken. (HPET fix is recommended)
         
    Quirks: 
     
     - DisableRtcChecksum -> Yes (This prevents BIOS from resetting on every restart or shutdown)
     - ExternalDiskIcons -> Yes (This resolves internal disk icons shown as external)
     - ThirdPartyDrives -> Yes (This enables the SSD Trim)
    
    Patch:
    
     - AppleAHCIPort patch (Addresses some hard drives not being recognized in High Sierra+; apply on needed basis) 
     
     - IOHIDFamily patch to fix HID(USB keyboard and mouse) devices not working in Big Sur +
     
- Misc
    
    Security: [SecureBootModel](https://dortania.github.io/OpenCore-Post-Install/universal/security/applesecureboot.html#dmgloading) -> Disabled
      
- Boot-args:

     - alcid=1 (Audio Layout ID for ALC889)
     
     - keepsyms=1 debug=0x100 -v
          
     - -no_compat_check (Bypass SMBIOS compatibility check; needed to boot Mojave+ with iMac10,1 SMBIOS)
     
     - agdpmod=vit9696 (Fix black screen issue on displayport when using iMac10,1; applies to Kepler series cards with displayport)    
     
     - -crypt_force_avx (Force Rosetta Cryptex)
      
     - amfi_get_out_of_my_way=1 (Disables AMFI; disabling Apple Mobile File Integrity is necessary to allow deeper root patchings)

        Update: Disabling AMFI is no longer necessary for root patching when [AMFIPass.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/releases/tag/0.6.8) is used.

     - -amfipassbeta or -lilubetaall (Necessary to enable AMFIPass on unsupported OS versions; with V1.4.0, this is no longer needed on Sonoma) 
       
- Drivers:

     - HfsPlusLegacy.efi

     - OpenCanopy.efi

     - OpenRuntime.efi

     - OpenUsbKbDxe.efi

     - UsbMouseDxe.efi

___

SMBIOS -> iMacPro1,1 (Selected for installation and update purpose; any Mac models supported in Sonoma will actually work)

SMBIOS -> iMac10,1 (For post installation; needed for the proper SpeedStep of Core2Duo or Core2Quad) 

UEFI -> Quirks -> ReleaseUsbOwnership -> Yes (Required for EHCI(USB2) controllers to load)


# Working

Native Apple CPU Power Management (Requires injecting kexts for AICPUPM in Ventura+)

Intel Core 2 Quad Q9550 SpeedStep

Native Apple GPU Power Management

EVGA GeForce GTX 770 hardware acceleration (Requires OCLP's Nvidia Kepler Graphics patch in Sonoma)

Restart/Sleep/Shutdown

Sound/Ethernet/FireWire/Bluetooth

AirDrop/Continuity/Handoff (Requires natively supported WiFi/BT card such as FV-T919)

AirplaytoMac / Universal Control (Requires natively supported WiFi/BT card such as FV-T919)


# Notes

- Early preview of macOS [Sonoma support](https://github.com/dortania/OpenCore-Legacy-Patcher/pull/1077#issuecomment-1646934494) of OCLP is now available

- As [noted](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/1076) by the OCLP developers, Apple removed support for IO80211FamilyLegacy stack which is responsible for supporting wireless cards used in Macs whose support have been ended in the previous macOS versions including Sonoma. This also impacts Fenvi FV-T919 card which uses BCM4360 chipset. To bring the support back, injection of [IOSkywalkFamily.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/tree/main/payloads/Kexts/Wifi), [IO80211FamilyLegacy.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/tree/main/payloads/Kexts/Wifi), and AirPortBrcmNIC.kext in order along with [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher/tree/main)'s Modern Wireless patch is necessary.
        
- Apple dropped support for non-AVX2.0 systems in Ventura+ so these systems can no longer boot the OS normally.  However, thanks to [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) developers, we can use [CryptexFixup.kext](https://github.com/acidanthera/CryptexFixup) to force the installer to install Rosetta Cryptex(pre-AVX2.0 dyld shared caches used by Apple Silicone Macs) so the CPUs with no AVX 2.0 can boot and install macOS Ventura+.

    Note: If for any reason installer did not install Rosetta Cryptex, it can also be done [manually](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/998#issuecomment-1163607808). Extract, rename, copy, and paste os.dmg file to /Volumes/Preboot/UUID/Cryptex1/Current of the target partition.

- Core2Quad or Core2Duo CPUs that support SSE4.1 require injecting [AAAMouSSE.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/SSE/AAAMouSSE-v0.95-Dortania.zip) and [NoAVXFSCompressionTypeZlib-AVXpel.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/commits/67a78ec4a275e0e8f8941a5ff9d64f00c28397dc/payloads/Kexts/Misc/NoAVXFSCompressionTypeZlib-v12.3.1.zip) to avoid kernel panic in Ventura+.
      
- UHCI/OHCI USB stack is removed from Ventura+. UHCI/OHCI is a USB1.1 controller where the USB keyboard/mouse get attached to for legacy systems. USB keyboard/mouse will not work in Ventura installer if they are plugged into any of the onboard USB ports. To install Ventura+ on this legacy system, use of PS2 keyboard/mouse or USB 2.0 Hub/PCIE USB 3.0 expansion card to force the keyboard/mouse be controlled by EHCI(USB2.0 controller) is required.

  Once the Ventura installation is complete, UHCI can be patched to work via [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) along with injection of [AppleUSBUHCI.kext and AppleUSBUHCIPCI.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/USB/USB1.1-Injector-v1.0.0.zip).    

  Note that injection of AppleUSBUHCI.kext and AppleUSBUHCIPCI.kext are only required from Ventura 13.0 to Sonoma 14.0 as injecting these kexts causes panic in Sonoma 14.1+ and beginning with the OCLP 1.1.0n, USB1.1 patch will be applied directly to on-disk bins. 

- Apple dropped AppleIntelCPUPowerManagement(AICPUPM) support for pre-Ivy Bridge CPUs in Ventura+. To get proper CPU powermanagement suppport back, injecting [AppleIntelCPUPowerManagement.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/AppleIntelCPUPowerManagement-v1.0.0.zip) and [AppleIntelCPUPowerManagementClient.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/AppleIntelCPUPowerManagementClient-v1.0.0.zip) is necessary. Thank you [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) developers.

- Using iMacPro1,1 to boot Monterey 12.3.0+ requires AppleMCEReporterDisabler.kext

- Beginning with macOS 12.3.0, Apple [dropped plugin-type check within X86PlatformPlugin](https://github.com/dortania/OpenCore-Legacy-Patcher/commit/f7f890d37e01b79d0926824ac424da897762431b#diff-802c4227abfb4a7ca54531b779674b82304a7d0b5e599f10ae5b91c1eea0fdbc)(X86PP). This leads X86PP to match onto Sandy Bridge and older CPUs resulting in improper CPU PowerManagement. [ASPP-Override.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/ASPP-Override-v1.0.1.zip) (An injector kext that increases IOProbeScore of ACPI_SMC_PlatformPlugin(ASPP) to outmatch X86PP and enforce ASPP) is required to resolve this issue.
        
- Nvidia GPU support is completely dropped in macOS Monterey+. The Kepler series GPUs require [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) patch to bring old Nvidia drivers back for hardware acceleration in Vetura+.        
        
- In macOS Big Sur+, IOHIDFamily patch may be necessary to resolve non-functional USB keyboard and mouse wired to UHCI(USB1.1)      
              
- Apple dropped support for iMac10,1 in macOS Mojave+. For update or installation purpose, use iMacPro1,1 SMBIOS. Once the installation is complete, revert back to iMac10,1 SMBIOS and add boot-arg -no_compat_check.

- Beginning with Mojave, SSE4.2 is required. However, this is not supported by Core2Quad or Core2Duo and is prevented from booting Mojave+. To bypass this, use the [telematrap](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/post-28447707) kext to block com.apple.telemetry.plugin in S/L/UserEventPlugins.


 
# Resources
- [FakeSMC3 with plugins](https://github.com/CloverHackyColor/FakeSMC3_with_plugins)(FakeSMC sensors provide more readings on this legacy hardware)
- [FakeSMC](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/) with HWMonitor.app (Requires keepsyms=1 flag to avoid bootloop booting macOS Ventura+)
- [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector)
- [OpenCore Legacy Patcher](https://github.com/dortania/OpenCore-Legacy-Patcher)
- [Bluesnooze](https://github.com/odlp/bluesnooze)(Workaround for avoiding issues with bluetooth during sleep/wake cycle)
- [MonitorControl](https://github.com/MonitorControl/MonitorControl) (Control display brightness and HDMI volume)
    
