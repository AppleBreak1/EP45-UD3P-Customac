Due to having no NVRAM on this old legacy board, installing macOS Big Sur or later using offline method will result in an infinite boot loop as the system fails to write NVRAM parameter msu-product-url the “UUID of target partition created by macOS installer” to NVRAM.  The key here is the UUID of the target partition. As long as the UUID of the target partition is written in the NVRAM section of the config.plist before proceeding to second stage of installation, boot loop issue should be resolved.

# Installation Process

Assuming the target partition’s name is “Monterey”


1. Wether you are installing from an Installer USB or from an another working macOS partition in your system. ‘DO NOT” boot to newly created “macOS Installer” entry after the first stage of installation. Instead, boot back into Installer USB or other working macOS partition to get the UUID of target partition. 

2. To find UUID of Monterey(Target Partition) open the Terminal app and execute the following command.


  ```shell
  diskutil info /Volumes/Monterey | grep "Volume UUID" | awk '{print $3}'
  ```

   - Terminal should return the UUID of target partition as something like E031-XXXX-XXXX-XXXX-XXXXXXXXAE31 
   - Take a note of the returned UUID and add it to the config.plist.
  

3. Adding target partition's UUID to config.plist -> NVRAM -> 7C436110-AB2A-4BBB-A880-FE41995C9F82

    Add Key: msu-product-url -> UUID of target partition/macOS%2520Install%2520Data            

<img width="769" alt="Screenshot 2022-09-01 at 4 14 47 PM" src="https://user-images.githubusercontent.com/97265013/188031690-fd5b020a-3dc6-4626-b25a-254649b57ae3.png">

Save the config.plist and reboot.

4. Now we can proceed to the next stage of installation by entering to newly created "macOS Installer" entry. 

# Credits

For finding missing msu-product-url key

- [pac-man](https://www.insanelymac.com/forum/topic/345910-unable-to-upgrade-from-catalina-to-big-sur-on-system-with-legacy-bios/)

- [TheBloke](https://www.tonymacx86.com/threads/x299-big-sur-support.302143/post-2203225)
