program calce    
    implicit none 
    
    integer :: num_digits = 5
    integer, dimension(2001) :: evalue
    real    :: test_value
    integer :: m
    call get(num_digits, test_value, m)
    call ecalculation(num_digits, evalue, m)
    
    contains
    subroutine getm(sig_digits, test_value, m)
        integer, intent(in)  :: sig_digits
        real, intent(out)    :: test_value
        integer, intent(out) :: m

        m = 4
        test_value = (sig_digits + 1) * 2.30258509
        
        do while((m * (log(real(m)) - 1.0) + 0.5 * log(6.2831852 * m)) < test_value)
            m = m + 1
        end do

    end subroutine getm

    subroutine ecalculation(sig_digits, evalue, m)
        implicit none
        integer, intent(in) :: m
        integer :: coeff(2 : m)
        integer :: temp, carry, i, j, k = 0
        integer, intent(in) :: sig_digits   
        integer, intent(out), dimension(sig_digits) :: evalue
        
        
        ! m = 4
        ! test_value = (sig_digits + 1) * 2.30258509
        
        ! do while((m * (log(real(m)) - 1.0) + 0.5 * log(6.2831852 * m)) < test_value)
        !     m = m + 1
        ! end do

        do k = 2, m
            coeff(k) = 1
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