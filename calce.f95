program calce    
    implicit none 
    
    integer :: num_digits = 801
    integer, dimension(2001) :: evalue

    call ecalculation(num_digits, evalue)
    
    contains

    subroutine ecalculation(sig_digits, evalue)
        implicit none

        real    :: test_value
        integer :: coeff(2 : 806) = 1
        integer :: temp, carry, m, i, j = 0
        integer, intent(in) :: sig_digits   
        integer, intent(out), dimension(sig_digits) :: evalue
        
        
        m = 4
        test_value = (sig_digits + 1) * 2.30258509
        
        do while((m * (log(real(m)) - 1.0) + 0.5 * log(6.2831852 * m)) < test_value)
            m = m + 1
        end do

        ! initialize every element of the evalue array as 0
        evalue = 0

        !initialize the first element of the evalue array as 2
        evalue(1) = 2

        do i = 2, sig_digits
            carry = 0
            do j = m, 2, -1 
                temp = coeff(j) * 10 + carry
                carry = temp/j
                coeff(j) = temp - carry * j
            end do
            evalue(i) = carry
        end do
        
        do i = 1, sig_digits
            write(*,*) evalue(i)
        end do

    end subroutine ecalculation
end program calce