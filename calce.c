#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int getInput(char * filename){
    int sig_digits = 0;

    printf("Please enter the number of significant digits: ");
    scanf("%d", &sig_digits);

    printf("Please enter the file name for the output\n ");
    printf("WARNING: If the file name you input already exists, it will be overwritten!\n\n");
    scanf("%s", filename);

    return sig_digits;
}

void ecalculation(int num_digits, int * e){
    int m = 4;
    int temp = 0; 
    int carry = 0;
    float test_value = (num_digits + 1) * 2.30258509;
    
   
    while ((m * (log(m) - 1.0) + 0.5 * log(6.2831852 * m)) < test_value){
        m += 1;
    }

    int coeff[m+1];
    for(int i = 0; i <= m; i++){
        coeff[i] = 0;
    }

    for(int i = 2; i <= m; i++){
        coeff[i] = 1;
    }
 
    for (int i = 0; i < num_digits; i++){
        e[i] = 0;
    }
    e[0] = 2;

    for (int i = 1; i < num_digits; i++){
        carry = 0;
        for(int j = m; j >= 2; j--){
            temp = coeff[j] * 10 + carry;
            carry = (int) temp/j;
            coeff[j] = temp - carry * j;
        }
        e[i] = carry;
    }
}

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