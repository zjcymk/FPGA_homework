`timescale 1ns / 1ps
module tb ();
    logic         clk;
    logic         rstn ;
    logic[1:0]    coin ;
    logic[3:0]    keys;
    logic[3:0]    change ;
    logic[2:0]    sell ;

    //clock generating

    always #1 clk = ~clk;
    
    initial begin
        clk = 1;
        rstn = 0;
        #5 rstn = 1;
        #5 coin = 2'b10;
        #2 coin = 2'b00;
        #2 keys = 4'b0100;
        #5 keys = 4'd0;
        #10 coin = 2'b10;
        #2 keys = 4'b0010;
           coin = 2'b00;
        #5 keys = 4'd0;
        
    end

    vending_machine uut(
        .clk    (clk),
        .rstn   (rstn),
        .coin   (coin),
        .keys   (keys),
    
        .change  (change),
        .sell    (sell)
    );


 

endmodule // test