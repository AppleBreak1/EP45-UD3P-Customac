# Inateck KT5001 PCIE USB 3.0 Expansion Card

Inateck KT5001 PCIE USB 3.0 card (Fresco Logic FL1100 chipset) works out of the box in macOS Ventura with couple of caveats. 

- Unable to use USB Keyboard/Mouse in BIOS when connected to KT5001 PCIe USB ports on this legacy system nor in OpenCore Boot Picker. 

- Sleep issue while USB 3.0 external HDDs are connected to PCIE USB ports. When attempting to sleep, the system would enter into an infinite sleep/wake cycle by itself and has to hard shut down manually to get out of it. 

The sleep issue can be resolved by mapping USB ports and setting correct USB connector type to each port but not being able to use keyboard to access BIOS menu while system is posting is somewhat inconvenient.


# USB Port Mapping

Note that USB Port Mapping has to be done via [USBMap](https://github.com/corpnewt/USBMap) tool as PCIe USB ports will not show in USB section of the Hackintool unless the port mapping done via USBMap tool have been injected first.


<img width="1814" alt="Screenshot 2022-11-01 at 8 06 16 AM" src="https://user-images.githubusercontent.com/97265013/199291598-8375880e-a899-4b7e-922d-97c04ee5f107.png">
