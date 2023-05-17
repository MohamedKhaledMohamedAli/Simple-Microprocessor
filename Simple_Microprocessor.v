// Code for a Microprocessor
module mcu #(
  parameter op_sz = 32,
  parameter mem_sz
)(
  input wire clk, reset,
  input wire [mem_sz-1:0] op0,
  input wire [op_sz-1:0] op1,
  input wire [mem_sz-1:0] op2,
  input wire [3:0] op,
  output wire [op_sz-1:0] out,
  output wire op_err
);
  
  reg [op_sz-1 : 0] mem [0:(2**mem_sz)-1];
  
  //Variable represent read operation
  localparam op_read = 7;
  
  //Variable to iterate in the loop
  integer i;
  
  always @(posedge clk or reset) begin
    
    if (reset) begin
      for(i = 0;i <= ((2**mem_sz)-1);i=i+1)
        mem[i] <= 0;
    end
    else begin
      case (op)
        
        //Add
        0: mem[op2] <= mem[op0] + mem[op1];
      
        //Subtract
        1: mem[op2] <= mem[op0] - mem[op1];
      
        //Multiply
        2: mem[op2] <= mem[op0] * mem[op1];
      
        //Divide
        3: mem[op2] <= mem[op0] / mem[op1];
      
        //And
        4: mem[op2] <= mem[op0] & mem[op1];
      
        //OR
        5: mem[op2] <= mem[op0] | mem[op1];
      
        //XOR
        6: mem[op2] <= mem[op0] ^ mem[op1];
        
        //Write Operation
        8: mem[op0] <= op1;
      
        default: begin
        end
      endcase
    end 
  end
  
  //Read Operation
  assign out = (op == op_read)? mem[op0] : 0;
    
  //If invalid operation
  assign op_err = (op > 8)? 1 : 0;
  
endmodule
