[bits 64]
section .text
	global sqrt
	global sqrt32
	global ln
	global log2
	global log10
	global exp


sqrt:
	sqrtsd xmm0, xmm0
	ret
sqrt32:
	sqrtps xmm0, xmm0
	ret

ln:
	sub rsp, 16                             ; free up some space on the stack
	movsd [rsp], xmm0                       ; store x on the stack
	mov rax, 0x3fe62e42fefa3bdc             ; move log(2) / log(e) into rax to convert log(x) / log(2) to log(x) / log(e)
	mov [rsp + 8], rax                      ; move log(2) / log(e) onto the stack
	fld qword [rsp + 8]                     ; load double precision float for 1.0 from the stack to the FPU register
	fld qword [rsp]                         ; load double precision float for x from the stack to the FPU register
	fyl2x                                   ; call the log2 function from the x87 FPU
	fstp qword [rsp]                        ; load double precision float back to the stack from the FPU register
	movsd xmm0, [rsp]                       ; move sin(x) to xmm0
	add rsp, 16                             ; clean up the stack
	ret

log2:
	sub rsp, 16                             ; free up some space on the stack
	movsd [rsp], xmm0                       ; store x on the stack
	mov rax, 0x3ff0000000000000             ; move 1.0 into rax
	mov [rsp + 8], rax                      ; move 1.0 onto the stack
	fld qword [rsp + 8]                     ; load double precision float for 1.0 from the stack to the FPU register
	fld qword [rsp]                         ; load double precision float for x from the stack to the FPU register
	fyl2x                                   ; call the log2 function from the x87 FPU
	fstp qword [rsp]                        ; load double precision float back to the stack from the FPU register
	movsd xmm0, [rsp]                       ; move sin(x) to xmm0
	add rsp, 16                             ; clean up the stack
	ret

log10:
	sub rsp, 16                             ; free up some space on the stack
	movsd [rsp], xmm0                       ; store x on the stack
	mov rax, 0x3fd34413509f7b52             ; move log(2) / log(10) into rax to convert log(x) / log(2) to log(x) / log(10)
	mov [rsp + 8], rax                      ; move log(2) / log(10) onto the stack
	fld qword [rsp + 8]                     ; load double precision float for 1.0 from the stack to the FPU register
	fld qword [rsp]                         ; load double precision float for x from the stack to the FPU register
	fyl2x                                   ; call the log2 function from the x87 FPU
	fstp qword [rsp]                        ; load double precision float back to the stack from the FPU register
	movsd xmm0, [rsp]                       ; move sin(x) to xmm0
	add rsp, 16                             ; clean up the stack
	ret

exp:
	ret

pow:
	ret
