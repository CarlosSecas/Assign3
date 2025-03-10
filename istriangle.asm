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
;  Date of last update: 2025-Mar-09
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
;  Assemble (standard): nasm -f elf64 -l istriangle.lis -o istriangle.o istriangle.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l istriangle.lis -o istriangle.o istriangle.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double istriangle();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

global istriangle 

segment .data ; intialized data here
;empty

segment .bss    ; Declare pointers to un-intialized space here
;empty

segment .text

istriangle:
; Use Triangle inequality theorem
; Check if (a + b) > c
movsd xmm3, xmm0 ; load a into xmm3
addsd xmm3, xmm1 ; Add b to a
ucomisd xmm3, xmm2 ; Compare xmm3 (a + b) with xmm2 (c)
jbe not_triangle ; If (a + b) <= c then its not a triangle

; Check if (a + c) > b
movsd xmm3, xmm0 ; Load a to xmm3
addsd xmm3, xmm1 ; Add c to a
ucomisd xmm3, xmm2 ; Compare xmm3 (a + c) with xmm2 (b)
jbe not_triangle ; If (a + c) <= b then its not a triangle

; Check if (b + c) > a
movsd xmm3, xmm0 ; Load b into xmm3
addsd xmm3, xmm1 ; Add c to b
ucomisd xmm3, xmm2 ; compare xmm3 (b + c) with xmm2 (a)
jbe not_triangle ; if (b + c) <=a then its not a triangle

; If all conditions are passed then return 1 for valid triangle
mov rax, 1
ret

not_triangle:
; Return 0 if any condition failed
xor rax, rax
ret


;End of the function istriangle ====================================================================
