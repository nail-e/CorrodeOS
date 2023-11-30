org 0x7C00
bits 16

%define ENDL 0x0D, 0X0A

start:
  jmp main

; Prints a string to the screen
puts:
  ;save registers
  push si 
  push ax

.loop:
  lodsb     ;loads next character in al
  or al, al 
  jz .done

  mov ah, 0x0e
  int 0x10

  jmp .loop

.done:
  pop ax
  pop si
  ret

main:
  ; Setup data segments
  mov ax, 0 
  mov ds, ax
  mov es, ax 

  ; Setup stack
  mov ss, ax
  mov sp, 0x7C00  ;

  mov si, msg_hello 
  call puts

  jmp .halt

.halt:
  jmp .halt

msg_hello: db 'Hello world', ENDL, 0

times 510-($-$$) db 0 
dw 0xAA55
