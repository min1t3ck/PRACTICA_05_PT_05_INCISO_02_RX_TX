--------------------------------------------------------------------------------
-- Institución : Instituto Politécnico Nacional (IPN) - UPIITA
-- Proyecto    : CONTROLADOR DE UN MECANÍSMO "AZIMUT" MEDIANTE UN JOYSTICK A TRAVES DE UNA COMUINICACIÓN SERIAL RS232
-- Archivo     : TOP_RX.vhd
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

entity TOP_RX is
    Port (
        CLK    : in  STD_LOGIC;
        RX_IN : in STD_LOGIC;
        SERVO_UP_DONW_PWM : out STD_LOGIC;
        SERVO_L_R_PWM : out STD_LOGIC
        --SERVO_DOWN_PWM : out STD_LOGIC
    );
end TOP_RX;



--*********************************************************
--                      Estructura 
--********************************************************
architecture Structural of TOP_RX is

---------------------------------------
--	   DECLARACIÓN DE COMPONENTES
---------------------------------------

    component RX_RECEIVER
        Port (
         CLK : in STD_LOGIC;
			RX_IN : in STD_LOGIC;-- ENTRADA (BUS DE DATOS)
			E : out STD_LOGIC_VECTOR(7 DOWNTO 0)); -- REGISTRO PARA MOSTRAR LOS DATOS
			  --DEBUGER : out STD_LOGIC;
			  --DEBUGER2 : out STD_LOGIC); 
    end component;

    component FRECUENCY_DRIVER_UP_DOWN
    Port ( 	CLK : in STD_LOGIC;
			DATA_IN : in STD_LOGIC_VECTOR(7 DOWNTO 0);-- ENTRADA (BUS DE DATOS paralelo)
			SERVO_INCRE : out STD_LOGIC; 
			SERVO_DECRE : out STD_LOGIC);  
			  --DEBUGER2 : out STD_LOGIC); 
    end component;

    component FRECUENCY_LR
    Port ( 	CLK : in STD_LOGIC;
			DATA_IN : in STD_LOGIC_VECTOR(7 DOWNTO 0);-- ENTRADA (BUS DE DATOS paralelo)
			SERVO_INCRE : out STD_LOGIC; 
			SERVO_DECRE : out STD_LOGIC);  
			  --DEBUGER2 : out STD_LOGIC); 
    end component;

    component SERVO_DRIVER
        Port ( 	CLK : in STD_LOGIC;
                SERVO_INCRE : in STD_LOGIC; --
                SERVO_DECRE : in STD_LOGIC;  --
                CONTROL_POS : out STD_LOGIC);-- 
    end component;
----------------------------------------------------------
--          Constantes y Señales por Proceso
----------------------------------------------------------

SIGNAL SIGNAL_DATA : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL SIGNAL_SERVO_DOWN_PUSH : STD_LOGIC;
SIGNAL SIGNAL_SERVO_UP_PUSH : STD_LOGIC;

SIGNAL SIGNAL_SERVO_R_PUSH : STD_LOGIC;
SIGNAL SIGNAL_SERVO_L_PUSH : STD_LOGIC;
begin

----------------------------------------------------------
--               CONEXION DE COMPONENTES
----------------------------------------------------------

    RX_UART : RX_RECEIVER
    port map (
        CLK => CLK,
		RX_IN => RX_IN, 
		E => SIGNAL_DATA	--Conectamos a SEND un Reloj para comandar en envio de datos constante
        );

    FREC_DRIVER_UP_DOWN : FRECUENCY_DRIVER_UP_DOWN
    port map (
            CLK => CLK,
			DATA_IN => SIGNAL_DATA, --
			SERVO_INCRE => SIGNAL_SERVO_UP_PUSH, 
			SERVO_DECRE => SIGNAL_SERVO_DOWN_PUSH);


    FREC_DRIVER_L_R : FRECUENCY_LR
    port map (
            CLK => CLK,
			DATA_IN => SIGNAL_DATA, --
			SERVO_INCRE => SIGNAL_SERVO_R_PUSH, 
			SERVO_DECRE => SIGNAL_SERVO_L_PUSH);


    SERVO_CONTROL_UP_DOWN : SERVO_DRIVER
    port map(
            CLK => CLK,
            SERVO_INCRE => SIGNAL_SERVO_UP_PUSH,--
            SERVO_DECRE => SIGNAL_SERVO_DOWN_PUSH,  --
            CONTROL_POS => SERVO_UP_DONW_PWM-- 
        );

    SERVO_CONTROL_L_R : SERVO_DRIVER
    port map(
            CLK => CLK,
            SERVO_INCRE => SIGNAL_SERVO_L_PUSH,--
            SERVO_DECRE => SIGNAL_SERVO_R_PUSH,  --
            CONTROL_POS => SERVO_L_R_PWM-- 
        );
----------------------------------------------------------
--                       PPROCESOS
----------------------------------------------------------   
--
end Structural;