#include <stdio.h>
#include <stdlib.h>

int *decompressRLElist(int *nums, int numsSize, int *returnSize)
{
    *returnSize = 0;
    for (int i = 0; i < numsSize; i += 2)
    {
        *returnSize += nums[i];
    }

    int *result = malloc(sizeof(int) * (*returnSize));
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
    int size = 4, returnSize;

    int *p = malloc(sizeof(int)*size);
    *p = 1;
    *(p+1) = 2;
    *(p+2) = 3;
    *(p+3) = 4;

    int* result;
    result = decompressRLElist(p,size,&returnSize);
    for(int i=0;i<returnSize;i++)
        printf("%d ",*(result+i));
    printf("\n");

    free(result);

    size = 6;
    p = realloc(p,sizeof(int)*size);

    *p = 2;
    *(p+1) = 2;
    *(p+2) = 4;
    *(p+3) = 4;
    *(p+4) = 5;
    *(p+5) = 5;

    result = decompressRLElist(p,size,&returnSize);
    for(int i=0;i<returnSize;i++)
        printf("%d ",*(result+i));
    printf("\n");

    free(result);
    free(p);

    return 0;
}
