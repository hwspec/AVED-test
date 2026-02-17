# Changes to 'create_bd_design.tcl' (vs. original generated script) 

Summary of modifications made to the block design TCL for the V80 AVED flow.

---

## 1. SMBus re-enabled in base logic

- **New root-level port:** `smbus_0` (IIC master) in `create_root_design`.
- **New interface pin in `base_logic`:** `smbus_rpu` (master).
- **New IP in `base_logic`:** `axi_smbus_rpu` (xilinx.com:ip:smbus), with:
  - `axi_smbus_rpu/SMBUS` ↔ `base_logic/smbus_rpu`
  - `rpu_sc/M01_AXI` ↔ `axi_smbus_rpu/S_AXI`
  - `axi_smbus_rpu/ip2intc_irpt` → `base_logic/irq_axi_smbus_rpu`
  - `axi_smbus_rpu/s_axi_aclk` and `s_axi_aresetn` on the shared PL clock/reset nets.
- **Address:** `0x80044000` → `base_logic/axi_smbus_rpu/S_AXI/Reg` in `cips/M_AXI_LPD`.
- **Root connection:** `base_logic/smbus_rpu` ↔ port `smbus_0`.

---

## 2. PCA AXI-MMIO bridge (user RTL)

- **New module in `base_logic`:** `pca_bridge`, reference `pca_axi_mmio_bridge_bd_wrapper`.
- **Connection:** `rpu_sc/M02_AXI` ↔ `pca_bridge/S_AXI`.
- **Clock/reset:** `pca_bridge/s_axi_aclk` and `s_axi_aresetn` on shared PL nets.
- **Address:** `0x80045000` → `base_logic/pca_bridge/S_AXI/reg0` in `cips/M_AXI_LPD`.

---

## 3. AxiLiteMem32Test (scratch RAM for MMIO testing)

- **New module in `base_logic`:** `axi_lite_mem32_test`, reference `axi_lite_mem32_test_bd_wrapper`.
- **Connection:** `rpu_sc/M03_AXI` ↔ `axi_lite_mem32_test/S_AXI`.
- **Clock/reset:** Same shared PL clock/reset nets.
- **Address:** `0x80046000` → `base_logic/axi_lite_mem32_test/S_AXI/reg0` in `cips/M_AXI_LPD`.
- **Host BAR:** Use BAR 0 offset `0x8046000` for `bar_rd`/`bar_wr` (see `docs/AxiLiteMem32Test_usage.md`).

---

## 4. RPU SmartConnect (`rpu_sc`) width

- **Config:** `CONFIG.NUM_MI` set to **4** (was 2 in the original script).
- **MI usage:**
  - `M00_AXI` → `gcq_m2r/S01_AXI`
  - `M01_AXI` → `axi_smbus_rpu/S_AXI`
  - `M02_AXI` → `pca_bridge/S_AXI`
  - `M03_AXI` → `axi_lite_mem32_test/S_AXI`

---

## 5. Root-level wiring

- **Port:** `smbus_0` created and connected to `base_logic/smbus_rpu`.
- **IRQ:** `base_logic/irq_axi_smbus_rpu` → `cips/pl_ps_irq1`.
- Clocks/resets for the new AXI-Lite blocks are on the same nets as existing PL peripherals.
