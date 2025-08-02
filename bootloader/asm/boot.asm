; boot.asm

BITS 16                 ; Real mode (BIOS starts CPU in 16-bit mode)
ORG 0x7C00              ; BIOS loads us at memory address 0x7C00

start:
    ; Set up segment registers (needed for safe memory access)
    xor ax, ax          ; AX = 0
    mov ds, ax          ; DS = 0x0000
    mov es, ax          ; ES = 0x0000

    ; Message to print
    mov si, msg         ; Load the address of the string into SI

print_loop:
    lodsb               ; Load byte at DS:SI into AL, increment SI
    or al, al           ; Check if AL == 0 (null terminator)
    jz done             ; If zero, end of string

    mov ah, 0x0E        ; BIOS teletype function
    int 0x10            ; Call BIOS interrupt 0x10 to print AL
    jmp print_loop      ; Repeat for next character

done:
    hlt                 ; Halt CPU (infinite stop)

msg db "Hello from Bros Kernel!", 0

; Padding up to 510 bytes
times 510 - ($ - $$) db 0

; Boot signature: required for BIOS to recognize as bootable
dw 0xAA55
