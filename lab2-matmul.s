;
; CS1022 Introduction to Computing II 2018/2019
; Lab 2 - Matrix Multiplication
;

N	EQU	4		

	AREA	globals, DATA, READWRITE

; result array
ARR_R	SPACE	N*N*4		; N*N words (4 bytes each)


	AREA	RESET, CODE, READONLY
	ENTRY

	; initialize system stack pointer (SP)
	LDR	SP, =0x40010000
	LDR R8, =ARR_R
	LDR R9, =N
	LDR R10, =ARR_A
	LDR R11, =ARR_B

	LDR R0, =0		; for( i = 0
ifor
	CMP R0, #N		;
	BGE endfor		; i < N
	LDR R1, =0		; for(j = 0
jfor
	CMP R1, #N
	BGE endjFor		; j < N
	LDR R2, =0		; for(k = 0
	LDR R3, =0		; r = 0
kfor
	CMP R2, #N		
	BGE endkFor		; k < N
	; <byte offset> = ((row * <row_size>) + col) * <elem size>
	MUL R4, R0, R9	; index = row(i) * rowSize
	ADD R4, R4, R2	; + col(k)
	LDR R5, [R10,R4, LSL #2] ; ArrayAElem = Memory.Word[ArrayA + index*4]
	MUL R4, R2, R9	; index = row(k) * rowSize
	ADD R4, R4, R1	; + col(j)
	LDR R6, [R11, R4, LSL #2] ;ArrayBElem = Memory.Word[ArrayB + index*4]
	MUL R7, R5, R6	; mulItems = A[i, k] * B[k, j]
	ADD R3, R3, R7	; R += mulItems
	ADD R2, R2, #1	; k++
	B kfor
endkFor
	MUL R4, R0, R9 ; index  = row(i) * rowSize
	ADD R4, R4, R1 ; + col(j)
	STR R3, [R8, R4, LSL #2] ; R[i, j] = r
	ADD R1, R1, #1	;j++
	B jfor
endjFor
	ADD R0, R0, #1 ;i++
	B ifor
endfor

	;
	; write your matrix multiplication program here
	;


STOP	B	STOP


;
; test data
;

ARR_A	DCD	 1,  2,  3,  4
	DCD	 5,  6,  7,  8
	DCD	 9, 10, 11, 12
	DCD	13, 14, 15, 16

ARR_B	DCD	 1,  2,  3,  4
	DCD	 5,  6,  7,  8
	DCD	 9, 10, 11, 12
	DCD	13, 14, 15, 16

	END
