# Mac OS X Mountain Lion Installer
  - [Mountain Lion Installer](https://support.apple.com/kb/DL2076?locale=en_US) Version: 10.8.5(12F45)
  - Install Security Update 2015-006 (12F2560)

# Hardwares

CPU : Intel Core 2 Quad Q9550

GPU: EVGA GeForce GTX 770 2GB Superclocked 

RAM: G•SKIll DDR2 4GB x 4 (16GB)

Motherboard: EP45-UD3P Rev 1.1

BIOS revision: F10

Wifi/BT Card: Fenvi FV-T919 (Supported in Mountain Lion)

PCIe Card: Inateck KT5001 USB 3.0 PCIe Card (Supported in Mountain Lion)

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
     - [RealtekR1000SL.kext](https://www.insanelymac.com/forum/topic/286937-realtekr1000-v3/)

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
     
     - npci=0x2000 
     
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

EVGA GeForce GTX 770 hardware acceleration (Natively supported in Mountain Lion and the WebDriver is not a requirement)

Restart/Sleep/Shutdown

Sound/Ethernet/FireWire/Bluetooth



# Notes
- The famous FV-T919 WiFi/BT module is supported in Mac OS X Mountain Lion.
- Inateck KT5001 USB 3.0 PCIe Card (Fresco Logic FL1100 chipset) is supported in Mac OS X Mountain Lion.
- If booting to Mac OS X Lion 10.7.5 with GTX 770 to update to Mountain Lion, nv_disable=1 boot flag may be necessary to avoid black screen.
- When attempting to update with the [Mac OS X Mountain Lion Installer](https://support.apple.com/kb/DL2076?locale=en_US) from the Apple's official web, you may run into error message like below.

  ![244850877-f3dd4551-b9c3-4f7e-b918-fccc40cc4557](https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/4b96e5e5-071d-4906-ae4b-b9d79c93a4d0)

  To workaround this issue, you'll need to run the Install Mac OS X Mountain Lion.app in Install Mac OS X Mountain Lion.app/Contents/SharedSupport/InstallESD.dmg
  
- To make USB Installer, simply restore InstallESD.dmg to USB partition using Disk Utility.

- The built in Nvidia drivers of Mountain Lion may have screen tearing problems with 4K resolutions on displayport. To resolve this issue, installing Nvidia WebDriver is necessary. 

- To enable "HiDPI Display Mode" in Mountain Lion, run the below command in terminal (May need to logout and back in) 

          sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool YES;

- Patching AGPMInjector.kext
     
     Only need to modify the Mac Model Identifier/VendorID/DeviceID
     
    <img width="568" alt="244578021-ee6d135f-9b1b-4416-ad5c-f74ed37a195b" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/ad3ed767-9cd5-4d55-b5ec-37e395fe54bc">
    
- Mounting EFI in Mountain Lion

    ~~~
    mkdir /Volumes/EFI
    sudo mount -t msdos /dev/diskXsY /Volumes/EFI
    ~~~
    
  
# Resources
- FakeSMC.kext with plugins(2014-0121) from the RehabMan's [repo](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/). (FakeSMC sensors provide more readings on this legacy hardware)
- [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector) (May require to run the app in Mojave+)
- [Plist editor](https://www.fatcatsoftware.com/plisteditpro_downloads/) for Mountain Lion
- [Nvidia WebDriver](https://www.nvidia.com/download/driverResults.aspx/89537/en-us/) for Mountain Lion Build Version (12F2560) 
- [Cuda Driver](https://www.nvidia.com/en-us/drivers/cuda/macosx-cuda-6-5-51-driver/) for Mountain Lion
- [Artic Fox](https://github.com/rmottola/Arctic-Fox/wiki/Downloads) (Web browser)
       

# Screenshots
<details> 
<summary>About This Mac</summary><img width="762" alt="244852654-ea91e4f5-2c69-43f4-a3a2-45a7c1f8419b" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/de34d700-1d1d-4b86-8995-310c3432bec0">
</details>  

<details> 
<summary>System Information</summary><img width="1501" alt="244852672-c7e045de-b773-409d-ba66-b7f2d34a899b" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/9b99e276-f2c4-441d-bd98-0ac95d649d3e"><img width="1505" alt="244852696-f0b83dc4-ce72-41a0-9134-87cc21901c7f" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/24b7ee49-ff7c-4d48-9525-964bf3f55e7a">
<img width="1503" alt="244852701-4ee1e387-a5f5-4247-8477-18247f3276e4" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/7626f7a5-6cf9-4956-a139-8f2296751e58">
<img width="1503" alt="244852710-1f218884-4ef1-4ba8-bc7e-54a143329fd5" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/8bccefea-0b2f-4687-ac81-7e2d291b24eb">
</details> 

<details>  
<summary>Hardware Monitor</summary><img width="221" alt="244852829-409b1e9f-0b25-4497-b711-02a8cb9d8450" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/de95db70-2e78-4f79-846c-c9120fde0226">
</details>  

