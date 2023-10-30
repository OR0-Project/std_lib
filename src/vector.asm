bits 64
section .text
	global test


test:
%ifdef __SSE__
	jmp $
	ret
%else
	ret
%endif