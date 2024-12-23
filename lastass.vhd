module lastass(purchase, ret, cash_in, clk, reset);

    input clk, reset;
    input [1:0] cash_in;
    output reg purchase;
    output reg [2:0] ret;
    
    reg [1:0] state;
    
    // State definitions
    parameter   S0 = 2'b00, 
                S1 = 2'b01, 
                S2 = 2'b10, 
                S3 = 2'b11;
    
    // Return amounts
    parameter   R0 = 3'b000, 
                R20 = 3'b001, 
                R30 = 3'b010,
                R40 = 3'b011, 
                R50 = 3'b100,
                R70 = 3'b101,
                R90 = 3'b110;  
    
    always@(posedge clk or posedge reset)
    begin
        if (reset) 
        begin
            // Reset state and outputs
            state = S0;
            purchase = 0;
            ret = R0;
        end
        else 
        begin
            case(state)    
                S0: 
                    case(cash_in)
                        2'b00: begin  
                               state = S0;
                               purchase = 0;
                               ret = R0;
                               end
                        2'b01: begin 
                               state = S1;
                               purchase = 0;
                               ret = R0;
                               end
                        2'b10: begin
                               state = S2;
                               purchase = 0;
                               ret = R0;
                               end
                        2'b11: begin   
                               state = S0;
                               purchase = 1;
                               ret = R40; // Purchase successful, return 40
                               end
                        default: begin end
                    endcase
                        
                S1: 
                    case(cash_in)
                        2'b00: begin  
                               state = S0;
                               purchase = 0;
                               ret = R30; // Return 30
                               end
                        2'b01: begin 
                               state = S0;
                               purchase = 1;
                               ret = R0;
                               end
                        2'b10: begin
                               state = S0;
                               purchase = 1;
                               ret = R20; // Return 20
                               end
                        2'b11: begin   
                               state = S0;
                               purchase = 1;
                               ret = R70; // Return 70
                               end
                        default: begin end
                    endcase
                    
                S2: 
                    case(cash_in)
                        2'b00: begin  
                               state = S0;
                               purchase = 0;
                               ret = R50; // Return 50
                               end
                        2'b01: begin 
                               state = S0;
                               purchase = 1;
                               ret = R20; // Return 20
                               end
                        2'b10: begin
                               state = S0;
                               purchase = 1;
                               ret = R40; // Return 40
                               end
                        2'b11: begin   
                               state = S0;
                               purchase = 1;
                               ret = R90; // Return 90
                               end
                        default: begin end
                    endcase
                    
                S3: begin
                    // Handle additional state if needed
                    end
                    
                default: begin
                    state = S0;
                    purchase = 0;
                    ret = R0;
                end
            endcase
        end
    end
endmodule
