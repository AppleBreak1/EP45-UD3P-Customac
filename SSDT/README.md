# SSDT injection

Minimal patching via SSDT for OpenCore (No fully patched DSDT Needed)

1. SSDT-CPUPM: PState for Q9550
2. SSDT-CPUCST: CState for Q9550
3. SSDT-LPC: AppleLPC device-id
4. SSDT-IRQS: Fix for HPET, RTC, IPIC, TIMR.  (Required)
5. SSDT-Device: Add missing devices; Remove unused devices.
   - Added FRWR device with _SUN object to fix sleep issue when 1394 is enabled
6. SSDT-EC-USBS: Add Embedded Controller. (Required)
7. SSDT-PTS: Fixes reboot issue when waking up from sleep. (Required)

8. SSDT-Patches: Combines all above SSDTs into one SSDT.

For C/P States make sure to drop OEM cpupm table and cpucst table (If C2/C4 is enabled in BIOS)
