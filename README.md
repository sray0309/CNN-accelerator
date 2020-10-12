# Convolution Core

## Processing Element

Components:
1. 8bits Multiplier
2. 8bits Adder
3. Inside register file

Signals:
```
input:  clk, reset, enable
        16x8 bits A     // constant
        16x8 bits B     // one update every 16 cycles
output: acc_valid       // accumulation completed
        20x8 bits Y     // output data, one read every 16 cycles
```

Points:
1. Multicycle multiplication & addition 
2. With first bits as signed bits


## PE Array

Components:
1. 64 PEs(8x8)
2. B Data update operation(what kind of shift operation is more efficient)
3. Accumulator of 4/8(kernel size) PEs, could be low vdd or low frequency design


## Controller

Components:
1. How to deal with the case when kernel_size/output_channels/input_channels are different
2. Compile the global buffer and determine when to load data and weights from off-chip memory
3. Determine when to update the address of the global buffer to send data to PE Array(basically the address changes every 16 cycles, based on PE's input channel's length)

---
## Interface doc

**PE**

------ IO signals(type), functions ------
**A**(input):   Filter input, width:16(16 numbers)*8(8 bits). Never change.

**B**(input):   Data input, width: 8 bits, change every 16 cycles.

**Aload**(input):   Load filter weights data into PE's registers(each PE has a different filter data, the data stays constant during the period of convolution)

**start**(input):   becomes high after all the filter weights and input data are loaded, the signal defnies the time to start multiplication and accumulation

**acc_valid**(output):  when addition is over(16 cycles), this signal is high.

------ Internal wires/regs, functions ------

**mult**: multiplication result for each time calculation

**S**:  sum register, get final addition result after 16 cycles (when acc_valid is high)

**count**:  counter result, maximum count to 1111

**_enable**:    counter enable signal.

**PE_ARRAY**

------ IO signals(type), functions ------

**enable**(input): enable the module, high during the convolution process

**ibuf_read_data**(input): input data from the input buffer, the data changes once per clk during first loading, to make sure all PEs have the initial input data, then changes to once per 16(NUM_DATA) clks when convolution starts

**fbuf_read_data**(input): filter weights data from the weight buffer, the module only load filter data once for each convolution operation

**acc**(output): high when convolution is done, and output data is ready at the output port

**obuf_write_data**(output): the output of convolution(a single timestep operation)

------ Internal wires/regs, functions ------

**sys_start**: the signal is triggered when both the filter data and input data are loaded into the PE at the initial stage, ie. when both the **input_vld** and **shif_vld** are high.

**input_vld**: the signal turns to high ARRAY_N cycles after turning enable to high, which denotes all initial input data are loaded to PE's input buffer

**shif_vld**: the signal turns to high ARRAY_M * ARRAY_N cycles after enable signal becomes high





------ Other notes ------
1. The start signal should be put in the controller, but now it's in the PE_ARRAY module, the start signal is generated automatically 64 cycles after the enable signal is triggered. If the signal is moved to the controller, it will be more flexible to decide when to start convolution in different OUT_CHANNELS/NUM_KERNEL cases.
2. The controller also needs some stop signals to determin when to stop convolution in different cases.




---
## Notes


### **Cycle reduction:**
With data size as:
1. filter size: (8, 16, 4) - (output channels, input channels, kernel_size)
2. data size: (16, 87) - (input channels, length of sequence length)


Comparison of total cycles:
1. With a 8x4 PE array, 16x84 clock cycles are required, 16 for convolution accumulations, 84 for total number of kernel shifts, 4x additional accumulations could be put in additional accumulators in parallel

2. With a MVM systolic array, 64x84 clock cycles are required, 64 for the multiplication of 8x64 matrix and 64x1 vector, 84 for total number of kernel shifts


## Log
### Feb.12  Wednesday
1.  Finish testing PE. Waveform: "/Waveform/PE.png".
2.  Need to solve quantization problem.
3.  Makefile is not a general file. \$(SIM_FILE) and \$(TESTBENCH) need to change for every testing. When doing testing, need to copy verilog file from "/verilog" into "/testbench" and add ```'include "$()"``` eg: ```'include "../verilog/counter.v" ``` into the original .v file.
4.  One little problem. In PE.v line 52/53, there is an ```if ``` without ```else```, may cause some problems. (latch problem?)

### Feb.13 
1. Finish PE ARRAY design and verification
2. Need to convert weights and input data into complement

### Feb.14
1. Need to implement flexibility of num_channels/num_kernels/filter_length/timesteps
1. Need to compile memory to store weights

### Feb.15
1. Finish Controller and Decoder design and verification (The "filter_load" signal should be enabled at least one cycle before "filter_cnt" start)
2. Memory is compiled
3. signed addition is available in verilog
4. Need to arrange weights and input data in memory
5. Need to finish top level design & connection & verfication

### Feb.16
1. Finish CNN top level design & testbench
2. Combine input bus line and filter bus line into a single data bus line, loading data in order:
   1. first load fiter data
   2. then load input data
   3. then sys_start triggered
   4. until #filter_length accumulations, a series of PEs' ouptuts are sent to signed adders
   5. At the same time, load input data
3. Need correct model data to verify the result
4. Need to add a bias adder as the last stage(add channels' output and bias data)
5. Need to rewrite some code in pe_array.v, let all channels on a line share a same input data buffer, instead of each one owning a input buffer


---
1. Controller - operate 84 times of PE Array
    1. read data from memo, send data to PE Array, get PE Array's output and store
    2. a basic counter, generate read addr and write addr
2. interface(signals) doc -duan
3. compile memory , organize weights and input data
    1. store weights data vertically or horizontally
    2. change negative data to its complement code
    3. learn how to compile memory
4. run a convolution test -last thing

ddl: Saturday -completed

toplevel, ddl: Sunday


## Memory structure

Filter weights, input data

EX:
(8, 16, 8)
(16, 87) 
8bit per data

first 100 addresses(0->99): filter weight data, each address got a data of 8x8 bits 
from address 100->199: input weight data, each address corresponds to a timestep data of size 8x8 bits.

```
DATA      ADDR
filter    //0
...       //...
...       //...
...       //99
input     //...
...       //...
...       //199
```