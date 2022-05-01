library verilog;
use verilog.vl_types.all;
entity vending_machine is
    generic(
        coin1           : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        coin5           : vl_logic_vector(0 to 1) := (Hi1, Hi0)
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        coin            : in     vl_logic_vector(1 downto 0);
        goods           : in     vl_logic_vector(1 downto 0);
        key             : in     vl_logic;
        change          : out    vl_logic_vector(2 downto 0);
        sell            : out    vl_logic_vector(2 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of coin1 : constant is 1;
    attribute mti_svvh_generic_type of coin5 : constant is 1;
end vending_machine;
