// A program to calculate the value of e using integer arithmetic. The only time where we 
// need to use floats is when estimating the series length with a test value.

// Author: edddush

// Assumptions: 
//     - The output can have an extra new line character at the end

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// function to obtain input from the user
int getInput(char * filename){
    int sig_digits = 0;

    printf("Please enter the number of significant digits: ");
    scanf("%d", &sig_digits);

    printf("Please enter the file name for the output\n");
    printf("\nWARNING: If the file name you input already exists, it will be overwritten!\n\n");
    scanf("%s", filename);

    return sig_digits;
}

// function to compute the e value to the number of significant digits specified by the user
void ecalculation(int num_digits, int * e){
    int estLen = 4;
    int temp = 0; 
    int carry = 0;
    float test_value = (num_digits + 1) * 2.30258509;
    
    // find the estimated series length
    while ((estLen * (log(estLen) - 1.0) + 0.5 * log(6.2831852 * estLen)) < test_value){
        estLen += 1;
    }

    // initialize array elements to 0
    int coeff[estLen+1];
    for(int i = 0; i <= estLen; i++){
        coeff[i] = 0;
    }

    for(int i = 2; i <= estLen; i++){
        coeff[i] = 1;
    }

    //first initial number is 2 rest are 0
    for (int i = 0; i < num_digits; i++){
        e[i] = 0;
    }
    e[0] = 2;

    // integer arithmetic to computer each number in e
    for (int i = 1; i < num_digits; i++){
        carry = 0;
        for(int j = estLen; j >= 2; j--){
            temp = coeff[j] * 10 + carry;
            carry = (int) temp/j;
            coeff[j] = temp - carry * j;
        }
        e[i] = carry;
    }
}

// function to output the result to the specified file by the user
void keepe(int * evalue, char * filename, int size){
    FILE *pointer = fopen(filename, "w+" );


    for(int i=0; i < size; i++){
        fprintf(pointer, "%d", evalue[i]);
        
        if(i==0){
            fprintf(pointer, ".");
        }
    }

    printf("Output successfully recorded in %s!\n", filename);

    if(pointer != NULL){
        free(filename);
        fclose(pointer);
    }
}

// main function to run the entire program
int main(){
    int * evalue;
    int num_digits = 0;
    char * filename = malloc(sizeof(char) * 256);

    num_digits = getInput(filename);
    evalue = malloc(sizeof(int) * (num_digits));

    ecalculation(num_digits, evalue);
    keepe(evalue, filename, num_digits);

    free(evalue);
    return 0;
}
