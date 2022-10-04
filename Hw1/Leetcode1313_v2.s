.data
nums: .word 1,2,3,4, 6,5,1,3,2,1, 1,3,2,4,2,7,1,8
numsSize: .word 4,6,8
returnSize: .word 0,0,0
enter: .string "\n"
result: .word 0,0,0,0,0,0,0,0,0,0 ##avoid EXCEEDING boundaries

#####register table#####
#a1 -> nums
#a2 -> numsSize
#a3 -> returnSize
#a4 -> result (base address)
#a5 -> i
#a6 -> j

#s2 = numsSize
#s3 = returnSize
#s4 = indicator for which testing data is executing
#t1 = nums [i]
#t2 = nums [i+1]
#t4 = desired result address
#t5 = number of testing datas

#####function starts#####
.text
initial:
    addi t5, zero, 3        # record number of testing datas need to be executed
    addi s4, zero, 0        # identify which testing data is executing
    la   a1, nums           # get nums[i]     address    a1 -> nums
    la   a2, numsSize       # get numsSize    address    a2 -> numsSize
    la   a3, returnSize     # get returnSize  address    a3 -> returnSize

main:   
    lw   s3, 0(a3)          # s3 = returnSize
    lw   s2, 0(a2)          # s2 = numsSize
    lw   a4, result         # base address of result
    lw   t4, result         # the desired result address
    j    loop

#####loop#####
proc:
    sw   t2, 0(t4)          # result[count] = nums[i+1]
    addi t4, t4, 4          # t4 -> result[count+1]
    addi a6, a6, 1          # j++
    blt  a6, t1, proc       # if j < nums[i], jump back to proc
    add  s3, s3, t1         # *returnSize += nums[i]
    addi a6, zero, 0        # a6 = j = 0
    addi a5, a5, 2          # i += 2
    addi a1, a1, 8          # a1 -> nums[i+2]

loop:
    lw   t1, 0(a1)          # t1 = nums[i]
    lw   t2, 4(a1)          # t2 = nums[i+1]
    bge  a5, s2, print      # if i >= numsSize, jump to print
    blt  a6, t1, proc       # if j  < nums[i] , jump to proc

#####print result and initialize next test set#####
print:
    lw   a0, 0(a4)          # load result[i] to a0
    li   a7, 1              # system call print
    ecall                   # execute system call
    
    addi a4, a4, 4          # move to next result word
    bne  a4, t4, print      # if a4 != final address of t4, jump to print
    la   a0, enter          # print \n
    li   a7, 4              # a7 = 4 means print string
    ecall
    
    ##initialize
    addi a5, zero, 0        # a5 = i = 0

    addi s4, s4, 1          # move to the next testing data
    addi a2, a2, 4          # move to the next numsSize
    addi a3, a3, 4          # move to the next returnSize
    blt  s4, t5, main       # if s4 < 3 jump to main
    j    exit

exit:
    li   a7, 10             # system call exit
    ecall                   # execute system call