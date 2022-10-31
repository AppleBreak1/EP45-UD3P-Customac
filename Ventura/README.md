# macOS 13.0 Ventura

Big thanks to OCLP developers, we are now able to install macOS 13.0 on old hardwares such as core2quad(SSE4.1) with some workarounds.

Please "READ HERE" before attempting to install macOS Ventura.



# Installation Requirements

- Minimum of OC 0.8.3 with latest version of kexts

- iMacPro1,1 (For installation purpose)

- Rosetta Cryptex (Can be done by using CryptexFixup.kext or manually that is to rip from the Apple Silicon Installation)

- NoAVXFSCompressionTypeZlib-AVXpel.kext

- AAAMouSSE.kext

- AppleMCEReporterDisabler.kext

- telemetrap.kext

- Kernel patch to disable Root Hash validation 

- Boot-args: keepsyms=1, amfi_get_out_of_my_way=1 (is needed for various root patching (GPU) via OCLP 0.5.0 or higher)

- PS2 Keyboard/Mouse or PCIE USB 3.0 Expansion Card (UHCI USB Stack have been dropped in macOS Ventura thus USB Keyboard/Mouse won't work if plugged into any onboard USB ports)


# Installation EFI



- Fill in SMBIOS iMacPro1,1 information
- Make a backup before attempting to install or install on separate disk



# Post Installation EFI



- Fill in SMBIOS iMac10,1 information
- Use latest OCLP to get GPU acceleration.

