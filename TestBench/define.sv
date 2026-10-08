`define COMP_CONSTRUCTOR(CLASS_NAME)\
function new(string name="CLASS_NAME",uvm_component parent);\
  super.new(name,parent);\
endfunction

`define OBJ_CONSTRUCTOR(CLASS_NAME)\
function new(string name="CLASS_NAME");\
  super.new(name);\
endfunction

`define DATA_WIDTH 8
`define ADDR_WIDTH 8
