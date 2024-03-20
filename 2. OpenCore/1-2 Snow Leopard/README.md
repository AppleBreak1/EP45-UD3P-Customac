# Mac OS X Snow Leopard Installer
  - Snow Leopard Installer Version: 10.6.7-10J4139
  - Update to 10.6.8 V1.1 (10K549) after the installation
  - Install Security Update (2013-004)

# Hardwares

CPU : Intel Core 2 Quad Q9550

GPU: EVGA GeForce 9500 GT 1024MB DDR2 

RAM: G•SKIll DDR2 4GB x 4 (16GB)

Motherboard: EP45-UD3P Rev 1.1

BIOS revision: F10

Bluetooth: Asus USB-BT400 Bluetooth dongle (Patch required)

Wifi/BT Card: Fenvi FV-T919 (Not supported in Snow Leopard)

PCIe Card: Inateck KT5001 USB 3.0 PCIe Card (Not supported in Snow Leopard)

SSD: PNY CS900 250GB 


# OpenCore 

- Version 0.7.7

- ACPI

    ADD: DSDT.aml, SSDT-9500GT.aml, SSDT-EC-USBX.aml

    Quirks: FadtEnableReset -> Yes (This is required for restart to function properly)

- Booter

    Quirks: [RebuildAppleMemoryMap](https://dortania.github.io/OpenCore-Install-Guide/config.plist/penryn.html#quirks-2) -> Yes (This quirk is required to boot Snow Leopard)

- Kernel 
   
   Add:
   
     - VirtualSMC.kext
     - Lilu.kext, AppleALC.Kext, WhateverGreen.kext
     - AGPMInjector 9500GT.kext (AGPM injector for EVGA 9500 GT 10DE0640; modified for SMBIOS iMac10,1)
       
   Emulate:

     - DummyPowerManagement -> Yes (Resolves kernel panic "CPU x has no HPET assigned to it"; however, with HPET fix, this is not needed)
     
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
- Fresh install or an update from Leopard to Snow Leopard requires creating a install media.
- Note that SSDTs need to be compiled in ACPI4.0 compiler as Snow Leopard or older Mac OS do not support anything newer. Otherwise SSDT injection will fail.
- Upon booting after the successful installation of Mac OS X Snow Leopard, you will be greeted with good old intro music, instrumental version of the song "Exodus Honey" by Honeycut.
- Mac OS X Snow Leopard supports SSD Trim.
- Fenvi FV-T919 Wifi/BT PCIe card will not work in Snow Leopard. However, if the bluetooth mouse/keyboard have been paired with FV-T919 in newer macOS where it's supported, those paired keyboard/mouse may work in Snow Leopard with basic functionality.   
- Realteck RTL8111c ethernet is natively supported in Snow Leopard (Attaches to AppleRTL8169Ethernet.kext)
- To get Asus USB-BT400 bluetooth to work, [patch](https://www.tonymacx86.com/threads/need-bluetooth-4-0-get-it-here.56752/) the Info.plist of BroadcomUSBBluetoothHCIController.kext in S/L/E/IOBluetoothFamily.kext to inlcude device-id and vendor-id of the bluetooth dongle. 
- For hardware acceleration of EVGA 9500 GT (Supported from Leopard to High Sierra and is unofficially supported(No Metal) up to Ventura with the applicable patches)

  - You'll need to inject properties of the 9500 GT via SSDT, DSDT, or DeviceProperties which serves the same purpose as InjectNvidia for Clover BootLoader. Please refer to Dortania’s [Legacy Nvidia Patching](https://dortania.github.io/OpenCore-Post-Install/gpu-patching/nvidia-patching/#legacy-nvidia-patching)
guide for more details.

- Patching AGPMInjector.kext
     
     Only need to modify the Mac Model Identifier/VendorID/DeviceID
     
    <img width="568" alt="244578021-ee6d135f-9b1b-4416-ad5c-f74ed37a195b" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/ad3ed767-9cd5-4d55-b5ec-37e395fe54bc">


- Mounting EFI in Snow Leopard

    ~~~
    mkdir /Volumes/EFI
    sudo mount -t msdos /dev/diskXsY /Volumes/EFI
    ~~~
  
# Resources
- FakeSMC(2013-0315) with [HWMonitor](https://code.google.com/archive/p/os-x-fake-smc-kozlek/downloads) for Snow Leopard
- [Kext Helper b7](https://www.macintoshrepository.org/26602-kext-helper-b7) (Convenient tool for installing kext, fixing permission, and cache rebuilding)
- [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector) (May require to run the app in Mojave+)
- [Plist editor](https://www.fatcatsoftware.com/plisteditpro_downloads/) for Snow Leopard
- [Artic Fox](https://github.com/rmottola/Arctic-Fox/wiki/Downloads) (Web browser)
       

# Screenshots
<details> 
<summary>About This Mac</summary><img width="855" alt="244580121-f7e8285d-3ed7-4f40-b4b5-0a7fd0f62f18" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/d0453749-60ac-441c-9a4a-5520b54e4f87">
</details>  

<details> 
<summary>System Information</summary><img width="857" alt="244581667-a7112f5b-523c-40ae-8b1d-156f0c5f4924" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/1c6116d4-34b4-4091-a6a6-e714ac124785">
<img width="854" alt="244581675-289b89b8-4d6e-4230-94ac-8711da0f62ba" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/213a4723-9186-4f6c-8ba4-d5ff6444f5df">
<img width="855" alt="244581700-84b65d59-cbf0-4da1-8101-d721538b4bbf" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/f81d2f31-af2e-459c-9b58-3053bb5af057">
<img width="853" alt="244581902-282e262a-8e7b-49e2-a8b7-b97f78a3b243" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/045b20c8-4292-44b6-8f53-649d1c7f7801">
<img width="855" alt="244581952-1d590ddc-e0cf-4565-acd2-583998524662" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/171cfebf-2c64-4dea-8cde-57c5807e3228">
</details> 

<details>  
<summary>IORegistryExplorer</summary><img width="846" alt="244582734-443a9cbf-cdc0-4414-9607-1dd001b1f82d" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/79f2f17b-fbdb-426f-a564-fc2c0d5c88b8">
<img width="844" alt="244582743-518c9bca-58b4-4c0a-9ea4-16abc5f005ad" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/06fc05da-a7f7-467f-a591-a1070d33108c">
<img width="847" alt="244582750-a88c931b-cecb-4636-a3d8-6d25a6575593" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/74b3cfb8-f60b-4388-917b-0f50055849aa">
</details>  

