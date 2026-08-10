# SSDTs

**Use of SSDTs instead of patched DSDT**

1. SSDT-APIC.aml (Patch to fix out-of-order Local Apic ID)
   * Make sure to drop the OEM APIC table
2. SSDT-CPUPM: P-States for Q9550
3. SSDT-CPUCST: C-States for Q9550
   * Make sure to drop the OEM cpupm table and cpucst tables (If C1E/C2/C4/CPU EIST is enabled in BIOS)
4. SSDT-LPC: Injects fake LPC properties to load AppleLPC (For power management)
5. SSDT-IRQS: Fix HPET and RTC; fix IRQ conflicts
   * Modifying HPET._STA and HPET._CRS are nessessary to load AppleHPET.kext. This will avoid kernel panic when loading AppleIntelCPUPowerManagement. (Otherwise, DummyPowerManagement needs to be enabled)
6. SSDT-Device: Defines missing pci-bridges and devices; Injects fake devices; disables unused devices.
    - Added FRWR device with _SUN object to fix sleep issue when 1394 is enabled
7. SSDT-EC-USBX:
     - EC: Fake Embedded Controller
     - USBX: Injects USB power properties (This allows for high power charging of iPhone, iPad and etc via USB 2.0; however, USBX is not necessary if USB port mapping is already done with [Hackintool](https://github.com/benbaker76/Hackintool))
       
8. SSDT-EHCI: [Fix for USB2.0 power](https://www.insanelymac.com/forum/topic/192518-dsdt-fixes-for-gigabyte-boards/?do=findComment&comment=1353966)

   - Allows USB2.0 hub connected devices to wake the system
   - Allows single-key press or a mouse click to fully wake the system (For Catalina and older, darkwake=0 may still be needed)
   - Resolves "Disk not ejected properly" notification on wake when USB disks are connected to the system
   - Resolves USB keyboard/mouse not working after sleep/wake cycle (Behavior in Big Sur+)

9. SSDT-USBP: ACPI USB Map for EP45-UD3P. USB Mapping is not necessary on this MB as each USB controllers have less than 15 USB ports. However, one may do so for the following reasons.

   - Name EHCIPorts as PRT(x)
   - Define internal USB header(UHCIPort@3d10/EHCIPort@fd30) connector type as internal for bluetooth.

10. SSDT-PTS: Fix for [shutdown](https://www.insanelymac.com/forum/topic/192518-dsdt-fixes-for-gigabyte-boards/?do=findComment&comment=1365642) and [system restart on sleep/wake](https://www.insanelymac.com/forum/topic/192518-dsdt-fixes-for-gigabyte-boards/?do=findComment&comment=1345528). 

    **Ensure that the ACPI patch to rename _PTS to ZPTS is applied**
          
Notes:

 - Snow Leopard and older Mac OS require SSDTs to be compiled in ACPI 4.0 compiler.
 - System restart on sleep/wake can also be fixed by checking "Start up automatically after a power failure" box in Energy Saver settings 
