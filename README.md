# Introduction

This build is from 2008 that's turned into a Hackintosh since the release of Snow Leopard. It's been nearly 13 years. Sure, I've done some maintenance here and there like the RAMs, Graphics card, and the SSDs over those years but the system has been rock solid for many years and have become one of my favorite toy. It is still capable of running up to macOS Monterey thanks to those involved in making old hardware to run in uptodate macOS. ~~However, with the release of macOS Ventura, we might witness the last nail in the coffin.~~ [Install macOS Ventura 13.0](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/Install%20macOS%20Ventura%2013.0/README.md)     

# EP45-UD3P-OPENCORE

![20052713](https://user-images.githubusercontent.com/97265013/185730948-b9d90a3c-899e-4709-84cd-086cab775067.png)

# Specs
CPU : Intel Core 2 Quad Q9550 @4.0GHz

GPU: EVGA GTX 770 2GB

RAM: GSKIll DDR2 4GB x 4 (16GB)

Motherboard: EP45-UD3P Rev 1.1

BIOS revision: F10

Wifi/BT Card: Fenvi FV-T919

PCIe Card: Inateck KT5001 USB 3.0 PCIe Card

WebCam: Logitech C920

SSD: PNY CS900 250GB (macOS Mojave)

SSD: PNY CS900 250GB (macOS Monterey)

SSD: PNY CS900 250GB (Windows 11)

# Working

Native CPU Power Management (AppleLPC)

Q9550 SpeedStep ([DSDT edits](https://www.insanelymac.com/forum/topic/181631-dsdt-vanilla-speedstep-generic-scope-_pr/))

GPU Power Management ([AGPM Injector](https://github.com/Pavo-IM/AGPMInjector))

Restart/Sleep/Shutdown (DSDT edit)

Wake on Lan / Wake for network access

iMessage / Facetime (WebCam Required)

AirDrop/Handoff/Continuity (Requires natively supported WiFi/BT card such as FV-T919)

AirplaytoMac / Universal Control (Requires natively supported WiFi/BT card such as FV-T919)

Upto 1440P VP9 Smooth Youtube Video playback

Boot time from Apple logo to desktop: 20 sec.

Working Mac OS: Snow Leopard ~ macOS Monterey 12.5.1

# Not Working

DRM in Safari and TV+ (Workaround is to use AMD GPU such as polaris variant with [MouSSE](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/) using SMBIOS iMacPro1,1)

# BIOS Settings

**Run Load Optimized Defaults**

Drive A -> None

First Boot Device -> Hard Disk

Quick Boot -> Disabled (Required for macOS Big Sur and Monterey)

Full Screen Logo Show -> Disabled

Init Display First -> PEG

ICH SATA Control Mode -> AHCI (Required)

Onboard H/W 1394 -> Disabled (May cause sleep issue if enabled, but the fix has been applied to DSDT)

Onboard SATA/IDE Device -> Disabled (Better to disable if not used. It will only slow down posting otherwise)

Onboard Serial Port 1 -> Disabled

Onboard Parallel Port -> Disabled

HPET Mode -> 64-bit mode (Required)

PME Event Wake Up -> Enabled (Required for Wake on Lan to power on computer via ethernet)

CPU Smart Fan Control -> Enabled

CPU Smart Fan Mode -> Voltage

Note: Three important settings are AHCI, HPET 64-bit mode, and disabling Quick Boot option. However, it is recommended to disable settings that are not used to avoid any possible conflicts that may occur and also to save resources.

# OpenCore Bootloader to Legacy System
Must install DuetPkg to EFI partition of Installer USB or macOS disk following the [guide](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/mac-install.html#legacy-setup)

# OpenCore 0.7.7 Key Config Setting
ACPI -> Quirks -> FadtEnableReset -> Yes (This is required for Restart to function property)

Booter -> Quirks -> Every Quirks here can be set to No

Kernel -> Patch -> I/O error fix for iCH10 and IOHIDFamily patch for HID(USB keyboard and mouse) devices not working in Big Sur or above

Kernel -> Quirks -> DisableRtcChecksum -> Yes (This prevents BIOS from resetting on every restart or shutdown)

Kernel -> Quirks -> ThirdPartyDrives -> Yes (This enables trim support)

Security -> SecureBootModel -> Disabled (Needed to boot to Catalina or older)

Boot-args

??? alcid=1 (Audio Layout ID)
  
??? -no_compat_check (Bypass SMBIOS compatibility check) 
  
??? agdpmod=vit9696 (Fixes Displayport blackscreen(iMac10,1) issue on Kepler cards from Catalina to Monterey) 
  
??? shiki-id=Mac-7BA5B2D9E42DDD94 (Fix JPG file not opening when using SMBIOS iMac10,1)
  
??? darkwake=0 (One Hit key wake from sleep)
  
SMBIOS -> iMac10,1 (Needed for Core2Quad or Core2Duo CPUs's proper SpeedStep)

UEFI -> APFS -> MinDate -> -1 (Required for booting into older macOS Catalina or older)

UEFI -> APFS -> MinVersion -> -1 (Required for booting into older macOS Catalina or older)

UEFI -> Quirks -> ReleaseUsbOwnership -> Yes (Required for EHCI(USB2) controllers to load)

# ACPI

DSDT.aml (Patched EP45-UD3P DSDT)

SSDT-EC-USBX

# Kexts

[FakeSMC3 with Plugins](https://github.com/CloverHackyColor/FakeSMC3_with_plugins)

AGPMInjector.kext (Generated by [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector))

Lilu.kext

AppleALC.kext

WhateverGreen.Kext

RealtekRTL8111.Kext

[telematrap.kext](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/post-28447707)  (Required for macOS Mojave or higher)

# Drivers

HfsPlusLegacy.efi

OpenCanopy.efi

OpenRuntime.efi

OpenUsbKbDxe.efi

UsbMouseDxe.efi


# Installing macOS

**Snow Leopard ~ High Sierra:** 

- System is natively supported and works without any tweaks.

**Mojave ~ Catalina:** 

- Beginning with Mojave, it requires SSE4.2 instruction which is not supported by Core2Quad or Core2Duo. To bypass this check, use [telematrap](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/post-28447707) kext.

- Apple dropped support for iMac10,1 in macOS Mojave. For an update or installation purposes, use iMacPro1,1 SMBIOS. Once the installation is complete revert back to iMac10,1 SMBIOS adding boot-arg -no_compat_check.


**Big Sur:**

- Beginning with Big Sur, offline macOS installation requires functioning NVRAM. Easiest way to jump over this hurdle is to install using [Recovery Online installation Method]( https://dortania.github.io/OpenCore-Install-Guide/installer-guide/mac-install-recovery.html). Note that this method requires internet connection.  For offline installation, refer to this [guide](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/Offline%20Installation%20Method.md).

- HID devices(USB Keyboard or Mouse) may not function. IOHIDFamily.Kext patch may be needed.

**Monterey 12.3.0**

- Beginning with macOS 12.3.0, Apple [dropped plugin-type check and no longer match on to ACPI_SMC_PlatformPlugin](https://github.com/dortania/OpenCore-Legacy-Patcher/commit/f7f890d37e01b79d0926824ac424da897762431b#diff-802c4227abfb4a7ca54531b779674b82304a7d0b5e599f10ae5b91c1eea0fdbc) resulting in improper CPU PowerManagement for Pre-SandBridge CPUs.  [ASPP-Override.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/main/payloads/Kexts/Misc/ASPP-Override-v1.0.1.zip) is required to resolve this issue. (For update or installation of macOS, do not use this kext as it can lead to kernel panic. Use it once the installation or the update is complete)

- Using iMacPro1,1 SMBIOS may require AppleMCEReporterDisabler.kext.

- In macOS Monterey, GTX 770 or Kepler Variant Cards require [Kepler Patcher](https://github.com/chris1111/Geforce-Kepler-patcher) to get hardware acceleration.


# Extra

DSDT Fixes:

- Compiler Errors and Warnings

- HPET (Required otherwise will experience reboot within 1 minute into desktop)

- RTC, IPIC, TIMR IRQ fixes

- Shutdown/Restart/Sleep

- Various device renames

- Added SBUS and missing device such as PEG0, PEG1, FRWR.

- LPC device-id injection (To load AppleLPC)

- Intel Q9550 C/P State code injection. (Even the same model of CPU can have different code. Recommended to generate your own following the guide)

- Removed unused device such as SPKR, FDC0, ECP1, LPT1


Intel SpeedStep:
- OpenCore does not support Cstate and Pstate generation for older CPUs. To get speedstep working, [injection of C/P state code in DSDT](https://www.insanelymac.com/forum/topic/181631-dsdt-vanilla-speedstep-generic-scope-_pr/) is necessary.
  
- Alternative method is to use Clover generated CpuPm and CpuCst SSDTs.  However, I find using method described in the link above results in a better CPU temperature.

- If you want to have speedstep working but are not comfortable with either method described, You may use Clover Bootloader.

Q9550 @3.2GHz
<img width="1875" alt="Mojave-min" src="https://user-images.githubusercontent.com/97265013/181845167-ad13f857-598d-4ca2-ac8b-5512976e1da9.png">

Q9550 @4.0GHz
![Big Sur, overclocked to 4GHz-min](https://user-images.githubusercontent.com/97265013/181844891-75daaedb-7615-4c93-8a96-d050c9aff2a2.png)

Pairing with AMD RX 580:

- Core2Quad CPUs are not capable of decoding 4K HEVC format videos. It will most likely stutter and become unwatchable. However, with RX 460 ~ RX 590 being able to decode 4K HEVC, it can breath more life into such an old system.

  Requirements:

  -Must be on macOS Mojave 10.4.4 or higher (For hardware decoding capability)
  
  -[Mousse.Kext](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/) (SSE4.2 emulator is required as macOS AMD driver asks for SSE4.2 since High Sierra otherwise black screen) 

# GeekBench
<img width="1198" alt="geekbench" src="https://user-images.githubusercontent.com/97265013/181845217-1af38543-cfc5-4383-b9d2-5e28dd2d0fb9.png">


