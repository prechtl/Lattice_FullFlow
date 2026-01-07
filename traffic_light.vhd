library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light is
port
(
  clk     : in  std_logic;
  reset   : in  std_logic;
  red     : out std_logic;
  yellow  : out std_logic;
  green   : out std_logic
);
end traffic_light;

architecture Behavioral of traffic_light is

    type state_type is (S_RED, S_GREEN, S_YELLOW);
    signal state    : state_type := S_RED;
    signal counter  : integer range 0 to 100 := 0;

begin
process(clk, reset)
begin
  if (reset = '1') then
    state       <= S_RED;
    counter     <= 0;
  elsif rising_edge(clk) then
    if (counter < 100) then
      counter   <= counter + 1;
    else
      counter   <= 0;
      case state is
        when S_RED =>
          state <= S_GREEN;
        when S_GREEN =>
          state <= S_YELLOW;
        when S_YELLOW =>
          state <= S_RED;
        when others =>
          state <= S_RED; -- Just in case - stop!
      end case;
    end if;
  end if;
end process;

red    <= '1' when state = S_RED    else '0';
green  <= '1' when state = S_GREEN  else '0';
yellow <= '1' when state = S_YELLOW else '0';

end Behavioral;
