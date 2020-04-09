;=================================================
; Name: Steven Hoang
; Email: Shoan031@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000                     ;Starts Program
	;-----------------------
	;Instructions
	;-----------------------
	LD R3, DEC_65
	LD R4, HEX_41
	
	HALT
	;-----------------------
	;Data
	;-----------------------
	;Put the data in memory aliases using fill.
	DEC_65	.FILL #65
	HEX_41  .FILL x41
	
.end
