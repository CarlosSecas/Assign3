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
;  File name: huron.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l huron.lis -o huron.o huron.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l huron.lis -o huron.o huron.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double huron();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

global huron

segment .data ; intialized data here
one_half dq 0.5
zero dq 0.0

segment .bss ; Declare pointers to un-intialized space here
;empty

segment .text

huron:

; Compute s = 0.5(a + b +c)
movsd xmm3, xmm0 ; Load a into xmm3
addsd xmm3, xmm1 ; Add b to a
addsd xmm3, xmm2 ; Add c to (a + b)
movsd xmm4, qword [one_half] ; xmm4 = 0.5
mulsd xmm3, xmm4 ; xmm3 = (a + b + c) * 0.5

; Compute (s - a)
movsd xmm6, xmm3 ; xmm6 = s
subsd xmm6, xmm0 ; s - a

; Compute (s - b)
movsd xmm7, xmm3 ; xmm7 = s
subsd xmm7, xmm1 ; s - b

; Compute (s - c)
movsd xmm8, xmm3 ; xmm8 = s
subsd xmm8, xmm2 ; s - c

movsd xmm9, qword [zero] ; Load zero to xmm9 register for opperand size match

; Check if (s - a) > 0
ucomisd xmm6, xmm9
jbe return_nan

; Check if (s - b) > 0
ucomisd xmm7, xmm9
jbe return_nan

; Check if (s - c) > 0
ucomisd xmm8, xmm9
jbe return_nan

; Compute s * (s - a) * (s - b) * (s - c)
mulsd xmm3, xmm6 ; s * (s - a)
mulsd xmm3, xmm7 ; s * (s - b)
mulsd xmm3, xmm8 ; s * (s - c)

; Check if the result is positive before computing sqrt
ucomisd xmm3, xmm9
jbe return_nan ; if result <= 0 then return NaN

; Compute sqrt(s * (s - a) * (s - b) * (s - c))
sqrtsd xmm0, xmm3 ; xmm0 = sqrt(xmm3)

; Return area in xmm0
ret

return_nan:
movsd xmm0, xmm9 ; Return 0.0 instead of Nan
ret

;End of the function huron ====================================================================
