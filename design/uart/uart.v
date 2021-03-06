//==============================================================================
// Design name : uart
// File name   : uart.v
// Function	   : UART receive and transmit module
// Engineer    : Dennis Pinto Rivero danielpintoriv@gmail.com
//
// Notes: Sends (and expect to receive) the least significative bit first. 
// Data_to_send must be kept 1 cycle more after triggering start.
//==============================================================================

module uart (
    input wire rst_n,
    input wire clk,
	
	// External interface
    input wire rx,
	output wire tx,
 
	// Control
    input wire clear,
	input wire start_transmit,
    output wire tx_busy,
	output wire rx_busy,
    output wire error,
    output wire new_value,

	// Data
	input wire [7:0] data_to_send,
    output wire [7:0] recvd_data
);

parameter  clock_frequency        = 12000000;
parameter  baud_rate              = 9600;

localparam clock_cycles_per_pulse = clock_frequency / baud_rate;

// UART receive module
uart_rx #(
	.clock_frequency(clock_frequency),
	.baud_rate(baud_rate) 
) uart_rx(
	.rst_n(rst_n),
	.clk(clk),
	.rx(rx),
	.clear(clear),
	.data(recvd_data),
	.busy(rx_busy),
    .error(error),
    .new_value(new_value)
);
	
// UART transmit module
uart_tx #(
	.clock_frequency(clock_frequency),
	.baud_rate(baud_rate) 
) uart_tx(
	.rst_n(rst_n),
	.clk(clk),
	.start(start_transmit),
	.data(data_to_send),
	.tx(tx),
	.busy(tx_busy)
);

endmodule
