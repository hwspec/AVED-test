##### Copyright (C) 2023 - 2025 Advanced Micro Devices, Inc.  All rights reserved.
##### SPDX-License-Identifier: MIT
# AVED

Full documentation for the ALVEO Versal Example Design can be found at the following link: 
[xilinx.github.io/AVED/](https://xilinx.github.io/AVED/)


# Personal Use Setup (Alveo0[0-1]) Node) 
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
