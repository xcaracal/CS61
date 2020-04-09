;=================================================
; Name: Steven Hoang
; Email:  Shoan031@ucr.edu
; 
; Lab: lab 2, ex 3
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000
	;----------------------------
	;Instructions
	;----------------------------
	;Loads the adress of the pointer into variables
	LD R5, DEC_65_PTR
	LD R6, HEX_41_PTR
	
	LDR R3,R5,#0
	LDR R4,R6,#0
	
	;ADD ONE TO THE THING IN MEMORY
	ADD R3,R3,#1
	ADD R4,R4,#1
	
	STR R3,R5,#0
	STR R4,R6,#0
	
	Halt
	;----------------------------
	;Data
	;----------------------------
	DEC_65_PTR .FILL x4000
	HEX_41_PTR .FILL x4001
		;; Remote Data
		.orig x4000
	DEC_65 .FILL #65
	HEX_41 .FILL x41
	
.end
