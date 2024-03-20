# Introduction

This build is from 2008 that's turned into a Hackintosh since the release of Snow Leopard. I've done some maintenance here and there like the RAMs, Graphics cards, and the SSDs over those years but the system has been rock solid and have become one of my favorite toy. It is still capable of running up to macOS Sonoma thanks to those involved in making old hardware to run in up-to-date macOS. 

![BootPicker](https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/0aad9cf7-8eb7-4c5a-9b29-3a0d6f83cb36)


# Specs

CPU : Intel Core 2 Quad Q9550 @4.0GHz

GPU: EVGA GeForce GTX 770 2GB (Mountain Lion - Big Sur; patch required for Monterey+)

GPU: EVGA GeForce [9500 GT](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/7.%20Miscellaneous/Misc.md) 1024 MB DDR2 (Leopard - High Sierra; patch required for Mojave+)

GPU: ATI Radeon [HD 2400 Pro](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/7.%20Miscellaneous/Misc.md) 128MB DDR2 (Tiger ~ Leopard)

RAM: G•SKIll DDR2 4GB x 4 (16GB)

Motherboard: EP45-UD3P Rev 1.1

BIOS revision: F10

Wifi/BT Card: Fenvi FV-T919 (Mountain Lion - Ventura; patch required for Sonoma+)

PCIe Card: Inateck KT5001 USB 3.0 PCIe Card (Mountain Lion+)

WebCam: Logitech C920

SSD: PNY CS900 250GB (macOS Mojave)

SSD: PNY CS900 250GB (macOS Catalina, Big Sur, Monterey, Ventura, Sonoma)

SSD: PNY CS900 250GB (Windows 11)

# Working

Native CPU Power Management (AppleLPC, AppleHPET, SpeedStep)

Q9550 SpeedStep (Requires [patch](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/7.%20Miscellaneous/Misc.md) or emulate DummyPowerManagement)

GPU Power Management ([AGPM Injector](https://github.com/Pavo-IM/AGPMInjector))

Restart/Sleep/Shutdown (Requires _PTS patch to fix shutdown and restart on wake)

Wake on Lan / Wake for network access

iMessage / Facetime (Webcam required)

AirDrop/Continuity/Handoff (Requires natively supported WiFi/BT card such as FV-T919)

AirplaytoMac / Universal Control (Requires natively supported WiFi/BT card such as FV-T919)

Smooth 1440P VP9 Youtube Video playback

Mac OS: Tiger ~ macOS Sonoma (Installable)

# Not Working

DRM in Safari and TV+ (Workaround is to use iMacPro1,1 SMBIOS and pair with AMD Polaris GPUs which require injecting [MouSSE](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/)(SSE4.2 Emulator) for CPUs with no SSE 4.2 support) 

# BIOS Settings

**Run Load Optimized Defaults**

Drive A -> None

First Boot Device -> Hard Disk

Quick Boot -> Disabled (Required for macOS Big Sur+; otherwise, [Legacy CPU Core patch](https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/extended/kernel-issues.html#legacy-intel-users) may be necessary)

   * This prevents getting stuck on [EB|#LOG:EXITBS:START] in early stage of boot. 

Full Screen Logo Show -> Disabled (Only because I think it's tacky)

Init Display First -> PEG

ICH SATA Control Mode -> AHCI (Required)

Onboard H/W 1394 -> Enabled (May cause sleep issue if enabled. However the fix has been applied to the patched DSDT)

Onboard SATA/IDE Device -> Disabled (Better to disable if not used. It will only slow down the posting)

Onboard Serial Port 1 -> Disabled

Onboard Parallel Port -> Disabled

HPET Mode -> 64-bit mode (Required)

PME Event Wake Up -> Enabled (Required for Wake on Lan feature to power on the system via ethernet)

CPU Smart Fan Control -> Enabled

CPU Smart Fan Mode -> Voltage

Note: Three important settings are AHCI, HPET 64-bit mode, and disabling Quick Boot option(For Big Sur+). However, it is recommended to disable settings that are not used to avoid any possible conflicts that may occur and also to save resources.

# Hardware Limitations

- The processors that do not support SSE4.1 instruction set are limited to EL Capitan installation.
- Although this does not apply to this motherboard, it is worth mentioning that the ICHx chipsets with no AHCI support is limited to Mojave installation as the AppleIntelPIIXATA.kext have been removed from the macOS Catalina and no SATA drives will be shown in installer.

    Two Possible Workarounds: 
        
    - Inject the AppleIntelPIIXATA.kext from macOS Mojave (This may work for macOS Catalina and Big Sur)
    - Use compatible PCIe SATA expansion card (This depends on the availability of the PCIe slots on the motherboards and as the legacy BIOS does not support PCIe based booting, you'll still need to boot from the onboard SATA connected drive or from the USB drive EFI)


# Installing macOS

**All Mac OS Versions**

- Requires fixing HPET(_CRS, _STA) to load AppleHPET and resolve panic complaining "No HPETs available" in installation phase and also to avoid crashing on already installed Mac OS. Alternatively, DummyPowerManagement can be used from Mac OS X Tiger to macOS Monterey. 

**Tiger ~ High Sierra:** 

- The system is well supported. (To elaborate, no CPU-ID or SSE emulation required to install Mac OS)
- Booting Mac OS X Tiger/Leopard/Snow Leopard require RebuildAppleMemoryMap quirk and may require VirtualSMC as a SMC emulator.
- For ICH10 on macOS High Sierra+ may require [patching](https://applelife.ru/threads/ustanovka-macos-high-sierra-10-13-na-intel-pc.2210706/page-712#post-726313) AppleAHCIPort to resolve some hard disks not being recognized in High Sierra+ (Apply on needed basis)

**Mojave ~ Catalina:** 

- Beginning with Mojave, SSE4.2 is required. However, this is not supported by Core2Quad or Core2Duo and is prevented from booting Mojave+. To bypass this, use [telematrap](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/post-28447707) kext to block com.apple.telemetry.plugin in S/L/UserEventPlugins.

- Apple dropped support for iMac10,1 in macOS Mojave+. For update or installation purpose, use iMacPro1,1 SMBIOS. Once the installation is complete, revert back to iMac10,1 SMBIOS and add boot-arg -no_compat_check.
      
**Big Sur:**

- For Big Sur, offline macOS installation requires functioning NVRAM. Easiest way to jump over this hurdle is to install using [Online Method]( https://dortania.github.io/OpenCore-Install-Guide/installer-guide/mac-install-recovery.html). Note that this method requires internet connection.  For offline installation, refer to this [guide](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/7.%20Miscellaneous/Offline%20Installation%20Method%20for%20Big%20Sur.md).

- HID devices(USB Keyboard or Mouse) may not function. IOHIDFamily.Kext patch may be needed.
  
- For random hangs on boot, [SurPlus patch](https://github.com/reenigneorcim/SurPlus) may be necessary to resolve the issue.

**Monterey**

- Beginning with macOS 12.3.0, Apple [dropped plugin-type check within X86PlatformPlugin](https://github.com/dortania/OpenCore-Legacy-Patcher/commit/f7f890d37e01b79d0926824ac424da897762431b#diff-802c4227abfb4a7ca54531b779674b82304a7d0b5e599f10ae5b91c1eea0fdbc)(X86PP). This leads X86PP to match onto Sandy Bridge and older CPUs resulting in improper CPU PowerManagement. [ASPP-Override.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/ASPP-Override-v1.0.1.zip) (An injector kext that increases IOProbeScore of ACPI_SMC_PlatformPlugin(ASPP) to outmatch X86PP and enforce ASPP) is required to resolve this issue.


- Using iMacPro1,1 to boot Monterey 12.3.0+ requires AppleMCEReporterDisabler.kext

- Nvidia GPU support is completely dropped from the macOS Monterey. The Kepler series GPUs require [Kepler Patcher](https://github.com/chris1111/Geforce-Kepler-patcher) or [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) patch to bring old Nvidia drivers back for hardware acceleration.

**Ventura**

- Apple dropped support for non-AVX2.0 systems in Ventura+ so these systems can no longer boot the OS normally.  However, thanks to [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) developers, we can use [CryptexFixup.kext](https://github.com/acidanthera/CryptexFixup) to force the installer to install Rosetta Cryptex(pre-AVX2.0 dyld shared caches used by Apple Silicone Macs) so the CPUs with no AVX 2.0 can boot and install macOS Ventura+.

    Note: If for any reason installer did not install Rosetta Cryptex, it can also be done [manually](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/998#issuecomment-1163607808). Extract, rename, copy, and paste os.dmg file to /Volumes/Preboot/UUID/Cryptex1/Current of the target partition.

- Core2Quad or Core2Duo CPUs that support SSE4.1 require injecting [AAAMouSSE.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/SSE/AAAMouSSE-v0.95-Dortania.zip) and [NoAVXFSCompressionTypeZlib-AVXpel.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/commits/67a78ec4a275e0e8f8941a5ff9d64f00c28397dc/payloads/Kexts/Misc/NoAVXFSCompressionTypeZlib-v12.3.1.zip) to avoid kernel panic in Ventura+.
      
- UHCI/OHCI USB stack is removed from Ventura+. UHCI/OHCI is a USB1.1 controller where the USB keyboard/mouse get attached to for legacy systems. USB keyboard/mouse will not work in Ventura installer if they are plugged into any of the onboard USB ports. To install Ventura+ on this legacy system, use of PS2 keyboard/mouse or USB 2.0 Hub/PCIE USB 3.0 expansion card to force the keyboard/mouse be controlled by EHCI(USB2.0 controller) is required.

  Once the Ventura installation is complete, UHCI can be patched to work via [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) along with injection of [AppleUSBUHCI.kext and AppleUSBUHCIPCI.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/USB/USB1.1-Injector-v1.0.0.zip).    

- Apple dropped AppleIntelCPUPowerManagement support for pre-Ivy Bridge CPUs in Ventura+. To get proper CPU powermanagement suppport back, injecting [AppleIntelCPUPowerManagement.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/AppleIntelCPUPowerManagement-v1.0.0.zip) and [AppleIntelCPUPowerManagementClient.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/AppleIntelCPUPowerManagementClient-v1.0.0.zip) is necessary. Thank you [OCLP](https://github.com/dortania/OpenCore-Legacy-Patcher) developers.

**Sonoma**

- No additional requirements to install macOS Sonoma 14.0 for this hack on top of Ventura installation requirements. However, Apple did drop support for many Broadcom Wi-Fi modules in macOS Sonoma. For systems with these modules, please refer to this [note](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/2.%20OpenCore/4-4%20Sonoma/README.md#notes).

- Injecting AppleUSBUHCI.kext and AppleUSBUHCIPCI.kext to bring back USB1.1 functionality causes kernel panic in Sonoma 14.1+; thus, set MaxKernel to 23.0. The [OCLP 1.1.0n+](https://github.com/dortania/OpenCore-Legacy-Patcher/tree/d83f8ee38158c5b593361e7e15ab4707e7f48f21) applies USB1.1 patch directly to on-disk binaries for Sonoma 14.1+ as explained [here](https://github.com/dortania/OpenCore-Legacy-Patcher/commit/af575965599043e59b713f266f61ddb194a0e57c).

# Misc

[DSDT Fixes:](https://www.insanelymac.com/forum/topic/192518-dsdt-fixes-for-gigabyte-boards/)

- Compiler errors and warnings

- HPET (Necessary to resolve kernel panic - reboot/crash/etc; alternatively, you may use DummyPowerManagement)

- RTC, IPIC, TIMR IRQ fixes

- Shutdown/Restart/Sleep 

- Various device renames

- Added SBUS and missing bridges and devices such as PEG0, PEG1, PEGP, FRWR, GIGE, and etc.

- USB2.0 Power fix

- FakeLPC (To load AppleLPC)

- Intel Q9550 C State and P State scope. (Even the same model of CPU can have different FID and VID values. Recommended to generate your own following the [guide](https://www.insanelymac.com/forum/topic/181631-dsdt-vanilla-speedstep-generic-scope-_pr/)

- Removal of unused devices such as SPKR, FDC0, ECP1, LPT1


Intel SpeedStep:

As listed in OpenCore's shortcomings [here](https://dortania.github.io/OpenCore-Install-Guide/why-oc.html#opencore-features), OpenCore does not support Cstate and Pstate generation for older CPUs. However, while it does not generate C/P States, it does provide some degree of SpeedStep by enabling emulate DummyPowerManagement.   

- Options for enabling SpeedStep

     - Follow the  [Vanilla SpeedStep Guide](https://www.insanelymac.com/forum/topic/181631-dsdt-vanilla-speedstep-generic-scope-_pr/) and inject the scope via DSDT or SSDT 
  
     - Inject [Clover generated](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/7.%20Miscellaneous/Misc.md) CpuPm and CpuCst tables

     - Use Emulate DummyPowerManagement option in OpenCore
   
     - Use Clover Bootloader (Generate P State C State option)

Q9550 @4.0GHz
<img width="1920" alt="Screen Shot 2023-07-07 at 9 39 47 PM" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/3ea76605-a57e-4137-9c5a-17c6ff0db0ca">
<Br>

Pairing with AMD RX 580:

- Core2Quad CPUs are not capable of decoding 4K HEVC format videos. It will most likely stutter and become unwatchable. However, with the RX 460 ~ RX 590 being able to decode 4K HEVC, it can breathe more life into such an old system when paired.

  Requirements:

  -Must be on macOS Mojave 10.4.4 or higher (For hardware decoding capability)
  
  -[Mousse](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/) (This partial SSE4.2 emulator is required as macOS AMD metal driver asks for SSE4.2 since High Sierra otherwise drivers will not load results in a black screen) 

# GeekBench
<img width="1198" alt="geekbench" src="https://user-images.githubusercontent.com/97265013/181845217-1af38543-cfc5-4383-b9d2-5e28dd2d0fb9.png">


