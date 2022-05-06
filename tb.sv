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
        #4 rstn = 1;
    //*****************
    // coin = 5
    // goods = 2
    // change = 3
    // sell = g2
    //*****************
        #2 coin = 2'b10;
        #4 coin = 2'b00;
        #2 keys = 4'b0100;
        #4 keys = 4'd0;
    //*****************
    // coin = 1+1+1
    // goods = 1
    // change = 2
    // sell = g1
    //*****************
        #10 coin = 2'b01;
        #6 coin = 2'b00;
           keys = 4'b0010;
        #4 keys = 4'd0;
    //*****************
    // coin = 1+1
    // goods = NULL
    // refund is Enable
    // change = 2
    // sell = NULL
    //*****************
        #10 coin = 2'b01;
        #4 coin = 2'b00;
        #6 keys =4'b0001;
        #2 keys = 4'd0;
    //*****************
    // coin = 1+1+1
    // goods = NULL
    // refund is Disable
    // change = 3
    // sell = NULL
    //*****************
        #10 coin = 2'b01;
        #6 coin = 2'b00;

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