# macOS Sierra Installer
  - [macOS Sierra](https://support.apple.com/en-us/HT211683) 10.12.6(16G29)
  - Install Security Update 2019-005 (16G2136)

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

UEFI -> Quirks -> ReleaseUsbOwnership -> Yes (Required for EHCI(USB2) controllers to load)


# Working

Native Apple CPU Power Management

Intel Core 2 Quad Q9550 SpeedStep

Native Apple GPU Power Management

EVGA GeForce GTX 770 hardware acceleration (Natively supported in Sierra and the WebDriver is not a requirement)

Restart/Sleep/Shutdown

Sound/Ethernet/FireWire/Bluetooth

Airdrop/Continuity/Handoff (Requires natively supported WiFi/BT card such as FV-T919)



# Notes

- Making macOS Sierra USB Installer

  - Copy "Install macOS Sierra.app" to Application folder

  - Name the target USB volume to "MyVolume"

  - Run the below command in terminal
  
        sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ macOS\ Sierra.app
        
- Mounting EFI in macOS Sierra

  ~~~
  diskutil mount /dev/diskXsY
  ~~~
        
# Resources
- FakeSMC3 with IntelCPUMonitor.kext, ITEIT87x.kext, GeforceSensor.kext plugin kexts [Release 240](https://github.com/CloverHackyColor/FakeSMC3_with_plugins/releases/tag/v240) (FakeSMC sensors provide more readings on this legacy hardware)
- [AGPM Injector](https://github.com/Pavo-IM/AGPMInjector) (May require to run the app in Mojave+)
- [Nvidia WebDriver](https://www.nvidia.com/download/driverResults.aspx/151968/) for Sierra Build Version (16G2136) 
- [Cuda Driver](https://www.nvidia.com/en-us/drivers/cuda/macosx-cuda-387-178-driver/) for Sierra

# Screenshots
<details>  
<summary>About This Mac</summary><img width="1568" alt="244978065-384eaa13-1a09-4d57-9046-bde9a5e0cfea" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/912d59e0-b6d5-4a63-b1d0-114795f02c29">
</details>  

<details>  
<summary>System Information</summary><img width="1481" alt="244980533-e6aacc58-57f8-466b-8a74-86cd3dc32b82" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/790149e4-a298-4528-8f58-1a420b2d2773">
<img width="1481" alt="244980545-b0951639-3c1f-4a12-a76b-457c939f15db" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/ee3c68e2-ae00-4788-b3c2-784f18c215f8">
<img width="1480" alt="244980571-8ea77bcb-4554-4d95-b53e-011e1c1b1686" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/e533d5d3-9af0-4a40-9c50-d4a1c116025c">
<img width="1481" alt="244980585-b686b91c-f2ee-4482-9a75-a91af498e443" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/0cc96b37-6f34-4195-9427-529d312ddeff">
</details>  

<details>  
<summary>HWMonitorSMC2 with FakeSMC3</summary><img width="369" alt="244978082-d9148ef5-9d94-4d36-a812-6193f42d0c59" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/1adb6ca5-5078-48f3-bf4d-5e869d83dabc">
</details>  

       


