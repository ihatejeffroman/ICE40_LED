// MODIFIED BLINKY
// 6/24/19
// JEFF ROMAN
//
//////////////////////////////////////////////////////////////////////////////////



module LED_Verilog(
input clk,
output LED0,
output LED1,
output LED2,
output LED3,
output LED4,
output LED5,
output LED6,
output LED7
);


	reg [31:0]counter = 32'b0;
	reg PULSE = 1'b0;
	reg [7:0]LEDstate = 8'b00000001;
	reg fb = 1'b0;

// While on, the LED bank is a one-hot sequence going 2 bits forward, 1 bit back
// then in reverse once it reaches the most or least significant bits.


always @(posedge clk)
	begin
			if (counter > 1000000)
			begin
					counter <= 32'b0;
					PULSE <= !PULSE;

					if (PULSE == 1'b0)
					begin
							if (fb == 1'b0) begin
								if (LEDstate == 8'b00100000)
									fb <= !fb;
								LEDstate <= {LEDstate[5:0], LEDstate[7:6]};

							end
							else begin

								LEDstate <= {LEDstate[6:0], LEDstate[7]};

							end
					end

					else
					begin
						if (fb == 1'b0) begin
							LEDstate <= {LEDstate[0], LEDstate[7:1]};
						end
						else begin
							if (LEDstate == 8'b00000100)
								fb <= !fb;
							LEDstate <= {LEDstate[1:0], LEDstate[7:2]};

						end
					end

				end

			else
				counter <= counter + 1;
	end

	assign LED0 = LEDstate[0] ? 1'b1 : 1'b0; // each LED wire queries a bit of
	assign LED1 = LEDstate[1] ? 1'b1 : 1'b0; //LEDstate and chooses 1 if its bit
	assign LED2 = LEDstate[2] ? 1'b1 : 1'b0;// is high, 0 if its bit is low
	assign LED3 = LEDstate[3] ? 1'b1 : 1'b0;
	assign LED4 = LEDstate[4] ? 1'b1 : 1'b0;
	assign LED5 = LEDstate[5] ? 1'b1 : 1'b0;
	assign LED6 = LEDstate[6] ? 1'b1 : 1'b0;
	assign LED7 = LEDstate[7] ? 1'b1 : 1'b0;


endmodule
