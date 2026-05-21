--------------------------------------------------------------------------------
-- Institución : Instituto Politécnico Nacional (IPN) - UPIITA
-- Proyecto    : JOYSTICK_DRIVER
-- Archivo     : TOP.vhd
-- Descripción : Un circuito meramente combinacional, por lo que es inecesario
-- la implementación de un reloj       PENDIENTE
--
--
-- Autor       : ARREGUÍN HERNÁNDEZ JULIO DAVID
-- Fecha       : 17/05/2026
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



--********************************************************
--      Descripcion de la entidad (Entradas y salidas) 
--********************************************************
entity JOYSTICK_DRIVER is
    Port (
        CLK : IN STD_LOGIC;
        JOY_STICK_IN  : in  STD_LOGIC_VECTOR(3 downto 0);
        OUT_JOY_STICK_DRIVER  : out STD_LOGIC_VECTOR(7 downto 0));
end JOYSTICK_DRIVER;
--



--********************************************************
--                      ARQUITECTURA 
--********************************************************
architecture Behavioral of JOYSTICK_DRIVER is

----------------------------------------------------------
--          Constantes y Señales por Proceso
----------------------------------------------------------

-----------------------------------------
-- 				CLOCK_ADC
-----------------------------------------
--Constantes:
--CONSTANT HALF_CLK_ADC: INTEGER:= 39; 

--Señales:
--SIGNAL CONT_ADC : INTEGER := 0;


begin
----------------------------------------------------------------------------------


----------------------------------------------------------
--                       PPROCESOS
----------------------------------------------------------

-----------------------------------------
-- 				CLOCK_ADC
-----------------------------------------
process(CLK)
begin
--        *****A******      
--     *AI*          *AD*   
--   **                  ** 
--  *                      D
--  I                      *
--   **                  ** 
--     *aI**          *aD*   
--        *****a******      

IF RISING_EDGE(CLK) THEN
    case JOY_STICK_IN  is
    
        when "0001" => OUT_JOY_STICK_DRIVER <= "00000001"; --Arriba
        when "0011" => OUT_JOY_STICK_DRIVER <= "00000011"; --Arriba & Derecha
        when "0010" => OUT_JOY_STICK_DRIVER <= "00000010"; --Derecha
        when "0110" => OUT_JOY_STICK_DRIVER <= "00000110"; --Abajo & Derecha
        when "0100" => OUT_JOY_STICK_DRIVER <= "00000100"; --Abajo
        when "1100" => OUT_JOY_STICK_DRIVER <= "00001100"; --Abajo e Izquierda
        when "1000" => OUT_JOY_STICK_DRIVER <= "00001000"; --Izquierda
        when "1001" => OUT_JOY_STICK_DRIVER <= "00001001"; --Arriba e Izquierda                

        when others => OUT_JOY_STICK_DRIVER <= "00000000";
        
    end case ;
END IF;
end process;


-- ASIGNACIONES DIRECTAS ASOCIADAS:


end Behavioral;