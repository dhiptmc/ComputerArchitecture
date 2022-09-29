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
