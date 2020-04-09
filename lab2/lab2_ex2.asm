;=================================================
; Name: Steven Hoang
; Email:  Shoan031@ucr.edu
; 
; Lab: lab 2, ex 2
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000
	;----------------------------
	;Instructions
	;----------------------------
	;USE LDI SINCE MEM LOC IS TOO FAR AWAY
	LDI R3, DEC_65_PTR
	LDI R4, HEX_41_PTR
	
	;ADD ONE TO THE THING IN MEMORY
	ADD R3,R3,#1
	ADD R4,R4,#1
	
	;STORE NEW DATA IN R3/R4
	STI R3, DEC_65_PTR
	STI R4, HEX_41_PTR
	
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
