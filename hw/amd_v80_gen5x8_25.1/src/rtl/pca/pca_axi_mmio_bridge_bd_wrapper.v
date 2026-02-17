// pca_axi_mmio_bridge_bd_wrapper.v
// Verilog wrapper so the BD sees a single AXI-Lite interface (S_AXI)
// for connection. This module is used as the top for the BD module
// reference; it instantiates the SystemVerilog AXI bridge.

module pca_axi_mmio_bridge_bd_wrapper (
  input  wire        s_axi_aclk,
  input  wire        s_axi_aresetn,

  // Single AXI-Lite slave interface (Vivado will show as S_AXI in BD)
  input  wire [31:0] S_AXI_awaddr,
  input  wire        S_AXI_awvalid,
  output wire        S_AXI_awready,
  input  wire [31:0] S_AXI_wdata,
  input  wire [ 3:0] S_AXI_wstrb,
  input  wire        S_AXI_wvalid,
  output wire        S_AXI_wready,
  output wire [ 1:0] S_AXI_bresp,
  output wire        S_AXI_bvalid,
  input  wire        S_AXI_bready,
  input  wire [31:0] S_AXI_araddr,
  input  wire        S_AXI_arvalid,
  output wire        S_AXI_arready,
  output wire [31:0] S_AXI_rdata,
  output wire [ 1:0] S_AXI_rresp,
  output wire        S_AXI_rvalid,
  input  wire        S_AXI_rready
);

  // SystemVerilog implementation of the AXI-Lite to PCA MMIO bridge.
  pca_axi_mmio_bridge u_bridge (
    .s_axi_aclk   (s_axi_aclk),
    .s_axi_aresetn(s_axi_aresetn),
    .s_axi_awaddr (S_AXI_awaddr),
    .s_axi_awvalid(S_AXI_awvalid),
    .s_axi_awready(S_AXI_awready),
    .s_axi_wdata  (S_AXI_wdata),
    .s_axi_wstrb  (S_AXI_wstrb),
    .s_axi_wvalid (S_AXI_wvalid),
    .s_axi_wready (S_AXI_wready),
    .s_axi_bresp  (S_AXI_bresp),
    .s_axi_bvalid (S_AXI_bvalid),
    .s_axi_bready (S_AXI_bready),
    .s_axi_araddr (S_AXI_araddr),
    .s_axi_arvalid(S_AXI_arvalid),
    .s_axi_arready(S_AXI_arready),
    .s_axi_rdata  (S_AXI_rdata),
    .s_axi_rresp  (S_AXI_rresp),
    .s_axi_rvalid (S_AXI_rvalid),
    .s_axi_rready (S_AXI_rready)
  );

endmodule

