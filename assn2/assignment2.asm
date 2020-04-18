;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Steven Hoang
; Email: shoan031@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: 24
; TA: David Feng
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------

;FIRST/SECOND CHARACTER PRINT/LOAD
GETC			;INPUT -> R0
OUT
ADD R1,R0,#0
;PUT NEWLINE IN R0 AND PRINT
LD R0, newline
OUT
GETC
OUT
ADD R2,R0,#0
;PUT NEWLINE IN R0 AND PRINT
LD R0, newline
OUT

;PRINT THE EXPRESSION
ADD R0,R1,#0
OUT
LEA R0,subtract
PUTS
ADD R0,R2,#0
OUT
LEA R0,equal
PUTS

;2COMP OF SECOND # SINCE WE ARE SUBTRACTING
ADD R3,R2,#0
NOT R3,R3
ADD R3,R3,#1

;'SUBTRACT IT' AND STORE IN R4
ADD R4,R1,R3

BRn NEG ;IF  NEGATIVE GO TO NEG LOOP
;------------------------------------------||||
;IF NOT NEG THEN IT WILL CONTINUE TO TRANSFER BACK INTO DECIMAL

;NOTE: Theoretically u want to move forward back to number on ascii which is abt #48num ahead but you cant do that all at once since its a 5 bit field :(
ADD R4,R4,#15
ADD R4,R4,#15
ADD R4,R4,#15
ADD R4,R4,#3

;PRINT
ADD R0,R4,#0
OUT
LD R0, newline
OUT

HALT

;------------------------------------------||||
NEG
;IF NEGATIVE THEN U TAKE 2COMPLEMENT BACK TO POSITIVE AND DO SAME THINGS AS LOOP ON TOP BUT PUT A NEG IN FRONT OF NUM
NOT R4,R4
ADD R4,R4,#1

;NOTE: Theoretically u want to move forward back to number on ascii which is abt #48num ahead but you cant do that all at once since its a 5 bit field :(
ADD R4,R4,#15
ADD R4,R4,#15
ADD R4,R4,#15
ADD R4,R4,#3

;PUT NEG IN FRONT
LD R0,negative
OUT
ADD R0,R4,#0
OUT
LD R0,newline
OUT

HALT				; Stop execution of program
;------------------------------------------ ||||

;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	 .STRINGZ	 "ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline  .FILL  '\n'	; newline character - use with LD followed by OUT
negative .FILL #45
subtract .STRINGZ " - "
equal	 .STRINGZ " = "



;---------------	
;END of PROGRAM
;---------------	
.END

