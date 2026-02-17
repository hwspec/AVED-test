// axi_lite_mem32_test_bd_wrapper.v
// Wrapper so the BD sees S_AXI + s_axi_aclk/aresetn.
// Instantiates Chisel-generated AxiLiteMem32Test (clock, reset, io_axi_*).

module axi_lite_mem32_test_bd_wrapper (
  input  wire        s_axi_aclk,
  input  wire        s_axi_aresetn,

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

  wire s_axi_reset = ~s_axi_aresetn;

  AxiLiteMem32Test u_core (
    .clock           (s_axi_aclk),
    .reset           (s_axi_reset),
    .io_axi_awaddr   (S_AXI_awaddr[23:0]),
    .io_axi_awvalid  (S_AXI_awvalid),
    .io_axi_awready  (S_AXI_awready),
    .io_axi_wdata    (S_AXI_wdata),
    .io_axi_wstrb    (S_AXI_wstrb),
    .io_axi_wvalid   (S_AXI_wvalid),
    .io_axi_wready   (S_AXI_wready),
    .io_axi_bresp    (S_AXI_bresp),
    .io_axi_bvalid   (S_AXI_bvalid),
    .io_axi_bready   (S_AXI_bready),
    .io_axi_araddr   (S_AXI_araddr[23:0]),
    .io_axi_arvalid  (S_AXI_arvalid),
    .io_axi_arready  (S_AXI_arready),
    .io_axi_rdata    (S_AXI_rdata),
    .io_axi_rresp    (S_AXI_rresp),
    .io_axi_rvalid   (S_AXI_rvalid),
    .io_axi_rready   (S_AXI_rready)
  );

endmodule
