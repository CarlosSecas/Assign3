;Information: This include file was first created to accompany the program Huron's Triangles.
;This program calculates the area of a triangle using Heron's formula.



;This is an include file for the program manager.asm.   File name: triangle.inc



%ifndef TRIANGLE_INC
%define TRIANGLE_INC

;===== Backup General-Purpose Registers (GPRs) ==========================================================

%macro backup_gprs 0
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf
%endmacro

;===== Restore General-Purpose Registers (GPRs) ==========================================================

%macro restore_gprs 0
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp
%endmacro

;===== Backup Floating-Point and SSE Registers ==========================================================

%macro backup_fpu 0
    sub rsp, 16
    movdqu [rsp], xmm6
    sub rsp, 16
    movdqu [rsp], xmm7
%endmacro

;===== Restore Floating-Point and SSE Registers ==========================================================

%macro restore_fpu 0
    movdqu xmm7, [rsp]
    add rsp, 16
    movdqu xmm6, [rsp]
    add rsp, 16
%endmacro

;===== Display Personal Information ==========================================================

%macro display_info 0
    segment .data
    author_msg db 10, "This program is brought to you as a courtesy of", 10, 0
    name_msg db "Author: Carlos Secas", 10, 0
    cwid_msg db "CWID: 886088269", 10, 0
    email_msg db "Email: carlosJsecas@csu.fullerton.edu", 10, 0

    segment .text
    mov rdi, author_msg
    call printf
    mov rdi, name_msg
    call printf
    mov rdi, cwid_msg
    call printf
    mov rdi, email_msg
    call printf
%endmacro

%endif
