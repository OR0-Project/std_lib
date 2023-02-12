[bits 64]
section .data
section .bss
section .text
	global sin
	global sin32
	global cos
	global cos32


sin:                        ; double precision sin(x)
	sub rsp, 8                  ; free up some space on the stack
    movsd [rsp], xmm0           ; store x on the stack
	fld qword [rsp]             ; load double precision float from the stack to the FPU register
	fsin                        ; call the sin function from the x87 FPU
	fstp qword [rsp]            ; load double precision float back to the stack from the FPU register
	movsd xmm0, [rsp]           ; move sin(x) to xmm0
	add rsp, 8                  ; clean up the stack
	ret
sin32:                      ; single precision sin(x)
	sub rsp, 4                  ; free up some space on the stack
    movss [rsp], xmm0           ; store x on the stack
	fld dword [rsp]             ; load single precision float from the stack to the FPU register
	fsin                        ; call the sin function from the x87 FPU
	fstp dword [rsp]            ; load single precision float back to the stack from the FPU register
	movss xmm0, [rsp]           ; move sin(x) to xmm0
	add rsp, 4                  ; clean up the stack
	ret

cos:                        ; double precision cos(x)
	sub rsp, 8                  ; free up some space on the stack
    movsd [rsp], xmm0           ; store x on the stack
	fld qword [rsp]             ; load double precision float from the stack to the FPU register
	fcos                        ; call the cos function from the x87 FPU
	fstp qword [rsp]            ; load double precision float back to the stack from the FPU register
	movsd xmm0, [rsp]           ; move cos(x) to xmm0
	add rsp, 8                  ; clean up the stack
	ret
cos32:                      ; single precision cos(x)
	sub rsp, 4                  ; free up some space on the stack
    movss [rsp], xmm0           ; store x on the stack
	fld dword [rsp]             ; load single precision float from the stack to the FPU register
	fcos                        ; call the cos function from the x87 FPU
	fstp dword [rsp]            ; load single precision float back to the stack from the FPU register
	movss xmm0, [rsp]           ; move cos(x) to xmm0
	add rsp, 4                  ; clean up the stack
	ret