_main:
;Voltmeter_click_PIC32.c,19 :: 		void main()
;Voltmeter_click_PIC32.c,21 :: 		system_setup();
JAL	_system_setup+0
NOP	
;Voltmeter_click_PIC32.c,23 :: 		UART2_Write_Text( "Entering While Loop...\r\n" );
LUI	R25, hi_addr(?lstr1_Voltmeter_click_PIC32+0)
ORI	R25, R25, lo_addr(?lstr1_Voltmeter_click_PIC32+0)
JAL	_UART2_Write_Text+0
NOP	
;Voltmeter_click_PIC32.c,25 :: 		while (1) {
L_main0:
;Voltmeter_click_PIC32.c,27 :: 		voltage = 0;
SW	R0, Offset(_voltage+0)(GP)
;Voltmeter_click_PIC32.c,29 :: 		measurement = getADC()/2;        // Get ADC result
JAL	_getADC+0
NOP	
ANDI	R2, R2, 65535
SRL	R2, R2, 1
ANDI	R4, R2, 65535
JAL	__Unsigned16IntToFloat+0
NOP	
SW	R2, Offset(_measurement+0)(GP)
;Voltmeter_click_PIC32.c,30 :: 		voltage = (measurement - calibration)*33.3405;
LHU	R4, Offset(_calibration+0)(GP)
JAL	__Unsigned16IntToFloat+0
NOP	
LW	R4, Offset(_measurement+0)(GP)
MOVZ	R6, R2, R0
JAL	__Sub_FP+0
NOP	
LUI	R4, 16901
ORI	R4, R4, 23724
MOVZ	R6, R2, R0
JAL	__Mul_FP+0
NOP	
SW	R2, Offset(_voltage+0)(GP)
;Voltmeter_click_PIC32.c,32 :: 		FloatToStr(voltage, txt);
LUI	R26, hi_addr(_txt+0)
ORI	R26, R26, lo_addr(_txt+0)
MOVZ	R25, R2, R0
JAL	_FloatToStr+0
NOP	
;Voltmeter_click_PIC32.c,34 :: 		UART2_Write_Text(txt);
LUI	R25, hi_addr(_txt+0)
ORI	R25, R25, lo_addr(_txt+0)
JAL	_UART2_Write_Text+0
NOP	
;Voltmeter_click_PIC32.c,35 :: 		UART2_Write(32);
ORI	R25, R0, 32
JAL	_UART2_Write+0
NOP	
;Voltmeter_click_PIC32.c,36 :: 		UART2_Write_Text("mV");
LUI	R25, hi_addr(?lstr2_Voltmeter_click_PIC32+0)
ORI	R25, R25, lo_addr(?lstr2_Voltmeter_click_PIC32+0)
JAL	_UART2_Write_Text+0
NOP	
;Voltmeter_click_PIC32.c,37 :: 		UART2_Write(13);
ORI	R25, R0, 13
JAL	_UART2_Write+0
NOP	
;Voltmeter_click_PIC32.c,38 :: 		UART2_Write(10);
ORI	R25, R0, 10
JAL	_UART2_Write+0
NOP	
;Voltmeter_click_PIC32.c,40 :: 		delay_ms(1000);                //Za test moze sa delay da se resi sample rate, za ozbiljnije interrupt + TMR
LUI	R24, 40
ORI	R24, R24, 45226
L_main2:
ADDIU	R24, R24, -1
BNE	R24, R0, L_main2
NOP	
;Voltmeter_click_PIC32.c,41 :: 		}
J	L_main0
NOP	
;Voltmeter_click_PIC32.c,42 :: 		}
L_end_main:
L__main_end_loop:
J	L__main_end_loop
NOP	
; end of _main
_system_setup:
;Voltmeter_click_PIC32.c,44 :: 		void system_setup( void )
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;Voltmeter_click_PIC32.c,47 :: 		Chip_Select_Direction = 0;       // Set chip select pin to be output
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
LUI	R2, BitMask(TRISC2_bit+0)
ORI	R2, R2, BitMask(TRISC2_bit+0)
_SX	
;Voltmeter_click_PIC32.c,48 :: 		Chip_Select = 1;
LUI	R2, BitMask(RC2_bit+0)
ORI	R2, R2, BitMask(RC2_bit+0)
_SX	
;Voltmeter_click_PIC32.c,50 :: 		UART2_Init(9600);               // Initialize UART module at 9600 bps
ORI	R25, R0, 9600
JAL	_UART2_Init+0
NOP	
;Voltmeter_click_PIC32.c,51 :: 		Delay_ms(300);                  // Wait for UART module to stabilize
LUI	R24, 12
ORI	R24, R24, 13567
L_system_setup4:
ADDIU	R24, R24, -1
BNE	R24, R0, L_system_setup4
NOP	
NOP	
;Voltmeter_click_PIC32.c,52 :: 		UART2_Write_Text( "UART Initialized\r\n" );
LUI	R25, hi_addr(?lstr3_Voltmeter_click_PIC32+0)
ORI	R25, R25, lo_addr(?lstr3_Voltmeter_click_PIC32+0)
JAL	_UART2_Write_Text+0
NOP	
;Voltmeter_click_PIC32.c,54 :: 		voltage = 0;
SW	R0, Offset(_voltage+0)(GP)
;Voltmeter_click_PIC32.c,55 :: 		sum = 0;
SH	R0, Offset(_sum+0)(GP)
;Voltmeter_click_PIC32.c,56 :: 		measurement = 0;
SW	R0, Offset(_measurement+0)(GP)
;Voltmeter_click_PIC32.c,57 :: 		calibration = 0;
SH	R0, Offset(_calibration+0)(GP)
;Voltmeter_click_PIC32.c,59 :: 		Chip_Select = 1;                 // Deselect MCP3204
LUI	R2, BitMask(RC2_bit+0)
ORI	R2, R2, BitMask(RC2_bit+0)
_SX	
;Voltmeter_click_PIC32.c,62 :: 		SPI3_Init_Advanced( _SPI_MASTER, _SPI_8_BIT, 512, _SPI_SS_DISABLE,
MOVZ	R28, R0, R0
ORI	R27, R0, 512
MOVZ	R26, R0, R0
ORI	R25, R0, 32
;Voltmeter_click_PIC32.c,64 :: 		_SPI_ACTIVE_2_IDLE );
ADDIU	SP, SP, -8
SH	R0, 4(SP)
;Voltmeter_click_PIC32.c,63 :: 		_SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW,
SH	R0, 2(SP)
SH	R0, 0(SP)
;Voltmeter_click_PIC32.c,64 :: 		_SPI_ACTIVE_2_IDLE );
JAL	_SPI3_Init_Advanced+0
NOP	
ADDIU	SP, SP, 8
;Voltmeter_click_PIC32.c,65 :: 		Delay_ms(200);
LUI	R24, 8
ORI	R24, R24, 9044
L_system_setup6:
ADDIU	R24, R24, -1
BNE	R24, R0, L_system_setup6
NOP	
NOP	
NOP	
;Voltmeter_click_PIC32.c,66 :: 		UART2_Write_Text( "SPI Initialized\r\n" );
LUI	R25, hi_addr(?lstr4_Voltmeter_click_PIC32+0)
ORI	R25, R25, lo_addr(?lstr4_Voltmeter_click_PIC32+0)
JAL	_UART2_Write_Text+0
NOP	
;Voltmeter_click_PIC32.c,68 :: 		Delay_ms(300);
LUI	R24, 12
ORI	R24, R24, 13567
L_system_setup8:
ADDIU	R24, R24, -1
BNE	R24, R0, L_system_setup8
NOP	
NOP	
;Voltmeter_click_PIC32.c,69 :: 		UART2_Write_Text( "SPI Initialized\r\n" );
LUI	R25, hi_addr(?lstr5_Voltmeter_click_PIC32+0)
ORI	R25, R25, lo_addr(?lstr5_Voltmeter_click_PIC32+0)
JAL	_UART2_Write_Text+0
NOP	
;Voltmeter_click_PIC32.c,71 :: 		calibration = getADC()/2;
JAL	_getADC+0
NOP	
ANDI	R2, R2, 65535
SRL	R2, R2, 1
SH	R2, Offset(_calibration+0)(GP)
;Voltmeter_click_PIC32.c,73 :: 		}
L_end_system_setup:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of _system_setup
_getADC:
;Voltmeter_click_PIC32.c,75 :: 		unsigned int getADC( void )
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;Voltmeter_click_PIC32.c,82 :: 		sum = 0;
SW	R25, 4(SP)
; sum start address is: 16 (R4)
MOVZ	R4, R0, R0
;Voltmeter_click_PIC32.c,84 :: 		for(i=0; i<10; i++ )
; i start address is: 12 (R3)
MOVZ	R3, R0, R0
; sum end address is: 16 (R4)
; i end address is: 12 (R3)
L_getADC10:
; i start address is: 12 (R3)
; sum start address is: 16 (R4)
ANDI	R2, R3, 255
SLTIU	R2, R2, 10
BNE	R2, R0, L__getADC17
NOP	
J	L_getADC11
NOP	
L__getADC17:
;Voltmeter_click_PIC32.c,86 :: 		Chip_Select = 0;               // Select MCP3201
LUI	R2, BitMask(RC2_bit+0)
ORI	R2, R2, BitMask(RC2_bit+0)
_SX	
;Voltmeter_click_PIC32.c,87 :: 		read = SPI3_Read(buffer);      // Get first 8 bits of ADC value
LBU	R25, 8(SP)
JAL	_SPI3_Read+0
NOP	
; read start address is: 24 (R6)
MOVZ	R6, R2, R0
;Voltmeter_click_PIC32.c,88 :: 		read1 = SPI3_Read(buffer);     // Get the rest of the ADC value bits
LBU	R25, 8(SP)
JAL	_SPI3_Read+0
NOP	
; read1 start address is: 20 (R5)
MOVZ	R5, R2, R0
;Voltmeter_click_PIC32.c,89 :: 		Chip_Select = 1;               // Deselect MCP3201
LUI	R2, BitMask(RC2_bit+0)
ORI	R2, R2, BitMask(RC2_bit+0)
_SX	
;Voltmeter_click_PIC32.c,90 :: 		read = ((read & 0x1F) << 8);   // Store the first 8 bits of the ADC value in temporary variable
ANDI	R2, R6, 31
; read end address is: 24 (R6)
ANDI	R2, R2, 65535
SLL	R2, R2, 8
; read start address is: 24 (R6)
ANDI	R6, R2, 65535
;Voltmeter_click_PIC32.c,91 :: 		read = ((read | read1) >> 1);  // Store the rest of the ADC value bits in temporary variable
OR	R2, R6, R5
; read1 end address is: 20 (R5)
; read end address is: 24 (R6)
ANDI	R2, R2, 65535
SRL	R2, R2, 1
; read start address is: 20 (R5)
ANDI	R5, R2, 65535
;Voltmeter_click_PIC32.c,92 :: 		sum = sum + read;              // Sum of the eight ADC readings
ADDU	R2, R4, R5
; read end address is: 20 (R5)
ANDI	R4, R2, 65535
;Voltmeter_click_PIC32.c,84 :: 		for(i=0; i<10; i++ )
ADDIU	R2, R3, 1
ANDI	R3, R2, 255
;Voltmeter_click_PIC32.c,93 :: 		}
; i end address is: 12 (R3)
J	L_getADC10
NOP	
L_getADC11:
;Voltmeter_click_PIC32.c,94 :: 		avrg = sum / 10;                  // Average ADC value based on sum of the ADC readings
ORI	R2, R0, 10
DIVU	R4, R2
MFLO	R2
; sum end address is: 16 (R4)
; avrg start address is: 12 (R3)
ANDI	R3, R2, 65535
;Voltmeter_click_PIC32.c,95 :: 		return avrg;                     // Returns the average ADC value
ANDI	R2, R3, 65535
; avrg end address is: 12 (R3)
;Voltmeter_click_PIC32.c,96 :: 		}
;Voltmeter_click_PIC32.c,95 :: 		return avrg;                     // Returns the average ADC value
;Voltmeter_click_PIC32.c,96 :: 		}
L_end_getADC:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _getADC
