module pca_axi_mmio_bridge_bd_wrapper_v (
  // Clock and reset (so BD can connect clk_pl, resetn_pl_periph)
  input  wire        s_axi_aclk,
  input  wire        s_axi_aresetn,
  // AXI-Lite slave – write address
  input  wire [31:0] s_axi_awaddr,
  input  wire        s_axi_awvalid,
  output wire        s_axi_awready,
  // AXI-Lite slave – write data
  input  wire [31:0] s_axi_wdata,
  input  wire [3:0]  s_axi_wstrb,
  input  wire        s_axi_wvalid,
  output wire        s_axi_wready,
  // AXI-Lite slave – write response
  output wire [1:0]  s_axi_bresp,
  output wire        s_axi_bvalid,
  input  wire        s_axi_bready,
  // AXI-Lite slave – read address
  input  wire [31:0] s_axi_araddr,
  input  wire        s_axi_arvalid,
  output wire        s_axi_arready,
  // AXI-Lite slave – read data
  output wire [31:0] s_axi_rdata,
  output wire [1:0]  s_axi_rresp,
  output wire        s_axi_rvalid,
  input  wire        s_axi_rready
);

  pca_axi_mmio_bridge_bd_wrapper u_impl (
    .s_axi_aclk   (s_axi_aclk),
    .s_axi_aresetn(s_axi_aresetn),
    .S_AXI_awaddr (s_axi_awaddr),
    .S_AXI_awvalid(s_axi_awvalid),
    .S_AXI_awready(s_axi_awready),
    .S_AXI_wdata  (s_axi_wdata),
    .S_AXI_wstrb  (s_axi_wstrb),
    .S_AXI_wvalid (s_axi_wvalid),
    .S_AXI_wready (s_axi_wready),
    .S_AXI_bresp  (s_axi_bresp),
    .S_AXI_bvalid(s_axi_bvalid),
    .S_AXI_bready (s_axi_bready),
    .S_AXI_araddr (s_axi_araddr),
    .S_AXI_arvalid(s_axi_arvalid),
    .S_AXI_arready(s_axi_arready),
    .S_AXI_rdata  (s_axi_rdata),
    .S_AXI_rresp  (s_axi_rresp),
    .S_AXI_rvalid(s_axi_rvalid),
    .S_AXI_rready (s_axi_rready)
  );
