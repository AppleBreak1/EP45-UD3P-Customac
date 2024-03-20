DefinitionBlock ("", "SSDT", 1, "Q9550", "CpuCst", 0x00003000)
{
    External (_PR_.CPU0, DeviceObj)
    External (_PR_.CPU1, DeviceObj)
    External (_PR_.CPU2, DeviceObj)
    External (_PR_.CPU3, DeviceObj)
    
    Scope (\_PR.CPU0)
    {
        Name (CST, Package (0x02)
        {
            One,   //<--number of C-States C1E
            Package (0x4){ResourceTemplate (){Register (FFixedHW,0x01,0x02,0x000,0x00,)},One,One,0x3E8}    //<--C1E
        }) 
        
        Method (_CST, 0, NotSerialized)    // _CST: C-States
        {
            Return (CST)    /* \_PR_.CPU0.CST_ */
        } 
    }
        
    Scope (\_PR.CPU1)
    {
        Name (CST, Package (0x04)
        {
            0x03,    //<--number of C-States C1E,C2,C4
            Package (0x4){ResourceTemplate (){Register (FFixedHW,0x01,0x02,0x000,0x00,)},One,One,0x3E8},    //<--C1E
            Package (0x4){ResourceTemplate (){Register (FFixedHW,0x01,0x02,0x010,0x1,)},0x2,0x01,0x1F4},    //<--C2
            Package (0x4){ResourceTemplate (){Register (FFixedHW,0x01,0x02,0x030,0x3,)},0x4,0x96,0x64}    //<--C4
        })
      
        Method (_CST, 0, NotSerialized)    // _CST: C-States
        {
            Return (CST)    /* \_PR_.CPU1.CST_ */
        }   
    }

    Scope (\_PR.CPU2)
    {
        Method (_CST, 0, NotSerialized)    // _CST: C-States
        {
            Return (\_PR.CPU1.CST)
        }
    }

    Scope (\_PR.CPU3)
    {
        Method (_CST, 0, NotSerialized)    // _CST: C-States
        {
            Return (\_PR.CPU1.CST)
        }
    }
}
