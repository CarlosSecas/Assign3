//****************************************************************************************************************************
//Program name: "Heron's Triangles".  This program calculates the area of a triangle using Heron's formula.                   *
//Copyright (C) 2025  Carlos Secas.                                                                                           *
//                                                                                                                            *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.        *
//See the GNU General Public License for more details. A copy of the GNU General Public License v3 is available here:        *
//<https://www.gnu.org/licenses/>.                                                                                            *
//****************************************************************************************************************************
//****************************************************************************************************************************

//Author: Carlos Secas
//Author email: carlosJsecas@csu.fullerton.edu
//CWID: 886088269
//Class: CPSC 240-09 Section 09
//Program name: Huron’s Triangles
//Programming languages: One module in C, four in X86 Assembly, and one in Bash.
//Date program began: 2025-Mar-06
//Date of last update: 2025-Mar-09
//Files in this program: triangle.c, manager.asm, istriangle.asm, huron.asm, isfloat.asm, triangle.inc, r.sh
//Testing: Alpha testing completed. All functions work correctly.
//Status: Ready for release to the customers

//Purpose of this program:
//  This program calculates the area of a triangle given three side lengths using Heron's formula.
//  It validates input, ensures the sides form a triangle, and computes the area accordingly.

// Devolpment:
//  This C code was developed using Github Codespaces, accessed remotely from a Windows 10 system.

//This file:
//  File name: triangle.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc -m64 -Wall -no-pie -std=c2x -c triangle.c
//  Link: gcc -m64 -no-pie -o triangle.out manager.o istriangle.o huron.o isfloat.o triangle.o -std=c2x -Wall -z noexecstack -lm




#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

extern double manager();

int main(void) {

    char name[50];

    printf("\nWelcome to Heron's Triangles. We take care of all your triangles needs.\n\n");
    printf("Please enter your name: \n");
    fgets(name, sizeof(name), stdin); // Store name (up to 49 characters)

    // Remove the trailing newline from fgets
    name[strcspn(name, "\n")] = 0;

    double count = 0;
    count = manager();

    // Print only if main recieves -1 for failure
    if (count == -1.0) {
        printf("\nThe main function has recieved this number %.1f, and will keep it for a while.\n", (double)count);
        printf("\nA -1 will be returned to the operating system.");
        return -1;
    }

    printf("\nThe main function has received this number %lf, and will keep it for a while\n",count);
    printf("\nThank you %s, Your patronage is appreciated.\n", name);
    printf("\nA zero will not be return to the operating system.\n");
    return 0;
}