;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Steven Hoang
; Email: shoan031@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 24
; TA: David Feng
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R1
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------
RESTART
; output intro prompt
LD R0,introPromptPtr
PUTS		
; Set up flags, counters, accumulators as needed
AND R1,R1,#0
AND R5,R5,#0
LD R4,COUNTER_MAX ;COUNTER
; Get first character, test for '\n', '+', '-', digit/non-digit: 	

	GETC
	LD R2,NEWLINE_CHECK
	ADD R3,R0,R2
	BRz DONE_NEWLINE

	LD R2,POSITIVE_CHECK
	ADD R3,R0,R2
	BRz POS_FLAG

	LD R2,NEGATIVE_CHECK
	ADD R3,R0,R2
	BRz NEG_FLAG
	
	LD R2,MIN
	ADD R3,R0,R2
	BRn ERROR
			
	LD R2,MAX
	ADD R3,R0,R2
	BRp ERROR
	
	BRnzp NUM_START

	NEG_FLAG
		OUT
		ADD R5,R5,#-1
		ADD R3,R0,R2
		BRz NUM_LOOP
		
	POS_FLAG
		OUT
		ADD R5,R5,#1

	NUM_LOOP
		GETC
		
		NUM_START
		
		LD R2,NEWLINE_CHECK
		ADD R3,R0,R2
		BRz NEWLINE_FINISH_CHECK
		
		LD R2,MIN
		ADD R3,R0,R2
		BRn ERROR
			
		LD R2,MAX
		ADD R3,R0,R2
		BRp ERROR
	
		
		OUT
		
		ADD R4,R4,#0
		BRz FINISH_CHECK
		
		LD R2,FIRST_NUM
		ADD R3,R4,R2
		BRz ADD_FIRST_NUM
		BRnp CONT
		
		ADD_FIRST_NUM
			LD R2,MIN
			ADD R0,R0,R2
			ADD R1,R1,R0
			ADD R4,R4,#-1
			BRzp NUM_LOOP
		
		CONT
			LD R2,MIN
			ADD R3,R0,R2
			BRn ERROR
			
			LD R2,MAX
			ADD R3,R0,R2
			BRp ERROR
			BRnz NO_ERROR
			
			ERROR
				ADD R0,R0,#0
				OUT
				
				LEA R0,NEWLINE
				PUTS
				
				LD R0,errorMessagePtr
				PUTS
				
				BRnzp RESTART
			
			NO_ERROR
			
			LD R2,MIN
			ADD R0,R0,R2
			ADD R1,R1,R1
			ADD R6,R1,R1
			ADD R6,R6,R6
			ADD R1,R1,R6
			ADD R1,R0,R1
			
			ADD R4,R4,#-1
			BRp NUM_LOOP
			BRnzp FINISH_CHECK

	NEWLINE_FINISH_CHECK
	LD R2,FIRST_NUM
	ADD R3,R4,R2
	BRz ERROR
	
	FINISH_CHECK
		ADD R5,R5,#0
		BRzp DONE_NEWLINE
		BRn MAKE_NEG

	MAKE_NEG
		NOT R1,R1
		ADD R1,R1,#1

						
	DONE_NEWLINE		
		LEA R0,NEWLINE
		PUTS

	FIRST_NEWLINE
						HALT

;---------------	
; Program Data
;---------------
NEWLINE				.STRINGZ "\n"
NEWLINE_CHECK		.FILL #-10
POSITIVE_CHECK		.FILL #-43
NEGATIVE_CHECK		.FILL #-45
MIN					.FILL #-48
MAX					.FILL #-57
COUNTER_MAX			.FILL x5
FIRST_NUM			.FILL #-5
ARR_PTR				.FILL ARR
introPromptPtr		.FILL xA800
errorMessagePtr		.FILL xA900


;------------
; Remote data
;------------
					.ORIG xA800			; intro prompt
					.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
					.ORIG xA900			; error message
					.STRINGZ	"ERROR! invalid input\n"

					.ORIG x4000
ARR					.BLKW		#6					
;---------------
; END of PROGRAM
;---------------
					.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.


