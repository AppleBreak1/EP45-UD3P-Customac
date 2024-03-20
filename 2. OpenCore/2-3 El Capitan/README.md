# OS X El Capitan Installer
  - [OS X El Capitan](https://support.apple.com/en-us/HT211683) 10.11.6(15G31)
  - Install Security Update 2018-004 (15G22010)

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
   
     - VirtualSMC.kext, SMCProcessor.kext, SMCSuperIO.kext
     - Lilu.kext, AppleALC.Kext, WhateverGreen.kext
     - AGPMInjector-GTX770.kext (AGPM injector for EVGA GTX 770 10DE1184; modified for SMBIOS iMac10,1)
     - [KT5001USBPorts.kext](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/5.%20Inateck%20KT5001%20PCIe%20USB%203.0%20Card) (USB port mapping for Inateck KT5001 PCIe USB Expansion Card)
     - [RealtekRTL8111.kext](https://github.com/Mieze/RTL8111_driver_for_OS_X) (Version 2.2.1)
     - [RestrictEvents.kext](https://github.com/acidanthera/RestrictEvents) (To [modify CPU processor name](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/7.%20Miscellaneous/Misc.md) in "About This Mac")

     Emulate:

     - DummyPowerManagement -> (Set to "No" if HPET fix is applied; set to "Yes" if HPET fix is NOT applied. This helps to resolve panic complaining about HPET)
    
    Quirks: 
     
     - DisableRtcChecksum -> Yes (This prevents BIOS from resetting on every restart or shutdown)
     - ExternalDiskIcons -> Yes (This resolves internal disk icons shown as external)
     - ThirdPartyDrives -> Yes (This enables the SSD Trim)

- Misc
    
    Security: [SecureBootModel](https://dortania.github.io/OpenCore-Post-Install/universal/security/applesecureboot.html#dmgloading) -> Disabled


- Boot-args:

     - alcid=1 (Audio Layout ID for ALC889)
     
     - keepsyms=1 debug=0x100 -v
     
     - darkwake=0 (Single-key wake from sleep)
     
     - nvda_drv=1 (Only needed if enabling Nvidia WebDrivers in macOS El Capitan and older)
 
     
- Drivers:

     - HfsPlusLegacy.efi

     - OpenCanopy.efi

     - OpenRuntime.efi

     - OpenUsbKbDxe.efi

     - UsbMouseDxe.efi

___

  
SMBIOS -> iMac10,1 (Needed for the proper SpeedStep of Core2Duo or Core2Quad) 

UEFI -> Quirks -> ReleaseUsbOwnership -> Yes (Required for EHCI(USB2) controllers to load)


# Working

Native Apple CPU Power Management

Intel Core 2 Quad Q9550 SpeedStep

Native Apple GPU Power Management

EVGA GeForce GTX 770 hardware acceleration (Natively supported in El Capitan and the WebDriver is not a requirement)

Restart/Sleep/Shutdown

Sound/Ethernet/FireWire/Bluetooth

Airdrop/Continuity/Handoff (Requires natively supported WiFi/BT card such as FV-T919)



# Notes

- Making OS X El Capitan USB Installer

  - Copy "Install OS X El Capitan.app" to Application folder

  - Name the target USB volume to "MyVolume"

  - Run the below command in terminal
  
        sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app
        
- Mounting EFI in OS X El Capitan

  ~~~
  diskutil mount /dev/diskXsY
  ~~~
        
# Resources
- FakeSMC3 with IntelCPUMonitor.kext, ITEIT87x.kext, GeforceSensor.kext plugin kexts [Release 240](https://github.com/CloverHackyColor/FakeSMC3_with_plugins/releases/tag/v240) (FakeSMC sensors provide more readings on this legacy hardware)
- [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector) (May require to run the app in Mojave+)
- [Nvidia WebDriver](https://www.nvidia.com/download/driverResults.aspx/136082/en-us/) for El Capitan Build Version (15G22010) 
- [Cuda Driver](https://www.nvidia.com/en-us/drivers/cuda/macosx-cuda-8-0-90-driver/) for El Capitan

# Screenshots


<details>  
<summary>HWMonitorSMC2 with FakeSMC3</summary><img width="367" alt="244970347-29679296-de9c-4e7c-b2e2-8ac008d6ffd1" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/a4ebba68-0473-4f64-b632-1c31b939e394">
</details>  

       


