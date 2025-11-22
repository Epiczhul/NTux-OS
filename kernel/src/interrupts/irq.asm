[BITS 64]

global irq_stub_table

extern irq_handler_c   ; C-Funktion, die wir gleich schreiben

section .text

; ---- IRQ STUBS ----
; Jede IRQ-Stubs speichert Register, ruft C-Funktion auf und schickt PIC ACK.

irq_stub_table:
%assign i 0
%rep 16
    dq irq_stub_%+i
%assign i i+1
%endrep

%macro IRQ_STUB 1
global irq_stub_%1
irq_stub_%1:
    ; Push IRQ number
    push qword %1  ; Push IRQ Nummer auf den Stack

    ; Save registers
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11

    mov rdi, rsp          ; Argument: pointer to saved regs
    call irq_handler_c    ; Call C-IRQ-Handler

    ; Restore registers
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax

    add rsp, 8            ; Entferne IRQ Nummer vom Stack

    iretq                 ; Rückkehr von Interrupt
%endmacro

; Generiere alle 16 IRQ-Stubs
%assign i 0
%rep 16
    IRQ_STUB i
%assign i i+1
%endrep
