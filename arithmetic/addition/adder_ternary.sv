// Copyright (c) 2025 Wesley Piard
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// SPDX-License-Identifier: MIT

module adder_ternary #(
    parameter int WIDTH = 8,
    parameter bit REGISTER_INPUT = 0,
    parameter bit REGISTER_OUTPUT = 0
) (
    input  logic             clk,
    input  logic             rst,
    input  logic [WIDTH-1:0] in0,
    input  logic [WIDTH-1:0] in1,
    input  logic [WIDTH-1:0] in2,
    output logic [WIDTH-1:0] sum
);

  // internal wires
  logic [WIDTH-1:0] in0_int, in1_int, in2_int;
  logic [WIDTH-1:0] sum_int;

  // optionally register inputs
  if (REGISTER_INPUT) begin : g_reg_inputs
    logic [WIDTH-1:0] in0_r = '0;
    logic [WIDTH-1:0] in1_r = '0;
    logic [WIDTH-1:0] in2_r = '0;

    always @(posedge clk) begin
      {in0_r, in1_r, in2_r} <= {in0, in1, in2};
      if (rst) begin
        {in0_r, in1_r, in2_r} <= '0;
      end
    end

    assign {in0_int, in1_int, in2_int} = {in0_r, in1_r, in2_r};
  end else begin : g_comb_inputs
    assign {in0_int, in1_int, in2_int} = {in0, in1, in2};
  end

  // ternary addition
  assign sum_int = in0_int + in1_int + in2_int;

  // optionally register outputs
  if (REGISTER_OUTPUT) begin : g_reg_outputs
    logic [WIDTH-1:0] sum_r = '0;

    always @(posedge clk) begin
      sum_r <= sum_int;

      if (rst) begin
        sum_r <= '0;
      end
    end

    assign sum = sum_r;
  end else begin : g_comb_outputs
    assign sum = sum_int;
  end

endmodule
