! =========================================================================================
! A program to calculate the value of e using integer arithmetic. The only time where we 
! need to use floats is when estimating the series length with a test value.

! Author: Eddy Dushime 1084994

! Assumptions: 
!     - The output can have an extra new line character at the end
!==========================================================================================

! wrapper function to execute the entire program
program calce    
    implicit none 

    integer :: estLen
    integer :: num_digits
    real    :: test_value
    integer :: unit_out = 18
    character(len=255) :: output_file
    integer, allocatable, dimension(:) :: evalue

    call getInput(num_digits, output_file)
    
    !allocate size for dynamic array
    allocate(evalue(num_digits))

    call getestLen(num_digits, test_value, estLen)
    call ecalculation(num_digits, evalue, estLen)
    
    call keepe(evalue, output_file)
    
    !free the memory from the allocated array
    deallocate(evalue)

    contains

    ! subroutine to interact with the user
    subroutine getInput(sig_digits, output_file)
        implicit none
 
        character :: overwrite
        logical :: file_exists
        integer, intent(out) :: sig_digits
        character (len = 255), intent(out) :: output_file

        ! Get number of significant digits to compute
        write(*,*) 'Please enter the number of significant digits:'
        read(*,*) sig_digits


        ! Get output filename
        write(*,*) 'Please enter the file name for the output:'
        read(*,*) output_file
        inquire(file = output_file, exist = file_exists)

        ! Program checks if output file already exists and asks to overwrite
        if(file_exists) then
            write(*,*) 'The file already exists, would you like to overwrite it?(Y/N).'
            read(*,*) overwrite
        else
            open(unit = unit_out, file = output_file, status = 'new', action = 'write')
        end if

        ! Loop until the user provides a non-existant file or overwrites an existant file
        if (overwrite == 'Y' .or. overwrite == 'y') then
            open(unit = unit_out, file = output_file, action = 'write')
        elseif (overwrite == 'N' .or. overwrite == 'n') then
            do while (file_exists)
                write(*,*) 'Please provide a different file name:';
                read(*,*) output_file;
                inquire(file = output_file, exist = file_exists)
            end do;
            open(unit = unit_out, file = output_file, status = 'new', action = 'write')
        end if;
    end subroutine getInput

    ! subroutine to find the estimated series length
    subroutine getestLen(sig_digits, test_value, estLen)
        integer, intent(in)  :: sig_digits
        real, intent(out)    :: test_value
        integer, intent(out) :: estLen

        estLen = 4
        test_value = (sig_digits + 1) * 2.30258509
        
        do while((estLen * (log(real(estLen)) - 1.0) + 0.5 * log(6.2831852 * estLen)) < test_value)
            estLen = estLen + 1
        end do

    end subroutine getestLen
    
    ! subroutine to execute the algorithm that results in an array of size n specified by the user
    subroutine ecalculation(sig_digits, evalue, estLen)
        implicit none
        integer, intent(in) :: estLen
        integer :: coeff(2 : estLen)
        integer :: temp, carry, i, j, k = 0
        integer, intent(in) :: sig_digits   
        integer, intent(out), dimension(sig_digits) :: evalue
        
        ! storing 1s for the estimated series length, starting at index 2
        do k = 2, estLen
            coeff(k) = 1
        end do

        ! initialize every element of the evalue array as 0
        evalue = 0

        ! initialize the first element of the evalue array as 2
        evalue(1) = 2

        ! running the integer arithmetic to obtain each value of Euler's number
        do i = 2, sig_digits
            carry = 0
            do j = estLen, 2, -1 
                temp = coeff(j) * 10 + carry
                carry = temp/j
                coeff(j) = temp - carry * j
            end do
            evalue(i) = carry
        end do
    end subroutine ecalculation
    
    ! subroutine to output the result to the ASCII file specified by the user
    subroutine keepe(evalue, filename)
        implicit none

        integer :: i
        character(len=255), intent(in) :: filename
        integer, dimension(:), intent(out) ::  evalue

        100 format(I1)
        200 format(A1)

        ! output to file each value of the array
        do i = 1, size(evalue)
            write(unit_out, 100, advance = 'no') evalue(i)

            if(i==1)then 
                write(unit_out, 200, advance = 'no') '.'
            end if
        end do

        ! display success message and close file pointer
        write(*,*) 'Output successfully generated to ', filename
        close(unit_out, status ='keep')
    end subroutine keepe
end program calce