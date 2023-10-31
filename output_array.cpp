/*
*****************************************************************************************************************************
*Program name: "Sort By Pointers".                                                                                          *
*Copyright (C) 2023 Gabrielius Gintalas.                                                                                    *
*                                                                                                                           *
*This file is part of the software program "Sort By Pointers".                                                              *
*Sort By Pointers is free software: you can redistribute it and/or modify it under the terms of the GNU General Public      *
*License version 3 as published by the Free Software Foundation.                                                            *
*Basic Float Operations is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the       *
*implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
*details.  A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                  *
*****************************************************************************************************************************

========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

Author information
  Author name: Gabrielius Gintalas
  Author email: gabrieliusgintalas@csu.fullerton.edu
  Author CWID: 885861872
  Author NASM: NASM version 2.15.05 

Program information
  Program name: Sort By Pointers
  Programming languages: Two modules in C++ and three modules in X86
  Date program began: Oct-3-2023
  Date of last update: Oct-6-2023
  Date comments upgraded: Oct-9-2023
  Due Date: Oct-16-2023
  Date open source license added: Oct-3-2023
  Files in this program: director.asm, input_array.asm, main.cpp, output_array.cpp, sort_pointers.asm
  Status: Finished.

Purpose
  The purpose of this program is to create a pointer array in which the user inputs up to 8 values and the program creates 
  an array of pointers that point to those values. The program also prints the values that the user inputted, and it is
  also responsible for sorting the array and correctly printing the sorted pointed array from least to greatest

This file
  File name: output_array.cpp
  File purpose: Outputs the values in the array
  Language: C++
  Max page width: 132 columns
  Assemble: g++ -c -m64 -Wall -g -o main.o main.cpp -fno-pie -no-pie -std=c++17
*/
#include <iostream>
#include <cstddef> 
#include <iomanip>

extern "C" {
    void output_array(double* arr[], size_t size); 
}

void output_array(double* arr[], size_t size){
    for(size_t i = 0; i < size; i++){
        std::cout << std::fixed << std::setprecision(8) << *(arr[i]) << std::endl;
    }
}




