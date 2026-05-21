--------------------------------------------------------------------------------
-- Institución : Instituto Politécnico Nacional (IPN) - UPIITA
-- Proyecto    : CONTROLADOR DE UN MECANÍSMO "AZIMUT" MEDIANTE UN JOYSTICK A TRAVES DE UNA COMUINICACIÓN SERIAL RS232
-- Archivo     : TOP.vhd
-- Descripción :
-- PENDIENTE
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

entity TOP is
    Port (
        CLK    : in  STD_LOGIC;
        JOY_STICK_IN : in  STD_LOGIC_VECTOR(3 downto 0); -- Entrada físicas provenientes del JOY STICK
        TX_OUT : out STD_LOGIC
    );
end TOP;



--********************************************************
--                      Estructura 
--********************************************************
architecture Structural of TOP is

---------------------------------------
--	   DECLARACIÓN DE COMPONENTES
---------------------------------------

    component JOYSTICK_DRIVER
        Port (
            CLK : IN STD_LOGIC;
            JOY_STICK_IN  : in  STD_LOGIC_VECTOR(3 downto 0);
            OUT_JOY_STICK_DRIVER  : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;


    component TX_TRASMITTER
        Port (
            CLK : in STD_LOGIC;
		    RESET : in STD_LOGIC;
		    D : in STD_LOGIC_VECTOR(7 DOWNTO 0); -- REGISTRO PARA ENVIAR DATOS
		    SEND : in STD_LOGIC;	-- BIT PARA INICIAR EL ENVÍO DE DATOS
            TX_OUT : out STD_LOGIC);-- SALIDA (BUS DE DATOS)
    end component;


    
    component CLK_SEND
        Port (
            CLK : in STD_LOGIC;
		    OUT_CLK : out STD_LOGIC);	-- BIT PARA INICIAR EL ENVÍO DE DATOS
    end component;


----------------------------------------------------------
--          Constantes y Señales por Proceso
----------------------------------------------------------
SIGNAL TX_SIGNAL : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL CLK_SIGNAL : STD_LOGIC;
--SIGNAL DEBUG : STD_LOGIC;
begin

----------------------------------------------------------
--               CONEXION DE COMPONENTES
----------------------------------------------------------

     JOYSTICK_D : JOYSTICK_DRIVER
        port map (
        -- (DEL PIN DEL COMPONENTE)        =>           (SALIDA O SEÑAL)
        --                          (VA CONECTADO A:)
        CLK => CLK,
        JOY_STICK_IN => JOY_STICK_IN,
        OUT_JOY_STICK_DRIVER => TX_SIGNAL
        );





    TX_UART : TX_TRASMITTER
    port map (
        CLK => CLK,
		RESET => '0',
		D => TX_SIGNAL, --Conectamos entrada de datos a la salida del JOYSTICK_DRIVER
		SEND => CLK_SIGNAL,	--Conectamos a SEND un Reloj para comandar en envio de datos constante
        TX_OUT => TX_OUT
        );


    CLOCK_SEND : CLK_SEND
    port map (
        CLK => CLK,
		OUT_CLK => CLK_SIGNAL	-- BIT PARA INICIAR EL ENVÍO DE DATOS
        );


----------------------------------------------------------
--                       PPROCESOS
----------------------------------------------------------   
--DEBUG <= CLK_SIGNAL;
--DEBUG_PIN <= DEBUG;
end Structural;