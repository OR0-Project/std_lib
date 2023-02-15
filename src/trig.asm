[bits 64]
section .text
	extern pow
	extern pow32

	global sin
	global sin32
	global cos
	global cos32
	global tan
	global tan32
	global csc
	global csc32
	global sec
	global sec32
	global cot
	global cot32
	global atan
	global atan32


sin:                                    ; double precision sin(x)
	sub rsp, 8                              ; free up some space on the stack
	movsd [rsp], xmm0                       ; store x on the stack
	fld qword [rsp]                         ; load double precision float from the stack to the FPU register
	fsin                                    ; call the sin function from the x87 FPU
	fstp qword [rsp]                        ; load double precision float back to the stack from the FPU register
	movsd xmm0, [rsp]                       ; move sin(x) to xmm0
	add rsp, 8                              ; clean up the stack
	ret
sin32:                                  ; single precision sin(x)
	sub rsp, 4                              ; free up some space on the stack
	movss [rsp], xmm0                       ; store x on the stack
	fld dword [rsp]                         ; load single precision float from the stack to the FPU register
	fsin                                    ; call the sin function from the x87 FPU
	fstp dword [rsp]                        ; load single precision float back to the stack from the FPU register
	movss xmm0, [rsp]                       ; move sin(x) to xmm0
	add rsp, 4                              ; clean up the stack
	ret

cos:                                    ; double precision cos(x)
	sub rsp, 8                              ; free up some space on the stack
	movsd [rsp], xmm0                       ; store x on the stack
	fld qword [rsp]                         ; load double precision float from the stack to the FPU register
	fcos                                    ; call the cos function from the x87 FPU
	fstp qword [rsp]                        ; load double precision float back to the stack from the FPU register
	movsd xmm0, [rsp]                       ; move cos(x) to xmm0
	add rsp, 8                              ; clean up the stack
	ret
cos32:                                  ; single precision cos(x)
	sub rsp, 4                              ; free up some space on the stack
	movss [rsp], xmm0                       ; store x on the stack
	fld dword [rsp]                         ; load single precision float from the stack to the FPU register
	fcos                                    ; call the cos function from the x87 FPU
	fstp dword [rsp]                        ; load single precision float back to the stack from the FPU register
	movss xmm0, [rsp]                       ; move cos(x) to xmm0
	add rsp, 4                              ; clean up the stack
	ret

tan:                                    ; double precision tan(x)
	movsd xmm2, xmm0                        ; save x to xmm2
	call cos                                ; calculate cos(x)
	movsd xmm1, xmm0                        ; mov cos(x) to xmm1
	movsd xmm0, xmm2                        ; restore x
	call sin                                ; calculate sin(x)
	divsd xmm0, xmm1                        ; calculating sin(x) / cos(x) => tan(x)
	ret
tan32:                                  ; single precision tan(x)
	movss xmm2, xmm0                        ; save x to xmm2
	call cos32                              ; calculate cos(x)
	movss xmm1, xmm0                        ; mov cos(x) to xmm1
	movss xmm0, xmm2                        ; restore x
	call sin32                              ; calculate sin(x)
	divss xmm0, xmm1                        ; calculating sin(x) / cos(x) => tan(x)
	ret

csc:                                    ; double precision csc(x)
	call sin                                ; calculate cos(x)
	movsd xmm1, xmm0                        ; mov cos(x) to xmm1
	mov rax, 0x3ff0000000000000             ; moving 1.0 into rax because xmm registers cant be set using a literal
	movq xmm0, rax                          ; set xmm0 to 1.0
	divsd xmm0, xmm1                        ; calculating 1 / sin(x) => csc(x)
	ret
csc32:                                  ; single precision csc(x)
	call sin32                              ; calculate cos(x)
	movss xmm1, xmm0                        ; mov cos(x) to xmm1
	mov eax, 0x3f800000                     ; moving 1.0 into eax because xmm registers cant be set using a literal
	movd xmm0, eax                          ; set xmm0 to 1.0
	divss xmm0, xmm1                        ; calculating 1 / sin(x) => csc(x)
	ret

sec:                                    ; double precision csc(x)
	call cos                                ; calculate cos(x)
	movsd xmm1, xmm0                        ; mov cos(x) to xmm1
	mov rax, 0x3ff0000000000000             ; moving 1.0 into rax because xmm registers cant be set using a literal
	movq xmm0, rax                          ; set xmm0 to 1.0
	divsd xmm0, xmm1                        ; calculating 1 / sin(x) => csc(x)
	ret
sec32:                                  ; single precision csc(x)
	call cos32                              ; calculate cos(x)
	movss xmm1, xmm0                        ; mov cos(x) to xmm1
	mov eax, 0x3f800000                     ; moving 1.0 into eax because xmm registers cant be set using a literal
	movd xmm0, eax                          ; set xmm0 to 1.0
	divss xmm0, xmm1                        ; calculating 1 / sin(x) => csc(x)
	ret

cot:                                    ; double precision tan(x)
	movsd xmm2, xmm0                        ; save x to xmm2
	call sin                                ; calculate sin(x)
	movsd xmm1, xmm0                        ; mov cos(x) to xmm1
	movsd xmm0, xmm2                        ; restore x
	call cos                                ; calculate cos(x)
	divsd xmm0, xmm1                        ; calculating sin(x) / cos(x) => tan(x)
	ret
cot32:                                  ; single precision tan(x)
	movss xmm2, xmm0                        ; save x to xmm2
	call sin32                              ; calculate cos(x)
	movss xmm1, xmm0                        ; mov cos(x) to xmm1
	movss xmm0, xmm2                        ; restore x
	call cos32                              ; calculate sin(x)
	divss xmm0, xmm1                        ; calculating sin(x) / cos(x) => tan(x)
	ret

atan:
; (-1)^n * (x^2n + 1) / 2n + 1

atan32:




;   ; return NaN if |x| > 1
;   mov rax, 0x7fffffffffffffff             ; moving the abs mask into rax
;   movq xmm2, rax                          ; move abs mask to xmm2
;   andps xmm1, xmm2                        ; calculate abs value of x
;   mov rax, 0x3ff0000000000000             ; mov 1.0 into rax
;   movq xmm2, rax                          ; mov 1.0 into xmm2
;   comisd xmm2, xmm1                       ; compare |x| and 1.0
;   jb .return_nan                          ; return NaN when x is larger than 1
;   mov rax, 0x8000000000000000             ; move the sign mask into rax
;   movq xmm2, rax                          ; move the sign mask into xmm1
;   andps xmm2, xmm0                        ; extracting the sign bit from the input
;   je .return_pi_2                         ; return pi/2 or -pi/2 when x is equal to 1

;.return_nan:
;	mov rax, 0x7ff8000000000000
;	movq xmm0, rax
;	ret
;.return_pi_2:
;	mov rax, 0x3ff921fb54442d15             ; moving pi/2 into rax because xmm registers cant be set using a literal
;	movq xmm0, rax                          ; moving pi/2 into xmm0
;	orps xmm0, xmm2                         ; reapplying the sign bit
;	ret