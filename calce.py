"""
A program to calculate the value of e using integer arithmetic. The only time where we 
need to use floats is when estimating the series length with a test value.

Author: Edddush

Assumptions: 
    - The output can have an extra new line character at the end
"""

from json.tool import main
import math
import sys

# function to execute the algorithm that results in an array of size n specified by the user
def ecalculation(num_digits, evalue):
    estLen = 4
    test_value = (num_digits + 1) * 2.30258509

    # finding the estimated series length
    while (estLen * (math.log(estLen) - 1.0) + 0.5 * math.log(6.2831852 * estLen)) < test_value:
        estLen += 1
    
  
    carry = 0
    temp = 0
    
    # storing 1s for the estimated series length, starting at index 2
    coeff = [0 for i in range(estLen+1)]
    for j in range(2, estLen+1):
        coeff[j] = 1
    
    evalue[0] = 2

    # running the integer arithmetic to obtain each value of Euler's number
    for i in range(1, num_digits):
        carry = 0
        
        for j in range(estLen, 1, -1):
            temp = coeff[j] * 10 + carry
            carry = int(temp/j)
            coeff[j] = temp - carry * (j)
        evalue[i] = carry

# function to output the result to the ASCII file specified by the user
def keepe(evalue, filename):
    with open(filename, "w+") as pointer:
        sys.stdout = pointer
        output = ''.join(map(str, evalue))
        output = output[:1] + '.' + output[1:]
        print(output)
    pointer.close()
    
# wrapper function to execute the entire program and interact with the user
def main():
    num_digits = int(input("Please enter the number of significant digits: "))
    
    print("Please enter the file name for the output: ")
    filename = input("\nWARNING: If the file name you input already exists, it will be overwritten!\n");
    
    evalue = [0 for i in range(num_digits)]
    
    # temporary variable for standard output
    old_io = sys.stdout

    ecalculation(num_digits, evalue) 
    keepe(evalue, filename)

    #setting back to standard output
    sys.stdout = old_io
    print("\nOutput successfully recorded in " + filename +"!\n")

# calling the wrapper function
if __name__ == "__main__":
    main()
