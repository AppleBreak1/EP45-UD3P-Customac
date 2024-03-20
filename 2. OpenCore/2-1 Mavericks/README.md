# OS X Mavericks Installer
  - OS X Mavericks Version: 10.9.5(13F34)
  - Install Security Update 2016-004 (13F1911)

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

- Version 0.7.7

- ACPI

    ADD: DSDT.aml, SSDT-EC-USBX.aml, SSDT-GTX 770.aml

    Quirks: FadtEnableReset -> Yes (This is required for restart to function properly)

- Kernel 
   
   Add:
   
     - VirtualSMC.kext, SMCProcessor.kext, SMCSuperIO.kext
     - Lilu.kext, AppleALC.Kext, WhateverGreen.kext
     - AGPMInjector-GTX770.kext (AGPM injector for EVGA GTX 770 10DE1184; modified for SMBIOS iMac10,1)
     - [KT5001USBPorts.kext](https://github.com/AppleBreak1/EP45-UD3P-Customac/tree/main/5.%20Inateck%20KT5001%20PCIe%20USB%203.0%20Card) (USB port mapping for Inateck KT5001 PCIe USB Expansion Card)
     - [RealtekRTL8111.kext](https://github.com/Mieze/RTL8111_driver_for_OS_X) (Version 2.0.0)
    
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

     - npci=0x2000
     
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

EVGA GeForce GTX 770 hardware acceleration (Natively supported in Mavericks and the WebDriver is not a requirement)

Restart/Sleep/Shutdown

Sound/Ethernet/FireWire/Bluetooth



# Notes

- Due to certificate issues, you'll need to make USB Installer to install or update to OS X Mavericks and change the date in Mavericks Installer.
  
  - Making OS X Mavericks USB Installer
      
     - Copy "Install OS X Mavericks.app" to Application folder
     - Name the target USB volume to "MyVolume"
     - Run the below command in terminal
     
        ```shell
        sudo /Applications/Install\ OS\ X\ Mavericks.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ OS\ X\ Mavericks.app --nointeraction
        ```
  
  - Change the date in Mavericks Installer
     
     - Open the Terminal app when in GUI of the Installer then run the below command to change the date back to Jan of 2016
        
        ```shell
        date 010101012016
        ```
        
     - Once the date is set, proceed with the installation
     
 - Mounting EFI in OS X Mavericks

    ~~~
    diskutil mount /dev/diskXsY
    ~~~
        
# Resources
- FakeSMC.kext with plugins(2015-0317) from the RehabMan's [repo](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/). (FakeSMC sensors provide more readings on this legacy hardware)
- [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector) (May require to run the app in Mojave+)
- [Plist editor](https://www.fatcatsoftware.com/plisteditpro_downloads/) for Mavericks
- [Nvidia WebDriver](https://www.nvidia.com/download/driverresults.aspx/105609/en-us/) for Mavericks Build Version (13F1911) 
- [Cuda Driver](https://www.nvidia.com/en-us/drivers/cuda/macosx-cuda-7-5-30-driver/) for Mavericks



