
// Voltmeter click module connections
sbit Chip_Select_Direction   at TRISC2_bit;
sbit Chip_Select             at RC2_bit;
// eof Voltmeter click module connections

unsigned int calibration, sum, average;
float voltage, measurement;
char txt[15];
char lower_deo, upper_deo;
unsigned int adc_rd;
float voltage_v;

void system_setup( void );
unsigned int getADC( void );

void main()
{
  system_setup();

  UART1_Write_Text( "Entering While Loop...\r\n" );

  while (1) {

    voltage = 0;

    measurement = getADC() / 2;      // Get ADC result
    voltage = (measurement - calibration) * 33.3405;

    FloatToStr(voltage, txt);

    UART1_Write_Text(txt);
    UART1_Write(32);
    UART1_Write_Text("mV");
    UART1_Write(13);
    UART1_Write(10);

    delay_ms(1000);
  }
}

void system_setup( void )
{
  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(300);                  // Wait for UART module to stabilize
  UART1_Write_Text( "UART Initialized\r\n" );

  voltage = 0;
  sum = 0;
  measurement = 0;
  calibration = 0;

  // Setting output frequency to 140MHz
  PLLFBD = 70;             // PLL multiplier M=70
  CLKDIV = 0x0000;         // PLL prescaler N1=2, PLL postscaler N2=2

  ANSELA = 0x00;           // Convert all I/O pins to digital
  ANSELB = 0x00;
  ANSELC = 0x00;
  ANSELD = 0x00;
  ANSELE = 0x00;

  PPS_Mapping(100, _INPUT,  _U1RX);              // Sets pin RP100 to be Input, and maps U1RX to it
  PPS_Mapping(101, _OUTPUT, _U1TX);              // Sets pin RP101 to be Output, and maps U1TX to it
  Delay_ms(300);

  //GPIOs
  Chip_Select_Direction  = 0;
  Chip_Select = 1;

  //SPI
  PPS_Mapping(104, _OUTPUT,  _SDO3);             // Sets pin RP104 to be Output, and maps SD03 to it
  PPS_Mapping(98, _INPUT, _SDI3);                // Sets pin RP98 to be Input, and maps SD01 to it
  PPS_Mapping(79, _OUTPUT, _SCK3OUT);            // Sets pin RP79 to be Output, and maps SCK3 to it
  Delay_ms(300);

  SPI3_Init_Advanced(_SPI_MASTER,
                     _SPI_8_BIT,
                     _SPI_PRESCALE_SEC_8,
                     _SPI_PRESCALE_PRI_16,
                     _SPI_SS_DISABLE,
                     _SPI_DATA_SAMPLE_END,
                     _SPI_CLK_IDLE_LOW,
                     _SPI_IDLE_2_ACTIVE);
  Delay_ms( 300 );

  //UART
  UART1_Init( 9600 );
  Delay_ms(300);

  UART1_Write_Text( "SPI Initialized\r\n" );
  UART1_Write_Text( "UART Initialized\r\n" );

  calibration = getADC() / 2;

}

unsigned int getADC( void )
{
  // Local variables
  char i = 0, buffer = 0;
  volatile float avrg = 0, sum = 0;
  volatile unsigned int read = 0, read1 = 0;

  // Initialize variable
  sum = 0.0;
  read = 0.0;
  read1 = 0.0;
  avrg = 0.0;
  buffer = 0;

  for (i = 0; i < 10; i++ )
  {
    Chip_Select = 0;               // Select MCP3201
    read = SPI3_Read(buffer);      // Get first 8 bits of ADC value
    read1 = SPI3_Read(buffer);     // Get the rest of the ADC value bits
    Chip_Select = 1;               // Deselect MCP3201
    read = ((read & 0x1F) << 8);   // Store the first 8 bits of the ADC value in temporary variable
    read = ((read | read1) >> 1);  // Store the rest of the ADC value bits in temporary variable
    sum = sum + read;              // Sum of the eight ADC readings
  }
  avrg = sum / 10.0;               // Average ADC value based on sum of the ADC readings

  return avrg;                     // Returns the average ADC value
}
