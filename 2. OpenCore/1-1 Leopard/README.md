# Mac OS X Leopard Installer
  - Leopard Installer Version: 10.5.7 (9J3050)
  - Update to 10.5.8 (9L31a) after the installation

# Hardwares

CPU : Intel Core 2 Quad Q9550

GPU: ATI Radeon HD 2400 Pro 128MB DDR2 

RAM: G•SKIll DDR2 4GB x 4 (16GB)

Motherboard: EP45-UD3P Rev 1.1

BIOS revision: F10

Bluetooth: Asus USB-BT400 Bluetooth dongle (Patch required)

Wifi/BT Card: Fenvi FV-T919 (Not supported in Leopard)

PCIe Card: Inateck KT5001 USB 3.0 PCIe Card (Not supported in Leopard)

SSD: PNY CS900 250GB 


# OpenCore 

- Version 0.7.7

- ACPI

    ADD: DSDT.aml, SSDT-EC-USBX.aml

    Quirks: FadtEnableReset -> Yes (This is required for restart to function properly)

- Booter

    Quirks: [RebuildAppleMemoryMap](https://dortania.github.io/OpenCore-Install-Guide/config.plist/penryn.html#quirks-2) -> Yes (This quirk is required to boot Leopard)

- Kernel 
   
   Add:
   
     - VirtualSMC.kext
     - Lilu.kext, AppleALC.Kext
     - [Natit.kext](https://www.insanelymac.com/forum/topic/94090-how-to-ati-radeon-hd-2400-2600-2900-3850-3870-on-leopard/) (For ATI Radeon HD 2400 Pro hardware acceleration in Leopard)
     - AGPMInjectorHD2400.kext (AGPM injector for ATI Radeon HD 2400 Pro 0x100294c3; requires to use SMBIOS iMac9,1)
  
    Emulate:

     - DummyPowerManagement -> Set to YES, only if HPET fix is not applied (This will resolve panic complaining about "No HPETs available..."
       
    Quirks: 
     
     - DisableRtcChecksum -> Yes (This prevents BIOS from resetting on every restart or shutdown)
     - ExternalDiskIcons -> Yes (This resolves internal disk icons shown as external)

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

  
SMBIOS -> iMac9,1 (Needed for AGPMInjector and the proper SpeedStep of Core2Duo or Core2Quad) 

UEFI -> Quirks -> ReleaseUsbOwnership -> Yes (Required for EHCI(USB2) controllers to load)


# Working

Native Apple CPU Power Management

Intel Core 2 Quad Q9550 SpeedStep

Native Apple GPU Power Management

ATI Radeon HD 2400 Pro hardware acceleration with VGA port (works up to Leopard 10.5.8)

Restart/Sleep/Shutdown

Sound/Ethernet/FireWire/Bluetooth 4.0



# Notes
- If you get a warning "Mac OS X cannot be installed on this computer" using installer version 10.5.7 (9J3050), you may need to use SMBIOS MacBookPro5,3 for installation.
- If the installation fails on certain partition, erase the partition in "Mac OS Extended (Journaled)" format using Disk Utility of the Mac OS X Leopard.
- Note that SSDTs need to be compiled in ACPI4.0 compiler as Snow Leopard or older Mac OS do not support anything newer. Otherwise SSDT injection will fail.
- Upon booting after the successful installation of Mac OS X Leopard, you will be greeted with good old intro music, instrumental version of the song "Exodus Honey" by Honeycut.
- Fenvi FV-T919 Wifi/BT PCIe card will not work in Leopard. However, if the bluetooth mouse/keyboard have been paired with FV-T919 in newer macOS where it's supported, those paired keyboard/mouse may work in Leopard with basic functionality.   
- Realteck RTL8111c ethernet is natively supported in Leopard (Attaches to AppleRTL8169Ethernet.kext)
- To get Asus USB-BT400 bluetooth to work, [patch](https://www.tonymacx86.com/threads/need-bluetooth-4-0-get-it-here.56752/) the Info.plist of BroadcomUSBBluetoothHCIController.kext in S/L/E/IOBluetoothFamily.kext to include device-id and vendor-id of the bluetooth dongle. 
- For hardware acceleration of ATI Radeon HD2400 Pro, refer to [this](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/7.%20Miscellaneous/Misc.md) guide
- Mounting EFI in Leopard

    ~~~
    mkdir /Volumes/EFI
    sudo mount -t msdos /dev/diskXsY /Volumes/EFI
    ~~~
  
# Resources

- [CPU-i](https://www.insanelymac.com/forum/topic/181903-guide%EF%A3%BFretail-snow-leopard-106-on-a-ga-ep45-ud3r%EF%A3%BF/?do=findComment&comment=1268733) (CPU sensor app for Leopard)
- [Kext Helper b7](https://www.macintoshrepository.org/26602-kext-helper-b7) (Convenient tool for installing kext, fixing permission, and cache rebuilding)
- [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector) (May require to run the app in Mojave+)
- IORegistryExplorer for Leopard (Included in [Xcode 3.1.4 Developer Tools](https://developer.apple.com/download/all/?q=xcode%203.1.4); requires developer account to download)
- [Plist editor](https://www.fatcatsoftware.com/plisteditpro_downloads/) for Leopard
- [TenFourFox](https://sourceforge.net/projects/tenfourfox/files/unstable/contrib/) (Web browser)
       

# Screenshots
<details> 
<summary>About This Mac</summary><img width="782" alt="244298568-c9e7d22e-b76c-4c6d-93db-6ac484963b22" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/15a7bdf5-33ce-4ef5-bdd6-20a0c95495d7">

</details>  

<details> 
<summary>System Information</summary><img width="690" alt="244300130-15663290-2420-410c-94e4-013b8b453f3d" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/1cdfa4f5-0ac2-4038-ab02-900965f00e56">
<img width="692" alt="244300178-fe91fdd9-49ed-487c-b6cf-a19085b0f59c" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/8529effc-f215-451b-9a94-57f2a144b69d">
<img width="688" alt="244300229-30dd1362-553e-4cbc-b146-a0228f41116b" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/c7aba14d-fe6f-4fe6-978e-d000df981771">
<img width="695" alt="244522322-3ee18ecb-a948-4511-ab5d-d70f66c0911e" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/01bded09-efa4-4695-8946-eeb72742db68">
<img width="691" alt="244300381-80e2854e-5d3c-41f3-a425-0ae90a3c8d70" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/35684ee0-2c91-4b92-8aff-2c52df225ae9">
<img width="689" alt="244300401-ab0bc4ba-e18a-4643-8db0-17120cd84ba9" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/08e3a432-3f0b-47a1-9c03-8e090ee717d7">
<img width="692" alt="244300421-425c8881-8493-485b-b345-5d6dd9fe4e83" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/43e23fb1-6a8a-40ba-b810-6016bd623897">

</details> 

<details>  
<summary>IORegistryExplorer</summary><img width="881" alt="244301988-6b8786b8-9cc2-4f8d-9ef0-a2a15b674b61" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/177934a4-7459-4b72-adbc-227baa53fb89">
<img width="882" alt="244302532-f9a996c8-6842-4ee3-85a9-b9df96bb4a53" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/21408f70-d11d-4fdd-9ccf-3404d253788c">
<img width="880" alt="244303191-b9d675ce-9c41-4943-8d92-b159f3644e9c" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/785fc280-4afa-45e7-a685-d4000e9d7942">

</details>  

<details>  
<summary>CPU Monitor</summary><img width="476" alt="244304370-1a420970-ed5c-4140-8942-aa9000286b19" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/55b5adbb-91e6-40ef-8437-3a091b942bba">
<img width="474" alt="244304375-508fda5e-fc46-4c05-a6ee-e5033c936eea" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/f016900f-6bb4-4e36-956d-40ccf71d48c2">
<img width="476" alt="244466866-c0853545-3882-4609-ac1c-e4af3bab7a48" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/aef0edc9-ac9f-4d79-a2eb-87d34471e9c5">

</details>  
