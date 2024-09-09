
module datapath(
	rst,
	clk
);


input	rst;
input	clk;

wire	jumpSignal;
wire	[15:0] PCR7;
wire	[15:0] currentPC;
wire	[15:0] instruction;
wire	IFIDwrite;
wire	mode;
wire	[15:0] PCIFID;
wire	[4:0] I_immediateIFID;
wire	[11:0] jmpOffsetIFID;
wire	[3:0] opcodeIFID;
wire	[2:0] rdIFID;
wire	[2:0] rs1IFID;
wire	[2:0] rs2IFID;
wire	[8:0] S_immediateIFID;
wire	[15:0] extendedImm;
wire	[2:0] selectedRd;
wire	[15:0] regAIDEX;
wire	[15:0] regBIDEX;
wire	immType;
wire	extOp;
wire	[4:0] I_immediate;
wire	[8:0] S_immediate;
wire	[15:0] ALU_out;
wire	[2:0] RdEx;
wire	[15:0] regBEx;
wire	[11:0] jmpOffset;
wire	[15:0] PCplus2;
wire	[15:0] branchPC;
wire	[15:0] jumpPC;
wire	[15:0] returnPC;
wire	[1:0] PCsrcSignal;
wire	PCwrite;
wire	[15:0] PCnext;
wire	branchSignal;
wire	modeOut;
//wire	zeroFlag;
//wire	branchFlag;
wire	stall;
wire	[3:0] opcode;
wire	IDEX_MemRead;
wire	EXMEM_RegWrite;
wire	MEMWB_RegWrite;
wire	memToReg;
wire	[2:0] RdMem;
wire	[15:0] regA;
wire	[2:0] Rs1;
wire	[2:0] Rs2;
wire	[2:0] Rd;
wire	regWrite;
wire	[15:0] currentPCoutIFID;
wire	[15:0] dataOut;
wire	RegDst;
wire	[2:0] RdOut;
wire	[15:0] readData1;
wire	[15:0] dataIn;
wire	[1:0] forwardA;
wire	[15:0] readData2;
wire	[1:0] forwardB;
wire	[2:0] ALUop;
wire	[15:0] regB;
wire	ALUSrcB;
wire	[15:0] imm_outIDEX;
wire	MemWrite;
wire	MemRead;
wire	[15:0] aluResultMem;
wire	[15:0] regBMem;
wire	[15:0] memDataOut;	 
//updated wires
wire flush;
wire RegWrtie_out_IDEX;	
wire ALUSrcB_out_IDEX;
wire MemRead_out_IDEX;
wire MemWrite_out_IDEX;	
wire MemToReg_out_IDEX;	 
wire IDEX_MemRead_IDEX;
wire EXMEM_RegWrite_out_IDEX;
wire MEMWB_RegWrite_out_IDEX;
wire [2:0] ALUOp_out_IDEX;
//// 
wire RegWrite_out_EXMEM;
wire MemRead_out_EXMEM;
wire MemWrite_out_EXMEM;
wire MemToReg_out_EXMEM;
wire EXMEM_RegWrite_out_EXMEM;
wire MEMWB_RegWrite_out_EXMEM;
/////\
wire RegWrite_out_MEMWB;
wire MEMWB_RegWrite_out_MEMWB;
///
wire extendedImmBranch;


returnLogic	b2v_inst(
	.jumpSignal(jumpSignal),
	.returnPC(PCR7),
	.jumpTarget(returnPC));


InstructionMemory	b2v_inst18(
	.pc(currentPC),
	.instruction(instruction));


instruction_decoder	b2v_inst19(	 
	.currentPC(currentPC),
	.instruction(instruction),
	.mode(mode),
	.currentPCout(PCIFID),
	.I_immediate(I_immediateIFID),
	.jmp_offset(jmpOffsetIFID),
	.opcode(opcodeIFID),
	.rd(rdIFID),
	.rs1(rs1IFID),
	.rs2(rs2IFID),
	.S_immediate(S_immediateIFID));
	defparam	b2v_inst19.I_IMM_WIDTH = 5;
	defparam	b2v_inst19.JMP_OFFSET_WIDTH = 12;
	defparam	b2v_inst19.OPCODE_WIDTH = 4;
	defparam	b2v_inst19.REG_WIDTH = 3;
	defparam	b2v_inst19.S_IMM_WIDTH = 9;


IF_ID	b2v_inst20(
	.IFIDwr(IFIDwrite),
	.clk(clk),
	.rst(rst),
	.mode_in(mode),
	.currentPC(PCIFID),
	.I_immediate_in(I_immediateIFID),
	.jmp_offset_in(jmpOffsetIFID),
	.opcode_in(opcodeIFID),
	.rd_in(rdIFID),
	.rs1_in(rs1IFID),
	.rs2_in(rs2IFID),
	.S_immediate_in(S_immediateIFID),
	.mode_out(modeOut),
	.currentPCout(currentPCoutIFID),
	.I_immediate_out(I_immediate),
	.jmp_offset_out(jmpOffset),
	.opcode_out(opcode),
	.rd_out(RdOut),
	.rs1_out(Rs1),
	.rs2_out(Rs2),
	.S_immediate_out(S_immediate));
	defparam	b2v_inst20.I_IMM_WIDTH = 5;
	defparam	b2v_inst20.JMP_OFFSET_WIDTH = 12;
	defparam	b2v_inst20.OPCODE_WIDTH = 4;
	defparam	b2v_inst20.REG_WIDTH = 3;
	defparam	b2v_inst20.S_IMM_WIDTH = 9;


ID_EX	b2v_inst21(
	.clk(clk),
	.rst(rst),
	.imm_in(extendedImm),
	.rd_in(selectedRd),
	.regA_in(regAIDEX),
	.regB_in(regBIDEX),	
	///// updated  inputs
	.RegWrite_in(regWrite),	
	.ALUSrcB_in(ALUSrcB),
	.MemRead_in(MemRead),
	.MemWrite_in(MemWrite),	
	.MemToReg_in(memToReg),
	.IDEX_MemRead_in(IDEX_MemRead),
	.EXMEM_RegWrite_in(EXMEM_RegWrite),
	.MEMWB_RegWrite_in(MEMWB_RegWrite),
	.ALUOp_in(ALUop),
	.flush(flush),
	//// updated outputs
	.RegWrite_out(RegWrtie_out_IDEX), // will go to EXMEM 	
	.ALUSrcB_out(ALUSrcB_out_IDEX),	  // goes to its place
	.MemRead_out(MemRead_out_IDEX),	  // will go to EXMEM
	.MemWrite_out(MemWrite_out_IDEX), // will go to EXMEM	
	.MemToReg_out(MemToReg_out_IDEX), // will go to EXMEM 
	.IDEX_MemRead_out(IDEX_MemRead_IDEX), // will go to its place
	.EXMEM_RegWrite_out(EXMEM_RegWrite_out_IDEX), // goes to EXMEM
	.MEMWB_RegWrite_out(MEMWB_RegWrite_out_IDEX), // will go to EXMEM
	.ALUOp_out(ALUOp_out_IDEX),	  // goes to its place
	////////
	.imm_out(imm_outIDEX),
	.rd_out(RdEx),
	.regA_out(regA),
	.regB_out(regBEx));


Extender	b2v_inst22(
	.immediate_signal(immType),
	.extOp(extOp),
	.I_immediate(I_immediate),
	.S_immediate(S_immediate),
	.extended(extendedImm));


EX_MEM	b2v_inst23(
	.clk(clk),
	.rst(rst),
	.alu_out_in(ALU_out),
	.rd_in(RdEx),
	.regB_in(regBEx),
	// updated inputs
	.flush(flush),
	.RegWrite_in(RegWrtie_out_IDEX),
	.MemRead_in(MemRead_out_IDEX),
	.MemWrite_in(MemWrite_out_IDEX),
	.MemToReg_in(MemToReg_out_IDEX),
	.EXMEM_RegWrite_in(EXMEM_RegWrite_out_IDEX),
	.MEMWB_RegWrite_in(MEMWB_RegWrite_out_IDEX),
	// updated outputs
	.RegWrite_out(RegWrite_out_EXMEM), // will go to MEMWB
	.MemRead_out(MemRead_out_EXMEM),   // goes to its place
	.MemWrite_out(MemWrite_out_EXMEM), // goes to its place
	.MemToReg_out(MemToReg_out_EXMEM), // goes to its place
	.EXMEM_RegWrite_out(EXMEM_RegWrite_out_EXMEM), // goes to its place
	.MEMWB_RegWrite_out(MEMWB_RegWrite_out_EXMEM), // will go to  MEMWB
	//////
	.alu_out_out(aluResultMem),
	.rd_out(RdMem),
	.regB_out(regBMem));


jumpLogic	b2v_inst25(
	.jumpSignal(jumpSignal),
	.jumpOffset(jmpOffset),
	.pc(currentPC),
	.jumpTarget(jumpPC));


add2	b2v_inst26(
	.pcIn(currentPC),
	.pcout(PCplus2));


MUX4to1	b2v_inst27(
	.in0(PCplus2),
	.in1(branchPC),
	.in2(jumpPC),
	.in3(returnPC),
	.sel(PCsrcSignal),
	.out(PCnext));


PCReg	b2v_inst28(
	.clk(clk),
	.rst(rst),
	.PCwrite(PCwrite),
	.pc_nxt(PCnext),
	.pc(currentPC));


addImmToPC	b2v_inst29(
	.branchSignal(branchSignal),
	.offset(extendedImmBranch),
	.pc(currentPC),
	.pcout(branchPC));

branchLogic test(
	.opcode(opcode),
	.rd(readData1),
	.rs(readData2),
	.immediate(extendedImm),
	.branchSignal(branchSignal),
	.offset(extendedImmBranch)
);
signalsControlUnit	b2v_inst30(
	.mode(modeOut),
	//.zero(zeroFlag),
	.branchFlag(branchSignal),
	.stall(stall),
	.opcode(opcode),
	.extOp(extOp),					// goes to its place imm ---------------------------- done
	.RegDst(RegDst),				// goes to its place imm ---------------------------- done
	.RegWrite(regWrite),			// goes to ID/EX then EX/MEM then MEM/WB
	.ALUSrcB(ALUSrcB),				// goes to ID/EX
	//.Branch(branchSignal),			// goes to ID/EX 
	.MemRead(MemRead),				// goes to ID/EX then EX/MEM 
	.MemWrite(MemWrite),			// goes to ID/EX then EX/MEM
	.MemToReg(memToReg),			// goes to ID/EX then EX/MEM 
	.Jump(jumpSignal),				// goes to its place imm ---------------------------- done
	.immediateType(immType),		// goes tp its place imm ---------------------------- done
	.IDEX_MemRead(IDEX_MemRead),	// goes immediatey to Hazards detector
	.EXMEM_RegWrite(EXMEM_RegWrite),// goes to ID/EX then EX/MEM
	.MEMWB_RegWrite(MEMWB_RegWrite),// goes to ID/EX then EX/MEM then MEM/WB
	.ALUOp(ALUop),					// goes to ID/EX 
	.PCSrc(PCsrcSignal));			// goes to its place imm ---------------------------- done


HazardForwardStallUnit	b2v_inst31(
	.IDEX_MemRead(IDEX_MemRead_IDEX),
	.EXMEM_RegWrite(EXMEM_RegWrite_out_EXMEM),
	.MEMWB_RegWrite(MEMWB_RegWrite_out_MEMWB),
	.WB_RegWrite(MEMWB_RegWrite_out_MEMWB),
	.EXMEM_rd(RdMem),
	.IDEX_rd(RdEx),
	.IDEX_rs(regA),
	.IDEX_rt(regBEx),
	.IFID_rs(Rs1),
	.IFID_rt(Rs2),
	.MEMWB_rd(Rd),
	.WB_rd(Rd),
	.stall(stall),
	.flush(flush),
	.IFID_Write(IFIDwrite),
	.PC_Write(PCwrite),
	.forwardA(forwardA),
	.forwardB(forwardB));


register_file	b2v_inst32(
	.clk(clk),
	.rst(rst), 
	.opcode(opcode),
	.reg_write(RegWrite_out_MEMWB),
	.currentPC(currentPCoutIFID),
	.rd(Rd),
	.rs1(Rs1),
	.rs2(Rs2),
	.write_data(dataOut),
	.PCout(PCR7),
	.read_data1(readData1),
	.read_data2(readData2));
	defparam	b2v_inst32.DATA_WIDTH = 16;
	defparam	b2v_inst32.NUM_REGS = 8;
	defparam	b2v_inst32.REG_WIDTH = 3;


mux2x1Rd	b2v_inst33(
	.sel(RegDst),
	.r1(Rs2),
	.r2(RdOut),
	.selectedR(selectedRd));


MUX4to1	b2v_inst34(
	.in0(readData1),
	.in1(ALU_out),
	.in2(dataIn),
	.in3(dataOut),
	.sel(forwardA),
	.out(regAIDEX));


MUX4to1	b2v_inst35(
	.in0(readData2),
	.in1(ALU_out),
	.in2(dataIn),
	.in3(dataOut),
	.sel(forwardB),
	.out(regBIDEX));


alu	b2v_inst36(
	.A(regA),
	.ALUOp(ALUOp_out_IDEX),
	.B(regB),
	//.Zero(zeroFlag),
	//.branchFlag(branchFlag),
	.Result(ALU_out));


MUX2to1	b2v_inst37(
	.sel(ALUSrcB_out_IDEX),
	.in0(regBEx),
	.in1(imm_outIDEX),
	.out(regB));


ByteAddressableMemory	b2v_inst38(
	.clk(clk),
	.reset(rst),
	.mem_write(MemWrite_out_EXMEM),
	.mem_read(MemRead_out_EXMEM),
	.address(aluResultMem),
	.data_in(regBMem),
	.data_out(memDataOut));


MUX2to1	b2v_inst39(
	.sel(MemToReg_out_EXMEM),
	.in0(aluResultMem),
	.in1(memDataOut),
	.out(dataIn));			  
	
MEM_WB	b2v_inst40(
	.clk(clk),
	.rst(rst),
	.data(dataIn),
	.rd_in(RdMem),
	// updated inputs
	.RegWrite_in(RegWrite_out_EXMEM),
	.MEMWB_RegWrite_in(MEMWB_RegWrite_out_EXMEM),
	.flush(flush),	
	// updated outputs
	.RegWrite_out(RegWrite_out_MEMWB),
	.MEMWB_RegWrite_out(MEMWB_RegWrite_out_MEMWB),
	////
	.data_out(dataOut),
	.rd_out(Rd));


endmodule
