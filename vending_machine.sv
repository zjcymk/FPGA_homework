module vending_machine (
    input       clk ,
    input       rstn ,
    input [1:0] coin ,
    input [1:0] goods,
    input       key,

    output [2:0]change,
    output [2:0]sell    //Goods sold
);
/*
parameter g1 = 2'd1;
parameter g2 = 2'd2;
parameter g3 = 2'd3;
*/
parameter coin1 = 2'b01; //1 yuan coin
parameter coin5 = 2'b10; //2 yuan coin
//machine state decode
enum logic [2:0] { 
    IDLE,
    S1,
    S2,
    S3,
    S5
 } state;


logic [3:0] st_next; //next state
logic [3:0] st_cur;  //current state
logic [7:0] count;   //refund Timer
logic [3:0] coins;   //Amount
logic       refund;

logic [3:0] change_r;
logic [3:0] sell_r  ;
logic       error_r;
assign change = change_r;
assign sell   = sell_r  ;

//state transfer
always_ff @( posedge clk ) begin 
    if (!rstn) begin
        st_cur <= IDLE;
        refund <= 1'b0;
    end else begin
        st_cur <= st_next;
    end
end

//state switch, using block assignment for combination-logic
//all case items need to be displayed completely    
always_comb begin 
    if ((count == 8'd60)||(key))
        st_next <= IDLE;
    else
    case (st_cur)
        IDLE : 
            case (coin)
                coin1: st_next = S1;
                coin5: st_next = S5;
                default: st_next = IDLE;
            endcase
        S1 :
            case (coin)
                coin1: st_next = S2;
                default: st_next = S1;
            endcase
        S2 :
            case (coin)
                coin1: st_next = S3;
                default: st_next = S2;
            endcase
        S3 :
            case (coin)
                coin1: st_next = IDLE;
                default: st_next = S3;
            endcase
        S5 :
            case (coin)
                coin1: st_next = IDLE;
                default: st_next = S5;
            endcase
        default: st_next = IDLE;
    endcase
end

//output logic
always_ff @( posedge clk ) begin 
    if (!rstn) begin
        change_r <= 1'b0;
        sell_r   <= 1'b0;
        error_r  <= 1'b0;
    end else if (key||refund) begin     //refund
        change_r <= coins;
        sell_r   <= 1'b0;
        refund   <= 1'b0;
    end else if (coins == goods) begin  //amount = goods
        change_r <= 1'b0;
        sell_r   <= goods;
    end else if (coins > goods)begin    //amount > goods
        change_r <= coins - goods;
        sell_r   <= goods;
    end else if ((coins < goods)&&(count == 8'd60))begin    //amount < goods
        change_r <= coins;
        sell_r   <= 1'b0;
    end
end
/******Amount******/
always_comb begin
    case (st_cur)
        IDLE: coins = 4'd0;
        S1: coins = 4'd1;
        S2: coins = 4'd2;
        S3: coins = 4'd3;
        S5: coins = 4'd5;
        default: coins = 4'b0;
    endcase
end
/******refund Timer******/
always_ff @( posedge clk ) begin 
    if (!rstn) begin
        count <= 8'b0;
    end else if (count == 8'd60) begin
        count <= 8'b0;
        refund <= 1'b1;
    end else 
        count <= count + 1;
end

endmodule