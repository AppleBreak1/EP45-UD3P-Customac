# macOS High Sierra Installer
  - macOS High Sierra 10.13.6(17G66) 
  - [Install Security Update 2020-005](https://support.apple.com/kb/DL2053?locale=en_US) (17G14033)
  - [Install Security Update 2020-006](https://support.apple.com/kb/DL2059?locale=en_US) (17G14042)

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
     - [RealtekRTL8111.kext](https://github.com/Mieze/RTL8111_driver_for_OS_X) (Version 2.3.0)
     - [RestrictEvents.kext](https://github.com/acidanthera/RestrictEvents) (To [modify CPU processor name](https://github.com/AppleBreak1/EP45-UD3P-Customac/blob/main/7.%20Miscellaneous/Misc.md) in "About This Mac")

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

- NVRAM
 
   Add:
   
   - 7C436110-AB2A-4BBB-A880-FE41995C9F82
    
      - nvda_drv |Data| <31> 
      
        *Only needed if enabling Nvidia WebDrivers in macOS Sierra ~ High Sierra
      
- Boot-args:

     - alcid=1 (Audio Layout ID for ALC889)
     
     - keepsyms=1 debug=0x100 -v
     
     - darkwake=0 (Single-key wake from sleep)
     
- Drivers:

     - HfsPlusLegacy.efi

     - OpenCanopy.efi

     - OpenRuntime.efi

     - OpenUsbKbDxe.efi

     - UsbMouseDxe.efi

___

  
SMBIOS -> iMac10,1 (Needed for the proper SpeedStep of Core2Duo or Core2Quad) 

UEFI -> APFS -> MinDate -> -1 (For booting macOS High Sierra ~ Catalina)

UEFI -> APFS -> MinVersion -> -1 (For booting macOS High Sierra ~ Catalina)

UEFI -> Quirks -> ReleaseUsbOwnership -> Yes (Required for EHCI(USB2) controllers to load)


# Working

Native Apple CPU Power Management

Intel Core 2 Quad Q9550 SpeedStep

Native Apple GPU Power Management

EVGA GeForce GTX 770 hardware acceleration (Natively supported in High Sierra and the WebDriver is not a requirement)

Restart/Sleep/Shutdown

Sound/Ethernet/FireWire/Bluetooth

Airdrop/Continuity/Handoff (Requires natively supported WiFi/BT card such as FV-T919)


# Notes

<details>  
<summary>Making macOS High Sierra USB Installer</summary>

  - Copy "Install macOS High Sierra.app" to Application folder

  - Name the target USB volume to "MyVolume"

  - Run the below command in terminal
  
        sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume
  
 </details>         

<details>  
<summary>HDDs not detected by High Sierra Disk Utility</summary>

   - If the HDD does not show up in Disk Utilty, it may be resolved by applying the AppleAHCIPort patch by vit9696
    
   
          Identifier: com.apple.driver.AppleAHCIPort
          Find: 40600200 
          Replace: 00000000 
  
</details>  

<details>  
<summary>Preventing automatic conversion to APFS format</summary>

  - When updating to High Sierra directly from Sierra or older
  
    - Copy the Install macOS High Sierra.app to ~/Application folder then run the below command in terminal
      
       ~~~
       /Applications/"Install macOS High Sierra.app"/Contents/Resources/startosinstall --converttoapfs NO --agreetolicense
       ~~~
  
  
  - When installing from the High Sierra USB Installer
  
    - Open the Terminal app and run the below command

       ~~~
       /Volumes/"Image Volume/Install macOS High Sierra.app"/Contents/Resources/startosinstall --volume /Volumes/MyVolume --converttoapfs NO --agreetolicense
       ~~~ 
         *Note that "MyVolume" is to be replaced with the name of the USB High Sierra Installer volume.
  
</details>          
        
        
<details>  
<summary>Mounting EFI in macOS High Sierra</summary>

  ~~~
  sudo diskutil mount /dev/diskXsY
  ~~~
  
</details>     
        
# Resources
- [FakeSMC3 with plugins](https://github.com/CloverHackyColor/FakeSMC3_with_plugins)(FakeSMC sensors provide more readings on this legacy hardware)
- [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector) (May require to run the app in Mojave+)
- [Nvidia WebDriver](https://www.nvidia.com/download/driverResults.aspx/151968/) for High Sierra Build Version (17G14042) 
- [Cuda Driver](https://www.nvidia.com/en-us/drivers/cuda/macosx-cuda-387-178-driver/) for High Sierra




       


