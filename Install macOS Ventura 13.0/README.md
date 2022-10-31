# macOS 13.0 Ventura

<img width="1435" alt="Screenshot 2022-10-30 at 6 51 44 PM" src="https://user-images.githubusercontent.com/97265013/198927966-1b2d5852-6d9b-4043-add1-8e9c5b3d51c4.png">

Big thanks to OCLP developers, we are now able to install macOS 13.0 on old hardwares such as core2quad(SSE4.1) with some workarounds.

Please ["READ HERE"](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/998) before attempting to install macOS Ventura.



# Installation Requirements

- Minimum of OC 0.8.3 with latest version of kexts

- iMacPro1,1 (For installation purpose)

- [Rosetta Cryptex](https://github.com/acidanthera/CryptexFixup) (Can be done by using CryptexFixup.kext. But, if this doesn't work, it will have to be done [manually](https://github.com/dortania/OpenCore-Legacy-Patcher/issues/998#issuecomment-1163607808), that is to rip from the Apple Silicon Installation.)

- [NoAVXFSCompressionTypeZlib-AVXpel.kext](https://github.com/dortania/OpenCore-Legacy-Patcher/blob/67a78ec4a275e0e8f8941a5ff9d64f00c28397dc/payloads/Kexts/Misc/NoAVXFSCompressionTypeZlib-v12.3.1.zip)

- [AAAMouSSE.kext](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/)

- AppleMCEReporterDisabler.kext

- [telemetrap.kext](https://forums.macrumors.com/threads/mp3-1-others-sse-4-2-emulation-to-enable-amd-metal-driver.2206682/post-28447707)

- Kernel patch to [disable Root Hash validation](https://github.com/dortania/OpenCore-Legacy-Patcher/commit/03b8b4655041cccb6b099020265c4fcb9c297dc6#diff-e6e31b873ed817965dd126ab9dd4ff17d91e0b0ed49dc87f1ecd0c89bebd9a1dR1688-R1717) 

- Boot-args: keepsyms=1, amfi_get_out_of_my_way=1 (is needed for various root patching (GPU) via OCLP 0.5.0 or higher)

- PS2 Keyboard/Mouse or PCIE USB 3.0 Expansion Card (UHCI USB Stack have been dropped in macOS Ventura thus USB Keyboard/Mouse won't work if plugged into any onboard USB ports)


# Install EFI

[EFI-Installation.zip](https://github.com/AppleBreak1/EP45-UD3P-Customac/files/9897890/EFI-Installation.zip)


- Fill in SMBIOS iMacPro1,1 information
- Make a backup before attempting to install or install on separate disk


# Post-Install EFI

[EFI-Post Installation.zip](https://github.com/AppleBreak1/EP45-UD3P-Customac/files/9897891/EFI-Post.Installation.zip)


- Fill in SMBIOS iMac10,1 information
- Use latest OCLP to get GPU acceleration.

