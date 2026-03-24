module FSM (
	input clk,
	input rst,
	input en,
	output reg output_en,
	output reg [1:0] z
);

parameter IDLE = 3'd0;
parameter	 A = 3'd1;
parameter    B = 3'd2;
parameter	 C = 3'd3;
parameter    D = 3'd4;
parameter  END = 3'd5;

reg [2:0] curr_state;
reg [2:0] next_state;
reg [3:0] cnt_c;
reg [3:0] cnt_r;

always @ (posedge clk) begin
	if(rst)
		cnt_c <= 0;
	else if (output_en) begin 
		if (cnt_c == 9)
			cnt_c <= 0;
		else
			cnt_c <= cnt_c + 1;
	end
end

always @ (posedge clk) begin
	if(rst)
		cnt_r <= 0;
	else if (output_en && cnt_c == 9) begin
			if(cnt_r == 9)
				cnt_r <= 0;
			else
				cnt_r <= cnt_r + 1;
	end
end

always @ (posedge clk) begin
	if(rst)
		curr_state <= IDLE;
	else
		curr_state <= next_state;
end

always @ (*) begin
	case(curr_state)
		IDLE	: if(!en) next_state = IDLE;
			      else 	  next_state = A;
		A   	: next_state = B;
		B   	: if(cnt_c == 9) next_state = C;
				  else next_state = B;
		C   	: next_state = D;
		D   	: if(cnt_r == 9 && cnt_c ==9) next_state = END;
				  else if (cnt_c == 9) next_state = C;
				  else next_state = D;
		END 	: next_state = END;
		default : next_state = IDLE;
	endcase
end

always @ (curr_state) begin
	case(curr_state)
		A 		: z = 2'b00;
		B 		: z = 2'b01;
		C 		: z = 2'b10;
		D    	: z = 2'b11;
		default	: z = 2'b00;
	endcase
end

always @ (curr_state) begin
	if(curr_state == IDLE || curr_state == END)
		output_en = 1'b0;
	else
		output_en = 1'b1;
end

endmodule