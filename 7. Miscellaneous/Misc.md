</details>     
  
<details>  
<summary>Modify the CPU processor name in About this Mac</summary>
<br>

   Requirements
  
  1. [Lilu.kext](https://github.com/acidanthera/Lilu) and [RestrictEvents.kext](https://github.com/acidanthera/RestrictEvents)
  
  2. Inlcude the followings in Config.plist
  
   <img width="573" alt="244953165-a825d304-65f6-4372-b023-5ac9a5ac6e83" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/2413061b-d04a-465e-80f9-96248a7e748c">


  (There is also a [script](https://github.com/corpnewt/CPU-Name) by corpnewt for this)
  
 </details> 
 
<details>  
<summary>Enable GPU Tab in Activity Monitor in Catalina+</summary> 
<br>
  
  To Enable

       defaults write com.apple.ActivityMonitor ShowGPUTab -bool true
       
  To Disable

        defaults write com.apple.ActivityMonitor ShowGPUTab -bool false
  
   </details> 

  
<details>  
<summary>Enable SpeedStep for Intel Core2 processors booting with OpenCore</summary>
<br>

  Requirements
  
    - Use pre-XCPM Mac models such as iMac10,1, iMac9,1, MacPro3,1 (These models are tested to work with Q9550)
  
    - Working AppleLPC
  
    - Modify CpuPm and CpuCst tables 
  
    - Drop native CpuPm and CpuCst tables and inject the modified tables
____
  
1. Working AppleLPC
  
    Getting AppleLPC to load requires injecting the name property under ISA bridge to match one of the LPC controllers included in the AppleLPC.kext. Pick the one that's suitable for the system.
  
    <img width="859" alt="AppleLPC" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/c6aaf4b1-4771-4da4-a1c1-16bcfaebcc30">

    Injection of the property can be done via DSDT, SSDT, or DeviceProperty.
  
    If successful, AppleLPC should be visible in IORegistryExplorer.
    <img width="845" alt="246007225-e4e19f75-e87b-42c4-a738-32dacaabab5e" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/79ead375-a9fe-4354-a89e-cb2115b6b8ce">

2.  Modify CpuPm and CpuCst tables

    There are couple of ways to do this.
  
    - First option - Let the Clover bootloader generate the tables (Does not require manually finding values for modification)
  
      - Boot with Clover bootloader with Generate CState/Pstate option enabled in Config.plist.
      - Ensure that the SpeedStep is working correctly.
      - Open [MaciASL](https://github.com/acidanthera/MaciASL)-> Files -> New from ACPI -> Open the Clover generated CpuPm/CpuCst tables and save them. Done.
   
         <img width="531" alt="Screen Shot 2023-06-16 at 9 21 22 AM" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/ad076779-5f39-473b-93c9-f517ab3378e0">
 
    - Second option - follow this [Vanilla SpeedStep](https://www.insanelymac.com/forum/topic/181631-dsdt-vanilla-speedstep-generic-scope-_pr/) guide.

       Notes about the generic scope mentioned in the guide
         
         - It can be injected via SSDT.
         - There is no noticeable CPU benchmark score difference in between injecting the Clover generated tables and the generic scope mentioned in the guide. However, it does make difference in CPU temperature and the CPU fan RPM at idle. With the generic scope in the guide, CPU temperature and the fan RPM are much cooler and lower respectively. This seems to be due to the difference in how the _CST methods are used.    
   
4. Drop native CpuPm/CpuCst tables and inject the modified tables or the generic scope for it.
  
   - Either disable C1E/C2/C4/CPU EIST in BIOS or drop all the native CpuPm/CpuCst tables using config.plist.
   
   - Update the config.plist accordingly and inject the modified CpuPm/CpuCst tables.
  
  
5. Check if the Intel SpeedStep is working.
  
   - [FakeSMC3 with HWMonitorSMC2](https://github.com/CloverHackyColor/FakeSMC3_with_plugins) or [FakeSMC with HWMonitor](https://bitbucket.org/RehabMan/os-x-fakesmc-kozlek/downloads/)

     <img width="809" alt="Screenshot 2023-07-03 at 12 35 54 PM" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/64fb33ca-a7bd-4dd5-bc9f-82be1de45b11">

        - Defined P-States are working
  
   - IORegistryExplorer
     
<img width="1104" alt="Screen Shot 2023-07-08 at 3 23 21 PM" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/0ba3c796-7cac-4239-8a9c-229abff01951">

5. Advantages of configuring SpeedStep
   
   - CPU runs much cooler
   - Relatively power efficient
   - Less fan noise.
     
 </details> 

<details>  
<summary>EVGA Geforce 9500 GT 1024MB DDR2</summary> 
<br>
  
  - VendorID: 10DE
  - DeviceID: 0640
  
  Requirements for Hardware Acceleration
  
 All macOS versions (Leopard+)
    
  - [InjectNvidia](https://dortania.github.io/OpenCore-Post-Install/gpu-patching/nvidia-patching/) (Property Injection)
___  
  Sierra - High Sierra   
  
  - Replace NVDAStartup.kext with the El Capitan version (Replace as necessary if the GPU initialization fails and gets stuck in a boot loop)
  
  Mojave (No Metal)      

  - Chris1111's [Legacy Nvidia patcher for Mojave](https://github.com/chris1111/Fix-Old-NVIDIA-macOS-Mojave)
  
  Catalina (No Metal)

  - Chris1111's [Legacy Nvidia patcher for Catalina](https://github.com/chris1111/Legacy-Video-patch)
  
  Big Sur ~ Ventura (No Metal)

  - [OpenCore Legacy Patcher](https://github.com/dortania/OpenCore-Legacy-Patcher) 
  
   </details> 

   
<details>  
<summary>ATI Radeon HD2400 Pro 128MB DDR2</summary> 
<br>
  
  - VendorID: 1002
  - DeviceID: 94c3

  Requirements for hardware acceleration(QE/CI + Framebuffer)
  
  Mac OS X Tiger ~ Mac OS X Leopard
  
  - Framebuffer
    
    1. You'll need to [InjectATI](https://dortania.github.io/OpenCore-Install-Guide/clover-conversion/Clover-config.html#graphics)(Property injection) via SSDT, DSDT or DeviceProperties to load Megalodon framebuffer.
     
        - Example
              <details>      
              <summary>Injection via SSDT or DSDT</summary>
          
                    "@0,compatible", 
                    Buffer (0x0E)
                    {
                        "ATY,Megalodon"
                    }, 

                    "@0,connector_type", 
                    Buffer (0x04)
                    {
                         0x10, 0x00, 0x00, 0x00                         
                    }, 

                    "@0,device_type", 
                    Buffer (0x08)
                    {
                        "display"
                    }, 

                    "@0,name", 
                    Buffer (0x0E)
                    {
                        "ATY,Megalodon"
                    }, 

                    "@1,compatible", 
                    Buffer (0x0E)
                    {
                        "ATY,Megalodon"
                    }, 

                    "@1,connector_type", 
                    Buffer (0x04)
                    {
                         0x00, 0x02, 0x00, 0x00                         
                    }, 

                    "@1,device_type", 
                    Buffer (0x08)
                    {
                        "display"
                    }, 

                    "@1,name", 
                    Buffer (0x0E)
                    {
                        "ATY,Megalodon"
                    }, 

                    "VRAM,totalsize", 
                    Buffer (0x04)
                    {
                         0x00, 0x00, 0x00, 0x80                         
                    }, 

                    "device_type", 
                    Buffer (0x14)
                    {
                        "ATY,MegalodonParent"
                    }, 

                    "model", 
                    Buffer (0x13)
                    {
                        "ATI Radeon HD 2400"
                    }, 

                    "ATY,Rom#", 
                    Buffer (0x0F)
                    {
                        "113-B1480A-236"
                    }
             
             </details>  

             <details>  
                <summary>Injection via DeviceProperties</summary>
            <Br>
               <img width="539" alt="Screenshot 2023-07-01 at 1 35 23 PM" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/648de75e-9110-401a-b4ca-a06010fb5933">
               </details>   
          
             Note: There is also a [Natit.kext](https://www.insanelymac.com/forum/topic/94090-how-to-ati-radeon-hd-2400-2600-2900-3850-3870-on-leopard/) that initializes HD2xxx/HD3xxx series in Leopard. You may skip the property injection and install this kext in /System/Library/Extensions or inject via OpenCore to load Megalodon framebuffer.
                
    2. Install ATY_Megalodon.kext from Mac OS X Leopard to /System/Library/Extensions/ATIRNDRV.kext/Contents/PlugIns (This step is only required for Mac OS X Tiger)

  - Quartz Extreme (QE) / Core Image (CI)
      
    - You may either patch the Info.plist of ATIRadeonX2000.kext in S/L/E to include the GPU's PCI ID (DeviceID+VendorID) or fake the device ID of the GPU to 0x94c8.

      <details>  
       <summary>Example of Editing the ATIRadeonX2000.kext</summary>

             Device-id: 0x94c3 
             Vendor-id: 0x1002 
             Patch ATIRadeonX2000.kext info.plist to replace 0x94c81002 with 0x94c31002 in IOPCIMatch string.
       </details>  
       
      <details>  
      <summary>Example of Faking the Device ID</summary>
        <Br>
        <img width="536" alt="Screenshot 2023-07-01 at 1 37 23 PM" src="https://github.com/AppleBreak1/EP45-UD3P-Customac/assets/97265013/573ded4a-3ecf-4f4c-acfe-78767de89eac">
      </details>  
      
               
 - The VGA port on this ATI Radeon HD2400 Pro works with "VGA to VGA" cable and "VGA to HDMI" converter. However, the DVI port will not work with "DVI to DVI/HDMI" cable but will actually work with "DVI to VGA" cable/adapter/converter.  
  
