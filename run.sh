#!/bin/bash

#Author: Gabrielius Gintalas
#Date: 10/03/23
#Program name: Assignment 03 - Sort By Pointers
#Email: gabrieliusgintalas@csu.fullerton.edu
#CWID: 885861872

rm -f *.o
rm -f *.out

echo "Assemble the assembly modules"
nasm -f elf64 -l director.lis -o director.o director.asm
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
nasm -f elf64 -l sort_pointers.lis -o sort_pointers.o sort_pointers.asm

echo "Compile the C++ module main.cpp and output_array.cpp with debugging information"
g++ -c -m64 -Wall -g -o main.o main.cpp -fno-pie -no-pie -std=c++17
g++ -c -m64 -Wall -g -o output_array.o output_array.cpp -fno-pie -no-pie -std=c++17

echo "Link the object files with debugging information"
g++ -m64 -g -o sort_by_pointers.out main.o director.o input_array.o output_array.o sort_pointers.o -fno-pie -no-pie -std=c++17 -lc

echo "Run the program - Sort By Pointers"
./sort_by_pointers.out

rm -f *.o
rm -f *.lis

echo "The bash script file is now closing."

