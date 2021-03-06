library verilog;
use verilog.vl_types.all;
entity vending_machine is
    generic(
        g1              : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        g2              : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        g3              : vl_logic_vector(0 to 1) := (Hi1, Hi1);
        coin1           : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        coin5           : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        timer           : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        coin            : in     vl_logic_vector(1 downto 0);
        keys            : in     vl_logic_vector(3 downto 0);
        change          : out    vl_logic_vector(3 downto 0);
        sell            : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of g1 : constant is 1;
    attribute mti_svvh_generic_type of g2 : constant is 1;
    attribute mti_svvh_generic_type of g3 : constant is 1;
    attribute mti_svvh_generic_type of coin1 : constant is 1;
    attribute mti_svvh_generic_type of coin5 : constant is 1;
    attribute mti_svvh_generic_type of timer : constant is 1;
end vending_machine;
