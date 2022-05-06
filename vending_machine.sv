module vending_machine (
    input       clk,
    input       rstn,
    input [1:0] coin,
    input [3:0] keys,

    output [3:0]change,
    output [2:0]sell    //Goods sold
);

parameter g1 = 2'd1;
parameter g2 = 2'd2;
parameter g3 = 2'd3;
parameter coin1 = 2'b01; //1 yuan coin
parameter coin5 = 2'b10; //2 yuan coin
parameter timer = 8'd59; //count time
/****machine state decode*****/
enum logic [2:0] { 
    znt_1115190228,
    IDLE,
    S1,
    S2,
    S3,
    S5
 } state;

logic       refund_key;
logic [3:0] goods;
logic [3:0] st_next; //next state
logic [3:0] st_cur;  //current state
logic [7:0] count;   //refund Timer
logic [3:0] coins;   //Amount
logic       refund;


logic [3:0] change_r;
logic [3:0] sell_r  ;
logic       error_r;

logic refund_reg1;
logic refund_reg2;
logic refund_p;

assign refund_key = keys[0];

assign change = refund_p?change_r:1'b0;
assign sell   = refund_p?sell_r:1'b0;
assign refund_p = refund_reg1&(!refund_reg2);

//state transfer
always_ff @( posedge clk ) begin 
    if (!rstn) begin
        st_cur <= IDLE;
    end else begin
        st_cur <= st_next;
    end
end

//state switch, using block assignment for combination-logic
//all case items need to be displayed completely    
always_comb begin 
    if (refund_p)
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
    end else if (refund_p) begin     //refund
        change_r <= coins;
        sell_r   <= 1'b0;
    end else if (coins == goods) begin  //amount = goods
        change_r <= 1'b0;
        sell_r   <= goods;
    end else if (coins > goods)begin    //amount > goods
        change_r <= coins - goods;
        sell_r   <= goods;
    end else if (coins < goods)begin    //amount < goods
        change_r <= 1'b0;
        sell_r   <= 1'b0;
    end else begin
        change_r <= 1'b0;
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
/******Timer******/
always_ff @( posedge clk ) begin 
    if (!rstn) begin
        count <= 8'b0;
    end else if ((count == timer)||refund_p) begin
        count <= 8'b0;
    end else 
        count <= count + 1;
end
/******refund ctrl******/
always_ff @( posedge clk ) begin 
    if (!rstn) begin
        refund <= 1'b0;
    end else if ((count == timer)||refund_key||((coins >= goods)&&(goods != 1'b0)))
        refund <= 1'b1;
    else
        refund <= 1'b0;
end

/****Generate pulse****/
always_ff @( posedge clk ) begin
    if (!rstn) begin
        refund_reg1 <= 1'b0;
        refund_reg2 <= 1'b0;
    end else begin
        refund_reg1 <= refund;
        refund_reg2 <= refund_reg1;
    end
end
/****decod goods code to amount****/
always_comb begin
    case (keys[3:1])
        3'b001: goods = g1;
        3'b010: goods = g2;
        3'b100: goods = g3;
        default: goods = 3'b0;
    endcase
end

endmodule