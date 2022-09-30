#include <stdio.h>
#include <stdlib.h>

int *decompressRLElist(int *nums, int numsSize, int *returnSize)
{
    *returnSize = 0;
    for (int i = 0; i < numsSize; i += 2)
    {
        *returnSize += nums[i];
    }

    int *result = (int*) malloc(sizeof(int) * (*returnSize));
    int count = 0;

    for (int i = 0; i < numsSize; i += 2)
    {
        for (int j = 0; j < nums[i]; j++)
        {
            result[count++] = nums[i+1];
        }
    }

    return result;
}

int main()
{
    //size=4
    int numsSize = 4, returnSize;
    int* result;

    int *nums = (int*) malloc(sizeof(int)*numsSize);
    nums[0] = 1;
    nums[1] = 2;
    nums[2] = 3;
    nums[3] = 4;

    result = decompressRLElist(nums,numsSize,&returnSize);
    /* output verification
    for(int i=0;i<returnSize;i++)
        printf("%d ",*(result+i));
    printf("\n");
    */
    free(result);

    //size=6
    numsSize = 6;
    nums = (int*) realloc(nums,sizeof(int)*numsSize);

    nums[0] = 6;
    nums[1] = 5;
    nums[2] = 1;
    nums[3] = 3;
    nums[4] = 2;
    nums[5] = 1;

    result = decompressRLElist(nums,numsSize,&returnSize);
    free(result);

    //size=8
    numsSize = 8;
    nums = (int*) realloc(nums,sizeof(int)*numsSize);

    nums[0] = 1;
    nums[1] = 3;
    nums[2] = 2;
    nums[3] = 4;
    nums[4] = 2;
    nums[5] = 7;
    nums[6] = 1;
    nums[7] = 8;

    result = decompressRLElist(nums,numsSize,&returnSize);
    free(result);

    //free nums
    free(nums);

    return 0;
}
