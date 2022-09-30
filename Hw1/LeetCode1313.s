.data
nums1: .word 1,2,3,4            #2444
nums2: .word 6,5,1,3,2,1        #555555311  
nums3: .word 1,3,2,4,2,7,1,8    #344778
numsSize1: .word 4
numsSize2: .word 6
numsSize3: .word 8
returnSize1: .word 0
returnSize2: .word 0
returnSize3: .word 0
enter: .string "\n"

.text
main:                       # execute first test data
    la   a1, nums1          # get nums[i]     address    a1->nums1
    la   a2, numsSize1      # get numsSize    address    a2->numsSize1
    lw   a2, 0(a2)          # a2 = numsSize
    la   a3, returnSize1    # get returnSize address     a3->returnSize1
    addi a4, zero, 0        # a4 = i = 0
    ##sw   0, 0(a3)         # *returnSize1 = 0
    addi s2,zero,2          #record number of data set need to be execute
    j    loop_1


#####1st loop#####
step_1:
    slli t0, a4, 2          # calculate nums[i] address
    add  t0, t0, a1         # calculate nums[i] address
    lw   t1, 0(t0)          # load nums[i] to t1
    lw   t0, 0(a3)
    add  t0, t0, t1         
    sw   t0, 0(a3)          # *returnSize += nums[i];
    addi a4, a4, 2          # i += 2

loop_1:
    blt  a4, a2, step_1     # if i < numsSize, jump to loop_2
    addi a4, zero, 0        # set i=0
    addi a5, zero, 0        # a5 = j = 0   
    addi a6, zero, 0        # a6 = count = 0
    j    loop_2

#####2nd loop#####
step_2:
    lw   t1, 4(t0)          # nums[i+1]
    slli t2, a6, 2          # calculate result[] address
    add  t2, t2, s1         # calculate result[] address //s1 -> base address
    sw   t1, 0(t2)          # result[count] = nums[i+1];
    addi a6, a6, 1          # count++
    addi a5, a5, 1          # j++ 

loop_3:
    slli t0, a4, 2          # calculate nums[i] address
    add  t0, t0, a1         # calculate nums[i] address
    lw   t1, 0(t0)          # load nums[i] to t1
    blt  a5, t1, step_2     # if j < nums[i], jump to step_2
    addi a5, zero, 0        # a5 = j = 0      
    addi a4, a4, 2          # i+=2

loop_2:
    blt  a4, a2, loop_3     # if i < numsSize, jump to loop_3
    addi a4, zero, 0        # set i=0
    lw   t0, 0(a3)          
    j    print

#####load different test data#####
main_2:
    la   a1, nums2
    la   a2, numsSize2      # get numsSize2   address    a2->numsSize2
    lw   a2, 0(a2)          # a2 = numsSize2
    la   a3, returnSize2    # get returnSize2 address    a3->returnSize2
    addi a4, zero, 0        # reset a4
    j    loop_1

main_3:
    la   a1, nums3
    la   a2, numsSize3      # get numsSize3   address    a2->numsSize3
    lw   a2, 0(a2)          # a2 = numsSize3
    la   a3, returnSize3    # get returnSize3 address    a3->returnSize3
    addi a4, zero, 0        # reset a4
    j    loop_1

#####print result#####
print:
    slli t2, a4, 2          # calculate result[i] address
    add  t2, t2 ,s1         # calculate result[i] address
    lw   a0, 0(t2)          # load result[i] to a0
    li   a7, 1              # system call print
    ecall                   # execute system call
    addi a4, a4, 1          # i++

    blt  a4, t0, print      # if i < returnSize, jump to print
    la   a0, enter          #print \n
    li   a7, 4              #a7=4 means print string
    ecall
    addi s2, s2, -1 
    bgtz s2,main_2          #if s2 >  0 jump to main_2
    beqz s2,main_3          #if s2 == 0 jump to main_3
    j exit

exit:
    li a7, 10          # system call exit
    ecall              #execute system call