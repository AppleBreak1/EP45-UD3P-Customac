# macOS Catalina Installer
  - macOS Catalina 10.15.7
  - [Install Security Update 2022-005](https://support.apple.com/kb/DL2094?locale=en_US) (19H2026)

# Hardwares

CPU : Intel Core 2 Quad Q9550

GPU: EVGA GeForce GTX 770 2GB Superclocked 

RAM: G•SKIll DDR2 4GB x 4 (16GB)

Motherboard: EP45-UD3P Rev 1.1

BIOS revision: F10

Wifi/BT Card: Fenvi FV-T919 

PCIe Card: Inateck KT5001 USB 3.0 PCIe Card 

SSD: PNY CS900 250GB 


# OpenCore

- Version 0.9.2

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

    Emulate:

     - DummyPowerManagement -> (Set to "No" if HPET fix is applied; set to "Yes" if HPET fix is NOT applied. This helps to resolve panic complaining about HPET)
       
    Quirks: 
     
     - DisableRtcChecksum -> Yes (This prevents BIOS from resetting on every restart or shutdown)
     - ExternalDiskIcons -> Yes (This resolves internal disk icons shown as external)
     - ThirdPartyDrives -> Yes (This enables the SSD Trim)
      
    Patch:
    
     - AppleAHCIPort patch (Addresses some hard drives not being recognized in High Sierra+; apply on needed basis) 
     
- Misc
    
    Security: [SecureBootModel](https://dortania.github.io/OpenCore-Post-Install/universal/security/applesecureboot.html#dmgloading) -> Disabled
      
- Boot-args:

     - alcid=1 (Audio Layout ID for ALC889)
     
     - keepsyms=1 debug=0x100 -v
     
     - darkwake=0 (Single-key wake from sleep)
     
     - -no_compat_check (Bypass SMBIOS compatibility check; needed to boot Mojave+ with iMac10,1 SMBIOS)
     
     - agdpmod=vit9696 (Fix black screen issue on displayport when using iMac10,1; applies to Kepler series cards with displayport) 
     
- Drivers:

     - HfsPlusLegacy.efi

     - OpenCanopy.efi

     - OpenRuntime.efi

     - OpenUsbKbDxe.efi

     - UsbMouseDxe.efi

___

SMBIOS -> iMacPro1,1 (Selected for installation and update purpose; any Mac models supported in Catalina will actually work)

SMBIOS -> iMac10,1 (For post installation; needed for the proper SpeedStep of Core2Duo or Core2Quad) 

UEFI -> APFS -> MinDate -> -1 (For booting macOS High Sierra ~ Catalina)

UEFI -> APFS -> MinVersion -> -1 (For booting macOS High Sierra ~ Catalina)

UEFI -> Quirks -> ReleaseUsbOwnership -> Yes (Required for EHCI(USB2) controllers to load)


# Working

Native Apple CPU Power Management

Intel Core 2 Quad Q9550 SpeedStep

Native Apple GPU Power Management

EVGA GeForce GTX 770 hardware acceleration (Natively supported in Catalina)

Restart/Sleep/Shutdown

Sound/Ethernet/FireWire/Bluetooth

Airdrop/Continuity/Handoff (Requires natively supported WiFi/BT card such as FV-T919)


# Notes

- Making macOS Catalina USB Installer

  - Copy "Install macOS Catalina.app" to Application folder

  - Name the target USB volume to "MyVolume"

  - Run the below command in terminal
  
        sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
       
- Apple dropped support for iMac10,1 in macOS Mojave+. For update or installation purpose, use iMacPro1,1 SMBIOS. Once the installation is complete, revert back to iMac10,1 SMBIOS and add boot-arg -no_compat_check.

- Beginning with Mojave, SSE4.2 is required. However, this is not supported by Core2Quad or Core2Duo and is prevented from booting Mojave+. To bypass this, use the [telematrap](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/post-28447707) kext to block com.apple.telemetry.plugin in S/L/UserEventPlugins.

- Enable GPU Tab in Activity Monitor in Catalina+ 
  
  To Enable

       defaults write com.apple.ActivityMonitor ShowGPUTab -bool true
       
  To Disable

        defaults write com.apple.ActivityMonitor ShowGPUTab -bool false
 
# Resources
- [FakeSMC3 with plugins](https://github.com/CloverHackyColor/FakeSMC3_with_plugins)(FakeSMC sensors provide more readings on this legacy hardware)
- [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector)



