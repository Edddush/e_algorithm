"""
    This procedure is for calculating the transcendental number
    e to n correct decimal places uses only integer arithmetic, 
    except for estimating the required series length. The digits
    of the result are placed in the array d, the element d[0] containing 
    entire(e) and the subsequent elements the following digits. These digits
    are individually calculated and may be printed one-by-one within the for
    statement labelled 'sweep'.
"""

from json.tool import main
import math
import sys

def ecalculation(num_digits, evalue):
    estLen = 4
    test_value = (num_digits + 1) * 2.30258509
    while (estLen * (math.log(estLen) - 1.0) + 0.5 * math.log(6.2831852 * estLen)) < test_value:
        estLen += 1
    
  
    carry = 0
    temp = 0
    
    coeff = [0 for i in range(estLen+1)]
    for j in range(2, estLen+1):
        coeff[j] = 1
    
    evalue[0] = 2

    for i in range(1, num_digits):
        carry = 0
        
        for j in range(estLen, 1, -1):
            temp = coeff[j] * 10 + carry
            carry = int(temp/j)
            coeff[j] = temp - carry * (j)
        evalue[i] = carry

def keepe(evalue, filename):
    with open(filename, "w+") as pointer:
        sys.stdout = pointer
        output = ''.join(map(str, evalue))
        output = output[:1] + '.' + output[1:]
        print(output)
    pointer.close()

def getInput():
    print("Please enter the number of significant digits: ")
    

def main():
    num_digits = int(input("Please enter the number of significant digits: "))
    
    print("Please enter the file name for the output: ")
    filename = input("\nWARNING: If the file name you input already exists, it will be overwritten!\n");
    
    evalue = [0 for i in range(num_digits)]
    old_io = sys.stdout

    ecalculation(num_digits, evalue) 
    keepe(evalue, filename)

    sys.stdout = old_io
    print("\nOutput successfully recorded in " + filename +"!\n")

if __name__ == "__main__":
    main()
