"""
    This procedure is for calculating the transcendental number
    e to n correct decimal places uses only integer arithmetic, 
    except for estimating the required series length. The digits
    of the result are placed in the array d, the element d[0] containing 
    entire(e) and the subsequent elements the following digits. These digits
    are individually calculated and may be printed one-by-one within the for
    statement labelled 'sweep'.
"""

import math

def ecalculation(num_digits, evalue):
    m = 4
    test_value = (num_digits + 1) * 2.30258509
    while (m * (math.log(m) - 1.0) + 0.5 * math.log(6.2831852 * m)) < test_value:
        m += 1
    
  
    carry = 0
    temp = 0
    
    coeff = [0 for i in range(m+1)]
    for j in range(2, m+1):
        coeff[j] = 1
    
    evalue[0] = 2

    for i in range(1, num_digits):
        carry = 0
        
        for j in range(m, 1, -1):
            temp = coeff[j] * 10 + carry
            carry = int(temp/j)
            coeff[j] = temp - carry * (j)
        evalue[i] = carry
    print(''.join(map(str, evalue))) 

n = 10
evalue = [0 for i in range(n)]
ecalculation(n, evalue)