# Mac OS X Lion Installer
  - [Lion Installer](https://support.apple.com/kb/DL2077?locale=en_US) Version: 10.7.5(11G63)
  - [OS X Lion 10.7.5 Combo Update](https://support.apple.com/kb/dl1582?locale=en_US)
  - [Install Security Update (2014-004)](https://support.apple.com/kb/dl1764?locale=en_US)

# Hardwares

CPU : Intel Core 2 Quad Q9550

GPU: EVGA 9500 GT 1024MB DDR2 

RAM: G•SKIll DDR2 4GB x 4 (16GB)

Motherboard: EP45-UD3P Rev 1.1

BIOS revision: F10

Bluetooth: Asus USB-BT400 Bluetooth dongle (Patch required)

Wifi/BT Card: Fenvi FV-T919 (Not supported in Lion)

PCIe Card: Inateck KT5001 USB 3.0 PCIe Card (Not supported in Lion)

SSD: PNY CS900 250GB 


# OpenCore 

- Version 0.7.7

- ACPI

    ADD: DSDT.aml, SSDT-9500GT.aml, SSDT-EC-USBX.aml

    Quirks: FadtEnableReset -> Yes (This is required for restart to function properly)

- Kernel 
   
   Add:
   
     - VirtualSMC.kext, SMCProcessor.kext, SMCSuperIO.kext
     - Lilu.kext, AppleALC.Kext, WhateverGreen.kext
     - [RealtekRTL8111.kext](https://github.com/Mieze/RTL8111_driver_for_OS_X) Version 1.2.3
     - AGPMInjector 9500GT.kext (AGPM injector for EVGA 9500 GT 10DE0640; modified for SMBIOS iMac10,1)
       
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
     
     - npci=0x2000 (May help to get past "PCI Configuration Begin" if stalled) 
 
     
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

EVGA 9500 GT hardware acceleration

Restart/Sleep/Shutdown

Sound/Ethernet/FireWire/Bluetooth 4.0



# Notes
- RebuildAppleMemoryMap quirk is no longer required beginning with Mac OS X Lion.
- When attempting to update with the [Mac OS X Lion Installer](https://support.apple.com/kb/DL2077?locale=en_US) from the Apple's official web, you may run into error message like below.

  ![244617893-55cb426d-933f-4bb6-b376-de5549727315](https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/7dc2bd6e-cd94-4f4a-8eed-57896f0768dd)
  
  To workaround this issue, first you'll need to change the system date back to July of 2011, then run the Install Mac OS X Lion.app in Install Mac OS X Lion.app/Contents/SharedSupport/InstallESD.dmg

- To make USB Installer, simply restore InstallESD.dmg to USB partition using Disk Utility.  
- AppleRTL8169Ethernet.kext is removed from the Mac OS X Lion. For ethernet, use [RealtekRTL8111.kext](https://github.com/Mieze/RTL8111_driver_for_OS_X) Version 1.2.3 which is included in version 2.2.1 package.
- Fenvi FV-T919 Wifi/BT PCIe card will not work in Lion. However, if the bluetooth mouse/keyboard have been paired with FV-T919 in newer macOS where it's supported, those paired keyboard/mouse may work in Lion with basic functionality.   
- To get Asus USB-BT400 bluetooth to work, [patch](https://www.tonymacx86.com/threads/need-bluetooth-4-0-get-it-here.56752/) the Info.plist of BroadcomUSBBluetoothHCIController.kext in S/L/E/IOBluetoothFamily.kext to inlcude device-id and vendor-id of the bluetooth dongle. 
- For hardware acceleration of EVGA 9500 GT (Supported from Leopard to High Sierra and is unofficially supported(No Metal) up to Ventura with the applicable patches)

  - You'll need to inject properties of the 9500 GT via SSDT, DSDT, or DeviceProperties which serves the same purpose as InjectNvidia for Clover BootLoader. Please refer to Dortania’s [Legacy Nvidia Patching](https://dortania.github.io/OpenCore-Post-Install/gpu-patching/nvidia-patching/#legacy-nvidia-patching)
guide for more details.

- Patching AGPMInjector.kext
     
     Only need to modify the Mac Model Identifier/VendorID/DeviceID
     
    <img width="568" alt="244578021-ee6d135f-9b1b-4416-ad5c-f74ed37a195b" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/ad3ed767-9cd5-4d55-b5ec-37e395fe54bc">

- Mounting EFI in Lion

    ~~~
    mkdir /Volumes/EFI
    sudo mount -t msdos /dev/diskXsY /Volumes/EFI
    ~~~
    
# Resources
- FakeSMC.kext with plugins(2014-0121) from the RehabMan's [repo](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/). (FakeSMC sensors provide more readings on this legacy hardware)
- [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector) (May require to run the app in Mojave+)
- [Plist editor](https://www.fatcatsoftware.com/plisteditpro_downloads/) for Lion
- [Artic Fox](https://github.com/rmottola/Arctic-Fox/wiki/Downloads) (Web browser)
       

# Screenshots
<details> 
<summary>About This Mac</summary><img width="894" alt="244628088-da4d211b-11f3-4ef2-bb15-edcf45fa32fa" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/4feeebee-bc52-4bc3-88ea-852cf7c08eb3">


</details>  

<details> 
<summary>System Information</summary><img width="1688" alt="244628895-eda0a884-156a-4850-ad71-63ab94cee20c" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/7661617e-5def-45cf-bf40-4b29222d54fa">
<img width="1690" alt="244628920-27c50417-c076-4267-ac3f-d8746413f790" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/236cbf05-4a38-4978-97fe-c4e83774bbd0">
<img width="1691" alt="244628941-5e0c789e-4c2e-44ad-acf2-8819fcde07bf" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/32521ad2-3925-4f01-be73-df7a361db4ff">
</details> 

<details>  
<summary>Hardware Monitor</summary><img width="219" alt="244629317-79cca54f-4f7e-4c73-b289-08c36da80ef6" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/76b27137-af36-4d40-93ef-4e5a24dd102d">

</details>  

