;****************************************************************************************************************************
;Program name: "Heron's Triangles".  This program calculates the area of a triangle using Heron's formula.                   *
; Copyright (C) 2025  Carlos Secas .          *
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Carlos Secas
;  Author email: carlosJsecas@csu.fullerton.edu
;  CWID: 886088269
;  Class: 240-09 Section 09
;
;Program information
;  Program name: Heron's Triangles
;  Programming languages: One module in C, four in X86 Assembly, and one in Bash.
;  Date program began: 2025-Mar-06
;  Date of last update: 2025-Mar-07
;  Files in this program: triangle.c, manager.asm, istriangle.asm, huron.asm, isfloat.asm, triangle.inc, r.sh
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;   This program calculates the area of a triangle given three side lengths using Heron's formula.
;   It validates input, ensures the sides form a triangle, and computes the area accordingly.
;
;Devlopment
;  This assembly code was developed using NASM in a Linux-based enviorment within Github Codespaces,
;  accessed remotely from a Windows 10 system.  
;
;This file:
;  File name: manager.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l manager.lis -o manager.o manager.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l manage.lis -o manager.o manager.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double manager();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

%include "triangle.inc" ; Include macros
global manager
extern isfloat
extern istriangle
extern huron
extern printf 
extern scanf
extern atof



segment .data ; intialized data here
prompt_sides db 10, "Please enter the lengths of three sides of a triangle: ", 10,0
invalid_input_msg db 10, "Error input try again.", 10,0
thank_you_msg db 10, "Thank you.", 10,0
valid_triange_msg db 10, "These inputs have been tested and they are sides of a valid triangle.", 10,0
apply_huron_formula_msg db 10, "The Huron formula will be applied to find the area.", 10,0
area_result_msg db 10, "The area is %lf sq units. This number will be returned to the caller module.", 10,0
str_format db "%s", 0


segment .bss    ; Declare pointers to un-intialized space here
side1 resq 1
side2 resq 1
side3 resq 1
input_str resb 32
computed_area resq 1


segment .text


manager:

backup_gprs ; Backup all GPR's
backup_fpu ; Backup all FPR's
display_info ; Print author details

input_loop:
; Print prompt_sides for user input
mov rax, 0
mov rdi, prompt_sides
call printf

; Read first input as string
mov rax, 0
mov rdi, str_format
mov rsi, input_str
call scanf

; Validate first input using isfloat
mov rdi, input_str ; Pass string address to isfloat
call isfloat
cmp rax, 0
jz invalid_input ; If invalid restart the process

; Convert to float using atof and store
mov rdi, input_str
call atof
movsd qword [side1], xmm0 ; atof returns result in xmm0

; Read second input as string
mov rax, 0
mov rdi, str_format
mov rsi, input_str
call scanf

; Validate using isfloat
mov rdi, input_str
call isfloat
cmp rax, 0
jz invalid_input

; Convert the string to float using atof
mov rdi, input_str
call atof
movsd qword [side2], xmm0

; Read third input as string
mov rax, 0
mov rdi, str_format
mov rsi, input_str
call scanf

; Validate the third input using isfloat
mov rdi, input_str
call isfloat
cmp rax, 0
jz invalid_input

; Convert the string to float using atof
mov rdi, input_str
call atof
movsd qword [side3], xmm0

mov rax, 0
mov rdi, thank_you_msg
call printf

; Continue the program
jmp continue_execution

invalid_input:
mov rax, 0
mov rdi, invalid_input_msg
call printf
jmp input_loop

continue_execution:
; Call istriangle to validate if the sides form a triangle
movsd xmm0, [side1]
movsd xmm1, [side2]
movsd xmm2, [side3]
call istriangle

; If return value = 0 (invalid triangle)
cmp rax, 0
je invalid_input ; ask for input agian (not a triangle)


; Print user that the triangle is valid
mov rax, 0
mov rdi, valid_triange_msg
call printf

; Compute area by using Huron
movsd xmm0, qword [side1]
movsd xmm1, qword [side2]
movsd xmm2, qword [side3]
call huron 

; Store the computed area before calling printf
movsd qword [computed_area], xmm0


; Print the area computed from Huron
mov rax, 0
mov rdi, area_result_msg
mov rax, 1 ; 1 for the expected floating point #
call printf

; Restore xmm0 after printf modifies registers
movsd xmm0, qword [computed_area]


restore_fpu ; Restore FPR's
restore_gprs ; Restore GPR's
ret
;End of the function manager ====================================================================
