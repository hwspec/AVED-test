##### Copyright (C) 2023 - 2025 Advanced Micro Devices, Inc.  All rights reserved.
##### SPDX-License-Identifier: MIT
# AVED

Full documentation for the ALVEO Versal Example Design can be found at the following link: 
[xilinx.github.io/AVED/](https://xilinx.github.io/AVED/)


# Personal Use Setup Alveo0[0-1] Nodes 
```
git clone https://github.com/hwspec/AVED-test.git

source /soft/fpga/amd/2025.1/Vivado/settings64.sh 
source /soft/fpga/amd/2025.1/Vitis/settings64.sh
export XILINXD_LICENSE_FILE=/soft/fpga/amd/2025.1/data/ip/core_licenses/alveo00_smbus.lic
export PATH="/soft/fpga/amd/2025.1/gnu/armr5/lin/gcc-arm-none-eabi/bin:$PATH"
```

# Ready to run 
```
cd hw/amd_v80_gen5x8_25.1/
./build_all.sh
```

# Program Card 
```
sudo /usr/local/bin/ami_tool cfgmem_program -d b1:00.0 -t primary -i /path/to/amd_v80_gen5x8_25.1_nofpt.pdi -p 0 -y -q
```
The .pdi file you use should be in the build/ directory 


# Helpful Debugging Commands
```
sudo ami_tool reload -t sbr -d b1:00.0
```
**relaod card after programming**

grep -i "logic-uuid" hw/amd_v80_gen5x8_25.1/build/vivado.log – **chekcs current builds UUID**

ami_tool pcieinfo -d b1:00.0 -f table – **Displays detailed PCIe link and device information (e.g., link speed, width, status) for the specified device in table format.**

ami_tool sensors -d b1:00.0 – **Reads and reports onboard hardware sensor data (e.g., temperature, voltage, power) for the specified device.**

ami_tool mfg_info -d b1:00.0 – **Shows manufacturing information for the device, such as serial number, part number, firmware version, and other identification details.**

