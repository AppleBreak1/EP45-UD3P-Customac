DefinitionBlock ("", "SSDT", 1, "Q9550", "CpuPm", 0x00003000)
{
    External (_PR_.CPU0, DeviceObj)
    External (_PR_.CPU1, DeviceObj)
    External (_PR_.CPU2, DeviceObj)
    External (_PR_.CPU3, DeviceObj)
    
    Scope (\_PR.CPU0)
    {
        Name (PSS, Package (0x06)    // <--- Number of P-States as counted below
        {
            Package (0x06){Zero,Zero,0x0A,0x0A,0x481E,Zero},
            Package (0x06){Zero,Zero,0x0A,0x0A,0x081C,One},
            Package (0x06){Zero,Zero,0x0A,0x0A,0x471A,0x02},
            Package (0x06){Zero,Zero,0x0A,0x0A,0x0718,0x03},
            Package (0x06){Zero,Zero,0x0A,0x0A,0x4617,0x04},
            Package (0x06){Zero,Zero,0x0A,0x0A,0x0615,0x05}
        })   
        
        Method (_PSS, 0, NotSerialized)    // _PSS: Performance Supported States
        {
            Return (PSS)    /* \_PR_.CPU0.PSS_ */
        } 
    }
        
    Scope (\_PR.CPU1)
    {
        Method (_PSS, 0, NotSerialized)    // _PSS: Performance Supported States
        {
            Return (\_PR.CPU0.PSS)
        }
    }

    Scope (\_PR.CPU2)
    {
        Method (_PSS, 0, NotSerialized)    // _PSS: Performance Supported States
        {
            Return (\_PR.CPU0.PSS)
        }
    }

    Scope (\_PR.CPU3)
    {
        Method (_PSS, 0, NotSerialized)    // _PSS: Performance Supported States
        {
            Return (\_PR.CPU0.PSS)
        }
    }
}
