#!/bin/bash

# Program Name: Huron’s Triangles
# Author: Carlos Secas
# Author Email: carlosJsecas@gmail.com
# CWID: 886088269
# Class: 240-09 Section 09
# This file is the script file that accompanies the "Huron’s Triangles" program.
# Prepare for execution in normal mode (not gdb mode).

# Delete unnecessary files
rm -f *.o
rm -f *.out

echo "Assembling manager.asm..."
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assembling istriangle.asm..."
nasm -f elf64 -l istriangle.lis -o istriangle.o istriangle.asm

echo "Assembling huron.asm..."
nasm -f elf64 -l huron.lis -o huron.o huron.asm

echo "Assemble the source file isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compiling the C source file triangle.c..."
gcc -m64 -Wall -no-pie -std=c2x -c -o triangle.o triangle.c

echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -o triangle.out manager.o istriangle.o huron.o isfloat.o triangle.o -std=c2x -Wall -z noexecstack -lm

echo "Setting execute permissions for triangle.out..."
chmod +x triangle.out

echo "Executing the program..."
./triangle.out

echo "This bash script will now terminate."
