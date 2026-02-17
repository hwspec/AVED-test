// pca_axi_mmio_bridge.sv
// AXI-Lite slave wrapper for PCACompWithMMIO.
// Add this block in the BD; connect its AXI-Lite slave and assign a base address.

module pca_axi_mmio_bridge (
  input  wire        s_axi_aclk,
  input  wire        s_axi_aresetn,

  input  wire [31:0] s_axi_awaddr,
  input  wire        s_axi_awvalid,
  output wire        s_axi_awready,

  input  wire [31:0] s_axi_wdata,
  input  wire [ 3:0] s_axi_wstrb,
  input  wire        s_axi_wvalid,
  output wire        s_axi_wready,

  output wire [ 1:0] s_axi_bresp,
  output wire        s_axi_bvalid,
  input  wire        s_axi_bready,

  input  wire [31:0] s_axi_araddr,
  input  wire        s_axi_arvalid,
  output wire        s_axi_arready,

  output wire [31:0] s_axi_rdata,
  output wire [ 1:0] s_axi_rresp,
  output wire        s_axi_rvalid,
  input  wire        s_axi_rready
);

  wire        clock = s_axi_aclk;
  wire        reset = ~s_axi_aresetn;

  wire [31:0] mmio_addr;
  wire [31:0] mmio_wdata;
  wire        mmio_wen;
  wire [31:0] mmio_rdata;

  PCACompWithMMIO u_pca (
    .clock         (clock),
    .reset         (reset),
    .io_mmio_addr  (mmio_addr),
    .io_mmio_wdata (mmio_wdata),
    .io_mmio_wen   (mmio_wen),
    .io_mmio_rdata (mmio_rdata)
  );

  // ---- Write FSM ----
  localparam logic [1:0] W_IDLE = 2'd0, W_MMIO = 2'd1, W_B = 2'd2;
  logic [1:0] w_state;
  logic [31:0] w_addr_r, w_data_r;

  assign s_axi_awready = (w_state == W_IDLE) && s_axi_awvalid && s_axi_wvalid;
  assign s_axi_wready  = s_axi_awready;
  assign mmio_wdata    = w_data_r;
  assign mmio_wen      = (w_state == W_MMIO);
  assign s_axi_bresp   = 2'b00;
  assign s_axi_bvalid  = (w_state == W_B);

  always_ff @(posedge s_axi_aclk) begin
    if (!s_axi_aresetn) begin
      w_state <= W_IDLE;
    end else case (w_state)
      W_IDLE: if (s_axi_awvalid && s_axi_wvalid) begin
        w_addr_r <= s_axi_awaddr;
        w_data_r <= s_axi_wdata;
        w_state  <= W_MMIO;
      end
      W_MMIO: w_state <= W_B;
      W_B:    if (s_axi_bready) w_state <= W_IDLE;
      default: w_state <= W_IDLE;
    endcase
  end

  // ---- Read FSM ----
  localparam logic [1:0] R_IDLE = 2'd0, R_MMIO = 2'd1, R_R = 2'd2;
  logic [1:0] r_state;
  logic [31:0] r_addr_r, r_data_r;

  assign s_axi_arready = (r_state == R_IDLE) && s_axi_arvalid && (w_state != W_MMIO);
  assign s_axi_rdata   = r_data_r;
  assign s_axi_rresp   = 2'b00;
  assign s_axi_rvalid  = (r_state == R_R);

  // mmio_addr: write path in W_MMIO, read path in R_MMIO/R_R, else don't care
  assign mmio_addr = (w_state == W_MMIO) ? w_addr_r :
                     (r_state == R_MMIO || r_state == R_R) ? r_addr_r : 32'b0;

  always_ff @(posedge s_axi_aclk) begin
    if (!s_axi_aresetn) begin
      r_state <= R_IDLE;
    end else case (r_state)
      R_IDLE: if (s_axi_arvalid && w_state != W_MMIO) begin
        r_addr_r <= s_axi_araddr;
        r_state  <= R_MMIO;
      end
      R_MMIO: begin
        r_data_r <= mmio_rdata;
        r_state  <= R_R;
      end
      R_R: if (s_axi_rready) r_state <= R_IDLE;
      default: r_state <= R_IDLE;
    endcase
  end

endmodule
