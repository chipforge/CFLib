//  ************    CFLib   *******************************************
//
//  Organisation:   Chipforge
//                  Germany / European Union
//
//  Profile:        Chipforge focus on fine System-on-Chip Cores in
//                  Verilog HDL Code which are easy understandable and
//                  adjustable. For further information see
//                          www.chipforge.org
//                  there are projects from small cores up to PCBs, too.
//
//  File:           CFLib/asyncrst/RTL/asyncrst.sv
//
//  Purpose:        Synchronizer for low-active external Reset
//
//  ************    IEEE 1800-2012 (SystemVerilog 2012) ***************
//
//  ///////////////////////////////////////////////////////////////////
//
//  Copyright (c)   2019, 2020 by
//                  chipforge <cflib@nospam.chipforge.org>
//
//      This Source Code Library is licensed under the Libre Silicon
//      public license; you can redistribute it and/or modify it under
//      the terms of the Libre Silicon public license as published by
//      the Libre Silicon alliance, either version 1 of the License, or
//      (at your option) any later version.
//
//      This design is distributed in the hope that it will be useful,
//      but WITHOUT ANY WARRANTY; without even the implied warranty of
//      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
//      See the Libre Silicon Public License for more details.
//
//  ///////////////////////////////////////////////////////////////////

//  -------------------------------------------------------------------
//                          MODULE
//  -------------------------------------------------------------------

//                               __________________________________
//  aresetn XXXX\_______________/
//              ___     ___     ___     ___     ___     ___     ___
//  clock   ___|   |___|   |___|   |___|   |___|   |___|   |___|   
//               ______________________________________
//  sreset  XXXX/                                      \___________
//              ^               ^                      ^
//              | aresetn goes asynchronous active
//                              | aresetn release asynchronously
//                              |<----  delayed  ----->| synchronous
//                                                       released

module asyncrst (
    output logic sreset,
    input logic clock,
    input logic aresetn);

    parameter NSTAGES = 3;      // number of stages

//  ------------    shift register      -------------------------------

logic [NSTAGES-1:0] shiftreg;

//  aresetn >-------*---------------*---------------.
//               ___o___         ___o___         ___o___
//              |   SN  |       |   SN  |       |   SN  |
//  'b0 >-------|D     Q|-------|D     Q|-------|D     Q|---> sreset
//              |       |       |       |       |       |
//          .---|>C     |   .---|>C     |   .---|>C     |
//          |   |_______|   |   |_______|   |   |_______|
//  clock >-*---------------*---------------'

// clocked process
always_ff @(posedge clock or negedge aresetn)
begin
    if (!aresetn)
        // reset active
        shiftreg <= {NSTAGES{1'b1}};
    else
        // shift in 'reset release' value from MSB while clocked
        shiftreg <= {1'b0, shiftreg[NSTAGES-1:1]};
end

//  ------------    output matching     -------------------------------

// shiftregister LSB used as output
assign sreset = shiftreg[0];

endmodule:asyncrst
