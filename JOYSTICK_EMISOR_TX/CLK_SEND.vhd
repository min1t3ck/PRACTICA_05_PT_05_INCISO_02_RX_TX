--------------------------------------------------------------------------------
-- Institución : Instituto Politécnico Nacional (IPN) - UPIITA
-- Proyecto    : CLK_SEND
-- Archivo     : CLK_SEND.vhd
-- Descripción : Un reloj para activar el envio de datos de forma constante
--       PENDIENTE
--
--
-- Autor       : ARREGUÍN HERNÁNDEZ JULIO DAVID
-- Fecha       : 17/05/2026
--------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;




--********************************************************
--      Descripcion de la entidad (Entradas y salidas) 
--********************************************************
entity CLK_SEND is
    Port (
        CLK : in STD_LOGIC;
		OUT_CLK: out STD_LOGIC);
end CLK_SEND;
--





--********************************************************
--                      ARQUITECTURA 
--********************************************************
architecture Behavioral of CLK_SEND is
----------------------------------------------------------
--          Constantes y Señales por Proceso
----------------------------------------------------------


-----------------------------------------
-- 				CLOCK_SEND
-----------------------------------------
--Constantes:
CONSTANT HALF_CLK_SEND: INTEGER:= 100_000; --PERIODO DE 2 ms 

--Señales:
SIGNAL CONT_SEND : INTEGER := 0;
SIGNAL FLAG_SEND : STD_LOGIC:= '0';





begin
---------------------------------------------------------------------



----------------------------------------------------------
--                       PPROCESOS
----------------------------------------------------------

-----------------------------------------
-- 				CLOCK_SEND
-----------------------------------------
CLOCK_SEND:process(CLK)

begin
    IF rising_edge(CLK) then --
        IF CONT_SEND =  HALF_CLK_SEND then
           CONT_SEND <= 0;
           FLAG_SEND <= NOT FLAG_SEND;
        else
            CONT_SEND <= CONT_SEND + 1;
        end if;

    END IF;
END process;
-- ASIGNACIONES DIRECTAS ASOCIADAS:
OUT_CLK <= FLAG_SEND;

--



end Behavioral;