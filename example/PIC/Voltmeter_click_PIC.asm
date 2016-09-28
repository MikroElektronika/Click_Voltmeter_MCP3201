
_main:

;Voltmeter_click_PIC.c,19 :: 		void main()
;Voltmeter_click_PIC.c,21 :: 		system_setup();
	CALL        _system_setup+0, 0
;Voltmeter_click_PIC.c,23 :: 		UART1_Write_Text( "Entering While Loop...\r\n" );
	MOVLW       ?lstr1_Voltmeter_click_PIC+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_Voltmeter_click_PIC+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Voltmeter_click_PIC.c,25 :: 		while (1) {
L_main0:
;Voltmeter_click_PIC.c,27 :: 		voltage = 0;
	CLRF        _voltage+0 
	CLRF        _voltage+1 
	CLRF        _voltage+2 
	CLRF        _voltage+3 
;Voltmeter_click_PIC.c,29 :: 		measurement = getADC()/2;        // Get ADC result
	CALL        _getADC+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R3, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        R2, 0 
	MOVWF       FLOC__main+2 
	MOVF        R3, 0 
	MOVWF       FLOC__main+3 
	MOVF        FLOC__main+0, 0 
	MOVWF       _measurement+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       _measurement+1 
	MOVF        FLOC__main+2, 0 
	MOVWF       _measurement+2 
	MOVF        FLOC__main+3, 0 
	MOVWF       _measurement+3 
;Voltmeter_click_PIC.c,30 :: 		voltage = (measurement - calibration)*33.3405;
	MOVF        _calibration+0, 0 
	MOVWF       R0 
	MOVF        _calibration+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	MOVF        FLOC__main+2, 0 
	MOVWF       R2 
	MOVF        FLOC__main+3, 0 
	MOVWF       R3 
	CALL        _Sub_32x32_FP+0, 0
	MOVLW       172
	MOVWF       R4 
	MOVLW       92
	MOVWF       R5 
	MOVLW       5
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _voltage+0 
	MOVF        R1, 0 
	MOVWF       _voltage+1 
	MOVF        R2, 0 
	MOVWF       _voltage+2 
	MOVF        R3, 0 
	MOVWF       _voltage+3 
;Voltmeter_click_PIC.c,32 :: 		FloatToStr(voltage, txt);
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _txt+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Voltmeter_click_PIC.c,34 :: 		UART1_Write_Text(txt);
	MOVLW       _txt+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Voltmeter_click_PIC.c,35 :: 		UART1_Write(32);
	MOVLW       32
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Voltmeter_click_PIC.c,36 :: 		UART1_Write_Text("mV");
	MOVLW       ?lstr2_Voltmeter_click_PIC+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_Voltmeter_click_PIC+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Voltmeter_click_PIC.c,37 :: 		UART1_Write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Voltmeter_click_PIC.c,38 :: 		UART1_Write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Voltmeter_click_PIC.c,40 :: 		delay_ms(1000);                //Za test moze sa delay da se resi sample rate, za ozbiljnije interrupt + TMR
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;Voltmeter_click_PIC.c,41 :: 		}
	GOTO        L_main0
;Voltmeter_click_PIC.c,42 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_system_setup:

;Voltmeter_click_PIC.c,44 :: 		void system_setup( void )
;Voltmeter_click_PIC.c,46 :: 		TRISC = 0x00;                   // Set PORTC as output
	CLRF        TRISC+0 
;Voltmeter_click_PIC.c,47 :: 		TRISD = 0x00;                   // Set PORTD as output
	CLRF        TRISD+0 
;Voltmeter_click_PIC.c,49 :: 		Chip_Select_Direction = 0;       // Set chip select pin to be output
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;Voltmeter_click_PIC.c,50 :: 		Chip_Select = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;Voltmeter_click_PIC.c,52 :: 		UART1_Init(57600);               // Initialize UART module at 9600 bps
	MOVLW       16
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Voltmeter_click_PIC.c,53 :: 		Delay_ms(300);                  // Wait for UART module to stabilize
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_system_setup3:
	DECFSZ      R13, 1, 1
	BRA         L_system_setup3
	DECFSZ      R12, 1, 1
	BRA         L_system_setup3
	DECFSZ      R11, 1, 1
	BRA         L_system_setup3
	NOP
;Voltmeter_click_PIC.c,54 :: 		UART1_Write_Text( "UART Initialized\r\n" );
	MOVLW       ?lstr3_Voltmeter_click_PIC+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_Voltmeter_click_PIC+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Voltmeter_click_PIC.c,56 :: 		voltage = 0;
	CLRF        _voltage+0 
	CLRF        _voltage+1 
	CLRF        _voltage+2 
	CLRF        _voltage+3 
;Voltmeter_click_PIC.c,57 :: 		sum = 0;
	CLRF        _sum+0 
	CLRF        _sum+1 
;Voltmeter_click_PIC.c,58 :: 		measurement = 0;
	CLRF        _measurement+0 
	CLRF        _measurement+1 
	CLRF        _measurement+2 
	CLRF        _measurement+3 
;Voltmeter_click_PIC.c,59 :: 		calibration = 0;
	CLRF        _calibration+0 
	CLRF        _calibration+1 
;Voltmeter_click_PIC.c,61 :: 		Chip_Select = 1;                 // Deselect MCP3204
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;Voltmeter_click_PIC.c,64 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;Voltmeter_click_PIC.c,66 :: 		Delay_ms(300);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_system_setup4:
	DECFSZ      R13, 1, 1
	BRA         L_system_setup4
	DECFSZ      R12, 1, 1
	BRA         L_system_setup4
	DECFSZ      R11, 1, 1
	BRA         L_system_setup4
	NOP
;Voltmeter_click_PIC.c,67 :: 		UART1_Write_Text( "SPI Initialized\r\n" );
	MOVLW       ?lstr4_Voltmeter_click_PIC+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr4_Voltmeter_click_PIC+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Voltmeter_click_PIC.c,69 :: 		calibration = getADC()/2;
	CALL        _getADC+0, 0
	MOVF        R0, 0 
	MOVWF       _calibration+0 
	MOVF        R1, 0 
	MOVWF       _calibration+1 
	RRCF        _calibration+1, 1 
	RRCF        _calibration+0, 1 
	BCF         _calibration+1, 7 
;Voltmeter_click_PIC.c,71 :: 		}
L_end_system_setup:
	RETURN      0
; end of _system_setup

_getADC:

;Voltmeter_click_PIC.c,73 :: 		unsigned int getADC( void )
;Voltmeter_click_PIC.c,80 :: 		sum = 0;
	CLRF        getADC_sum_L0+0 
	CLRF        getADC_sum_L0+1 
;Voltmeter_click_PIC.c,82 :: 		for(i=0; i<10; i++ )
	CLRF        getADC_i_L0+0 
L_getADC5:
	MOVLW       10
	SUBWF       getADC_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_getADC6
;Voltmeter_click_PIC.c,84 :: 		Chip_Select = 0;               // Select MCP3201
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;Voltmeter_click_PIC.c,85 :: 		read = SPI1_Read(buffer);      // Get first 8 bits of ADC value
	MOVF        getADC_buffer_L0+0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       getADC_read_L0+0 
	MOVLW       0
	MOVWF       getADC_read_L0+1 
;Voltmeter_click_PIC.c,86 :: 		read1 = SPI1_Read(buffer);     // Get the rest of the ADC value bits
	MOVF        getADC_buffer_L0+0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       getADC_read1_L0+0 
	MOVLW       0
	MOVWF       getADC_read1_L0+1 
;Voltmeter_click_PIC.c,87 :: 		Chip_Select = 1;               // Deselect MCP3201
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;Voltmeter_click_PIC.c,88 :: 		read = ((read & 0x1F) << 8);   // Store the first 8 bits of the ADC value in temporary variable
	MOVLW       31
	ANDWF       getADC_read_L0+0, 0 
	MOVWF       R3 
	MOVF        getADC_read_L0+1, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R4, 1 
	MOVF        R3, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	MOVWF       getADC_read_L0+0 
	MOVF        R1, 0 
	MOVWF       getADC_read_L0+1 
;Voltmeter_click_PIC.c,89 :: 		read = ((read | read1) >> 1);  // Store the rest of the ADC value bits in temporary variable
	MOVF        getADC_read1_L0+0, 0 
	IORWF       getADC_read_L0+0, 0 
	MOVWF       R3 
	MOVF        getADC_read_L0+1, 0 
	IORWF       getADC_read1_L0+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	MOVWF       getADC_read_L0+0 
	MOVF        R1, 0 
	MOVWF       getADC_read_L0+1 
;Voltmeter_click_PIC.c,90 :: 		sum = sum + read;              // Sum of the eight ADC readings
	MOVF        getADC_read_L0+0, 0 
	ADDWF       getADC_sum_L0+0, 1 
	MOVF        getADC_read_L0+1, 0 
	ADDWFC      getADC_sum_L0+1, 1 
;Voltmeter_click_PIC.c,82 :: 		for(i=0; i<10; i++ )
	INCF        getADC_i_L0+0, 1 
;Voltmeter_click_PIC.c,91 :: 		}
	GOTO        L_getADC5
L_getADC6:
;Voltmeter_click_PIC.c,92 :: 		avrg = sum / 10;                  // Average ADC value based on sum of the ADC readings
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        getADC_sum_L0+0, 0 
	MOVWF       R0 
	MOVF        getADC_sum_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       getADC_avrg_L0+0 
	MOVF        R1, 0 
	MOVWF       getADC_avrg_L0+1 
;Voltmeter_click_PIC.c,93 :: 		return avrg;                     // Returns the average ADC value
	MOVF        getADC_avrg_L0+0, 0 
	MOVWF       R0 
	MOVF        getADC_avrg_L0+1, 0 
	MOVWF       R1 
;Voltmeter_click_PIC.c,94 :: 		}
L_end_getADC:
	RETURN      0
; end of _getADC
