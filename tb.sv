`timescale 1ns / 1ps
module tb ();
    logic         clk;
    logic         rstn ;
    logic[1:0]    coin ;
    logic[1:0]    goods;
    logic[1:0]    change ;
    logic         sell ;

    //clock generating

    always #1 clk = ~clk;
    
    initial begin
        clk = 1;
        rstn = 0;
        #5
        rstn = 1;
        #5
        coin = 2'b01;
        #2
        coin = 2'b00;
        goods = 2'd2;
    end

    vending_machine uut(
        .clk    (clk),
        .rstn   (rstn),
        .coin   (coin),
        .goods  (goods),
        .key    (key),
    
        .change  (change),
        .sell    (sell)
    );


 

endmodule // test