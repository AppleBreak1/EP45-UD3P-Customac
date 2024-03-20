# All-In-One EFI

- This EFI adapts use of SSDT hotpatch instead of opting for patched DSDT.
- Combines required OpenCore settings and kexts used to boot Tiger to Sonoma

# OpenCore

- Version: 0.9.5
  
- SMC Emulator

     - VirtualSMC (Configured to be injected from Tiger ~ Snow Leopard)
       
     - FakeSMC and Plugins (Configured to be injected in Mac OS X Lion+ as they provide more sensor readings for this legacy system

       Note: If there is an issue installing macOS with FakeSMC and Plugins, use VirtualSMC for installation purpose)
      
- SSDT
     - SSDT-CPUPM (P-States for Q9550; disabled)
     - SSDT-CPUCST (C-States for Q9550; disabled)
     - SSDT-Devices (Defines missing pci-bridges and devices in DSDT and disables unused devices in Mac OS)
     - SSDT-EC
       - EC: Fake Embedded Controller
       - USBX: Injects USB power properties (This allows for high power charging of iPad and other iDevices via USB 2.0; however, USBX is not necessary if USB port mapping is already done with [Hackintool](https://github.com/benbaker76/Hackintool))     
     - SSDT-IRQS (IRQ conflict fix, HPET fix, otherwise DummyPowerManagement is required)

            Note that in Ventura+, kernel panic or crash may still occur with DummyPowerManagment enabled
            which seems to be broken (HPET fix is recommended)
       
     - SSDT-PTS (Fixes shutdown and reboot on sleep/wake)
     - SSDT-EHCI (Fix for USB2.0 power)

        - Allows USB2.0 hub connected devices to wake the system
        - Allows Single-key press or a mouse click to fully wake the system (For Catalina and older, darkwake=0 may still be needed)
        - Resolves "Disk not ejected properly" notification
        - Resolves USB keyboard/mouse not working after sleep/wake cycle (Behavior in Big Sur+)

     - SSDT-USBP (USB Mapping for EP45-UD3P; disabled)

- Patches
  
     - Booter:
       
          - Skip Board-ID check patch (With this patch applied, -no_compat_check boot flag is not needed to boot macOS on unsupported SMBIOS)
       
     - Kernels:
       
          - [VMM kernel patches](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/543) (These minimal vmm spoof patches allow install or update(via Software Update panel) macOS Big Sur 11.3 or newer on unsupported SMBIOS. The kern.hv_vmm_present patches in config.plist are disabled by default, but one may enable them to install or update macOS 11.3+ without needing to change SMBIOS to supported model)

               - Note1: Alternatively, one may use [RestrictEvents.kext](https://github.com/acidanthera/RestrictEvents) with revpatch=sbvmm boot flag instead
               - Note2: Delta update requires system volume to be sealed for Big Sur+
               - Note3: For pre-AVX2 systems in macOS Ventura+, even with VMM patches and sealed system volume, incremental update via Software Update panel will not work due to [delta updates not containing the non-AVX2 cache](https://dortania.github.io/OpenCore-Install-Guide/extras/ventura.html#dropped-cpu-support) for Intel systems. Thus, installing the full update is required

          - [SurPlus patches](https://github.com/reenigneorcim/SurPlus) (May resolve occasional hangs on boot while booting to macOS Big Sur. The patches in config.plist are disabled by default, enable them on needed basis)
       
# Notes

- Bootable Mac OS versions: Mac OS X Tiger 10.4.10 ~ macOS Sonoma 14.0 Beta
  
- For installations, SMBIOS needs to be changed accordingly.

  Mac models used for Installation
  
  - iMac7,1: Tiger ~ El Capitan
  - iMac9,1: Leopard ~ El Capitan
  - iMac10,1: Leopard ~ High Sierra
  - iMac19,1: Mojave+

- Notes on SMBIOS suitabililty for this system.

  - iMac7,1: Needed to boot Tiger. However, as far as SpeedStep is concerned, not all defined P-states will work.
  
  - iMac9,1 or iMac10,1: Allows proper CPU SpeedStep (If configured) + AppleGraphicsPowerManagement (AGPM)

  - MacPro3,1: Allows proper CPU SpeedStep (If configured). However, no AGPM exists for MacPro3,1 or older MacPros.
     
- When using unsupported GPUs in versions of Mac OS, it may require adding nv_disable=1 (Nvidia) or -radvesa (AMD) to force VESA mode to avoid black screen. 
  
- No device renaming. Although this can be done via ACPI patch section of the Config.plist, this may require changing path/names in SSDTs accordingly.

# Screenshots
<details> 
<summary>Sonoma</summary><img width="1121" alt="Screenshot 2023-07-03 at 5 07 19 PM" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/1b3cefcf-e46c-4f9d-9fe9-1fd92b7f7227">
</details>  
