[bits 64]
section .text
	global strlen
	global strcpy
	global strcat
	global strtok


strlen:		; TODO: inc before test/cmp to prevent flag clearing issues
	mov rbx, rdi							; move string start into RBX
	.loop:									; strlen loop
	mov al, [rdi]
	inc rdi									; increment RDI
	cmp al, 0								; test the char at RDI
	jne .loop								; jump if the char at RDI is zero
	mov rax, rdi							; move RDI into RAX
	sub rax, rbx							; subtract RBX from RAX to yield strlen
	ret

strcpy:
	mov rax, rdi
	.loop:									; strlen loop
	mov bl, byte [rsi]						; move char at RSI to bl
	test bl, bl								; test the char at RSI
	mov byte [rdi], bl						; move char at RSI to RDI
	inc rsi									; increment RSI
	inc rdi									; increment RDI
	jnz .loop								; jump if the char at RDI is zero
	ret

strcat:
	.loop:									; strlen loop
	cmp byte[rdi], 0						; test the char at RDI
	inc rdi									; increment RDI
	jne .loop								; jump if the char at RDI is not zero
	call strcpy								; call strcpy now that the offset has been determined
	ret

strtok:
	xor rax, rax							; clear RAX to return NULL on error

	test rdi, rdi							; check if RDI (str) is set
	jz .load_str							; load prev_str if NULL is passed
	.str_check_end:

	test rsi, rsi							; check if RSI (delims) is set
	jz .load_delims							; load prev_delims if NULL is passed
	mov [rel strtok_delims], rsi			; set prev_delims if pointer is passed
	.delim_check_end:

	mov rax, rdi
	mov rbx, rsi
	.loop:									; strlen loop
	mov cl, byte[rsi]
	cmp byte[rdi], cl						; compare char with delim
	je .delim_hit							; jump to delim_hit if char is equal to delim
	test cl, cl								; test delim at RSI
	inc rsi									; increment RSI
	jnz .loop								; jump to loop if delim is non zero
	mov rsi, rbx							; reset RSI to start of delims
	inc rdi									; increment RDI
	jnz .loop								; jump if the char at RDI is zero
	.delim_hit:
	inc rdi
	mov byte[rdi], 0						; insert null terminator on hit
	inc rdi
	mov [rel strtok_str], rdi					; set prev_str
	.end:
	ret

	.load_str:
	cmp qword[rel strtok_str], 0
	je .end
	mov rdi, [rel strtok_str]
	jmp .str_check_end

	.load_delims:
	cmp qword[rel strtok_delims], 0
	je .end
	mov rsi, [rel strtok_delims]
	jmp .delim_check_end



section .data
strtok_str: dq 0
strtok_delims: dq 0