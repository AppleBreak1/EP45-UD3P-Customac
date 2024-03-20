Due to having no native NVRAM support for this old legacy board, installing macOS Big Sur using the offline method will result in an infinite boot loop or unable to proceed with the installation as the system fails to write NVRAM parameter, msu-product-url with "the UUID of target volume created by macOS installer” to NVRAM.  The key here is the UUID of the target volume. As long as it's written in the NVRAM section of the config.plist before proceeding to the second stage of installation, boot loop issue should be resolved.

# Installation Process

Assuming the target volume is named “BigSur”


1. Whether you are installing from an Installer USB or from an another working macOS in your system, ‘DO NOT” boot to newly created “macOS Installer” entry after the first stage of installation. Instead, boot back into installer USB or other fall back macOS to get the UUID. 

2. Find the UUID of target volume(BigSur) 

   - When fresh installing on empty volume
  
      - open the Terminal app and execute the following command.

         ```shell      
          diskutil info /Volumes/BigSur | grep "Volume UUID" | awk '{print $3}'  
         ```

      - Terminal should return the UUID of target volume as something like E031-XXXX-XXXX-XXXX-XXXXXXXXAE31 
      - Take a note of the returned UUID and add it to the config.plist later.
  
   - When upgrading directly from the older macOS to Big Sur
    
      - The older macOS partition will already have linked UUID existing in the Preboot volume but not its "- Data" volume which is what is needed. For this case, after the first stage of installation when the installer asks to restart the system, do not restart, instead, mount and open the Preboot volume in the same container disk as the target volume to get the UUID (look for the newly created UUID by the Big Sur Installer)

         <img width="765" alt="245650740-12bc21e7-5f59-4c74-bef1-22ea304d70d4" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/7e6524ec-436e-44ee-a4e6-8577503123e5">
 
3. Adding the parameter in config.plist 
      
     NVRAM -> ADD -> 7C436110-AB2A-4BBB-A880-FE41995C9F82 -> msu-product-url -> UUID/macOS%2520Install%2520Data            

      <img width="769" alt="188031690-fd5b020a-3dc6-4626-b25a-254649b57ae3" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/c42f4a8f-b237-40ed-831e-f4ae05a2f166">

      Save the config.plist and reboot.

4. Now we can proceed to the next stage of installation by entering to newly created "macOS Installer" entry. 

   *Note that this procedure may not be necessary for Monterey+

# Credits

For finding missing msu-product-url key

- [pac-man](https://www.insanelymac.com/forum/topic/345910-unable-to-upgrade-from-catalina-to-big-sur-on-system-with-legacy-bios/)

- [TheBloke](https://www.tonymacx86.com/threads/x299-big-sur-support.302143/post-2203225)
