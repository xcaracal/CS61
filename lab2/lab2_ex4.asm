;=================================================
; Name: Steven Hoang
; Email:  Shoan031@ucr.edu
; 
; Lab: lab 2, ex 4
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000
	;-------------------------
	;Instructions
	;-------------------------
	LD R0, HEX_61
	LD R1, HEX_1A
	
	DO_WHILE_LOOP
		;Print R0
		TRAP x21
		;ADD 1 to R0
		ADD R0,R0,#1
		;ADD -1 to R1
		ADD R1,R1,#-1
		;CHECK TILL REACHES ZERO... IT RAN x1A(26) TIMES
		BRp DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
	HALT
	;-------------------------
	;Data
	;-------------------------
	HEX_61 .FILL x61
	HEX_1A .FILL x1A
	
.end
