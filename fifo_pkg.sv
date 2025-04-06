`define BUFF_WIDTH 4    // BUF_SIZE = 16 -> BUF_WIDTH = 4, no. of bits to be used in pointer
`define BUFF_SIZE ( 1<<`BUFF_WIDTH )

`include "interface.sv"
`include "seq_item.sv"
`include "sequence_lib.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "fifo_base_test.sv"
`include "wr_rd_test.sv"
`include "wr_full_test.sv"

