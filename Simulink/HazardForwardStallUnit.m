%% Active-HDL Module Description File
function comp = HazardForwardStallUnit

comp.settings.language = 'VERILOG';
comp.settings.lib = 'model';
comp.settings.entity = 'HazardForwardStallUnit';
comp.settings.arch = 'HazardForwardStallUnit';
comp.settings.ahdl_path = 'C:\Aldec\Active-HDL-Student-Edition\';
comp.settings.dsn_path = 'C:\Users\Lama\Downloads\project\project\model';
comp.settings.dsn_file = 'model.adf';
comp.settings.wsp_path = 'C:\Users\Lama\Downloads\project\project';
comp.settings.wsp_file = 'project.aws';

comp.port(1).type = 0;
comp.port(1).name = 'IFID_rs';
comp.port(1).size = 5;
comp.port(1).hdl = '[4:0]wire';
comp.port(2).type = 0;
comp.port(2).name = 'IFID_rt';
comp.port(2).size = 5;
comp.port(2).hdl = '[4:0]wire';
comp.port(3).type = 0;
comp.port(3).name = 'IDEX_rs';
comp.port(3).size = 5;
comp.port(3).hdl = '[4:0]wire';
comp.port(4).type = 0;
comp.port(4).name = 'IDEX_rt';
comp.port(4).size = 5;
comp.port(4).hdl = '[4:0]wire';
comp.port(5).type = 0;
comp.port(5).name = 'IDEX_rd';
comp.port(5).size = 5;
comp.port(5).hdl = '[4:0]wire';
comp.port(6).type = 0;
comp.port(6).name = 'EXMEM_rd';
comp.port(6).size = 5;
comp.port(6).hdl = '[4:0]wire';
comp.port(7).type = 0;
comp.port(7).name = 'MEMWB_rd';
comp.port(7).size = 5;
comp.port(7).hdl = '[4:0]wire';
comp.port(8).type = 0;
comp.port(8).name = 'WB_rd';
comp.port(8).size = 5;
comp.port(8).hdl = '[4:0]wire';
comp.port(9).type = 0;
comp.port(9).name = 'IDEX_MemRead';
comp.port(9).size = 1;
comp.port(9).hdl = 'wire';
comp.port(10).type = 0;
comp.port(10).name = 'EXMEM_RegWrite';
comp.port(10).size = 1;
comp.port(10).hdl = 'wire';
comp.port(11).type = 0;
comp.port(11).name = 'MEMWB_RegWrite';
comp.port(11).size = 1;
comp.port(11).hdl = 'wire';
comp.port(12).type = 0;
comp.port(12).name = 'WB_RegWrite';
comp.port(12).size = 1;
comp.port(12).hdl = 'wire';
comp.port(13).type = 1;
comp.port(13).name = 'stall';
comp.port(13).size = 1;
comp.port(13).hdl = 'reg';
comp.port(14).type = 1;
comp.port(14).name = 'flush';
comp.port(14).size = 1;
comp.port(14).hdl = 'reg';
comp.port(15).type = 1;
comp.port(15).name = 'IFID_Write';
comp.port(15).size = 1;
comp.port(15).hdl = 'reg';
comp.port(16).type = 1;
comp.port(16).name = 'PC_Write';
comp.port(16).size = 1;
comp.port(16).hdl = 'reg';
comp.port(17).type = 1;
comp.port(17).name = 'forwardA';
comp.port(17).size = 2;
comp.port(17).hdl = '[1:0]reg';
comp.port(18).type = 1;
comp.port(18).name = 'forwardB';
comp.port(18).size = 2;
comp.port(18).hdl = '[1:0]reg';

comp.src(1).file = 'C:\Users\Lama\Downloads\project\project\model\src\hazardDetect.v';

