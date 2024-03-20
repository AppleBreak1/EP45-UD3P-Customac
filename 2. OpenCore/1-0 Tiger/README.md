# Mac OS X Tiger

![Picture 1](https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/a5d3c330-1586-499c-9627-0c6167705eb1)

# Mac OS X Tiger Installer
  - Tiger Installer 10.4.10 (8R4088)
  - Install [iMac Software Update 1.2.1 (Tiger)](https://support.apple.com/kb/DL179?locale=en_US)
  - Update to [10.4.11](https://support.apple.com/kb/dl172?locale=en_US) (8S2167) after the installation
  - Install [Security Update 2009-005](https://support.apple.com/kb/dl932?locale=en_US)

# Hardwares

CPU : Intel Core 2 Quad Q9550

GPU: ATI Radeon HD 2400 Pro 128MB DDR2 (Tiger ~ Leopard)

RAM: G•SKIll DDR2 4GB x 4 (16GB)

Motherboard: EP45-UD3P Rev 1.1

BIOS revision: F10

Bluetooth: Asus USB-BT400 Bluetooth dongle (Patch required)

WiFi: Netgear WG111V2 Wiress USB Adapter 

SSD: PNY CS900 250GB 


# OpenCore 

- Version 0.7.7

- ACPI

    ADD: DSDT.aml, SSDT-EC-USBX.aml,

- Booter

    Quirks: [RebuildAppleMemoryMap](https://dortania.github.io/OpenCore-Install-Guide/config.plist/penryn.html#quirks-2) -> Yes (This quirk is required to boot Tiger)

- Kernel 
   
   Add:
   
     - VirtualSMC.kext
     - Lilu.kext
     - AppleALC.Kext
     - AppleRTL8169Ethernet.kext (Remove this kext from /System/Library/Extensions/ if injecting via OpenCore)
  
   Emulate:

     - DummyPowerManagement -> (Set to "No" if HPET fix is applied; set to "Yes" if HPET fix is NOT applied. This helps to resolve panic complaining about HPET)
       
   Quirks: 
     
     - DisableRtcChecksum -> Yes (This prevents BIOS from resetting on every restart or shutdown)
     - ExternalDiskIcons -> Yes (This resolves internal disk icons shown as external)

- Misc
    
    Security: [SecureBootModel](https://dortania.github.io/OpenCore-Post-Install/universal/security/applesecureboot.html#dmgloading) -> Disabled

- Boot-args:

     - alcid=1 (Audio Layout ID for ALC889)
     
     - keepsyms=1 debug=0x100 -v
           
- Drivers:

     - HfsPlusLegacy.efi

     - OpenCanopy.efi

     - OpenRuntime.efi

     - OpenUsbKbDxe.efi

     - UsbMouseDxe.efi

___

  
SMBIOS -> iMac7,1 (Necessary for booting Mac OS X Tiger 10.4.10) 

UEFI -> Quirks -> ReleaseUsbOwnership -> Yes (Required for EHCI(USB2) controllers to load)


# Working

Native Apple CPU Power Management

Intel Core 2 Quad Q9550 SpeedStep

ATI Radeon HD 2400 Pro hardware acceleration with VGA port (works up to Leopard 10.5.8)

Shutdown

Sound/Ethernet/WiFi/FireWire/Bluetooth 4.0

# Notes
- Use iMac7,1 SMBIOS
- To load AppleLPC, inject pci8086,27b9 (ICH7) as name property under ISA bridge for IONameMatching. (via DSDT,SSDT, or DeviceProperties)
  
  - Example
    
      <img width="493" alt="Screenshot 2023-07-01 at 10 43 55 AM" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/7c42b50f-5ebb-444f-ba1c-16418fd70745">

- Realteck RTL8111c ethernet does not work with native AppleRTL8169Ethernet.kext in Tiger (To get it working, extract AppleRTL8169Ethernet.kext from [here](https://us.driverscollection.com/?file_cid=396380461620ab7f574c8ba97fc); install it in /System/Library/Extensions/IONetworkingFamily.kext/Contents/PlugIns or inject the kext via OpenCore)
- Update to Tiger 10.4.11 to get ALC889a audio to work.
- Fenvi FV-T919 Wifi/BT PCIe card will not work in Tiger. However, if the bluetooth mouse/keyboard have been paired with FV-T919 in newer macOS where it's supported, those paired keyboard/mouse may work in Tiger with basic functionality.   
- To get Asus USB-BT400 bluetooth to work, [patch](https://www.tonymacx86.com/threads/need-bluetooth-4-0-get-it-here.56752/) the Info.plist of BroadcomUSBBluetoothHCIController.kext in S/L/E/IOBluetoothFamily.kext to include device-id and vendor-id of the bluetooth dongle. 
- For hardware acceleration of ATI Radeon HD2400 Pro, refer to [this](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/7.%20Miscellaneous/Misc.md) guide
  
# Resources

- [Kext Helper b7](https://www.macintoshrepository.org/26602-kext-helper-b7) (Convenient tool for installing kext, fixing permission, and cache rebuilding)
- IORegistryExplorer (Included in [Xcode 3.1.4 Developer Tools](https://developer.apple.com/download/all/?q=xcode%203.1.4); requires developer account to download)
- [Temperature Monitor](https://www.macintoshrepository.org/33043-temperature-monitor)
- [Plist editor](https://www.fatcatsoftware.com/plisteditpro_downloads/) for Tiger
- [TenFourFox](https://sourceforge.net/projects/tenfourfox/files/unstable/contrib/) (Web browser)


# Screenshots
<details> 
<summary>About This Mac</summary><img width="724" alt="Screenshot 2023-06-30 at 3 32 12 PM" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/93d6d6f5-73fc-4a7b-ad57-2daf09975242">

</details>  

<details> 
<summary>System Information</summary><img width="657" alt="Screenshot 2023-07-01 at 11 46 21 AM" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/481199ab-43c8-4e76-ba62-c5993f27403c">
<img width="1419" alt="1" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/a8735016-7c3d-46b3-8089-deabea98853d">
<img width="1422" alt="2" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/56a6b49f-6915-4471-a4c7-d355c1c6084b"><img width="1422" alt="3" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/3b0f4fbe-0c40-4143-8f82-b810450576bb"><img width="1418" alt="4" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/b7fd52fd-1a94-4e22-af53-d8c02c7ad051"><img width="1325" alt="5" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/31c3d2b7-040b-4739-90d5-c64c71539834"><img width="746" alt="6" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/fcf56196-4496-4348-86c5-634e582c985a">

</details>  

<details>  
<summary>Temperature Monitor</summary><img width="399" alt="Screenshot 2023-06-30 at 3 43 28 PM" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/b5e0cb92-3d2c-400b-a79d-9d39d36ace13">
</details>  
