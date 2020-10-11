#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

static void show_array(int *arg, int len);

static void merge(int *arg, int start, int mid, int end)
{
        int len = end - start + 1;
        int l_value = 0;
        int r_value = 0;
        int i = 0;
        int r_index = mid + 1;
        int l_index = start;
        int *copy = (int *)calloc(len, sizeof(int));

        if (copy == NULL) {
                printf("alloc memeory fail\n");
                return;
        }
        
        while (i < len) {
                l_value = (l_index <= mid)? arg[l_index]: INT_MAX;
                r_value = (r_index <= end)? arg[r_index]: INT_MAX;

                if (l_value <= r_value) {
                        copy[i++] = l_value;
                        l_index++;
                } else if (l_value > r_value){
                        copy[i++] = r_value;
                        r_index++;
                }
        }

        memcpy(&arg[start], copy, len * sizeof(int));
        free(copy);
}

static void merge_sort(int *arg, int start, int end)
{
        if (start < end) {
                int mid = (start + end) / 2;
                merge_sort(arg, start, mid);
                merge_sort(arg, mid + 1, end);
                merge(arg, start, mid, end);
        }
}

static void show_array(int *arg, int len)
{
        int i = 0;

        printf("Array content: \n");
        for (i = 0; i < len; i++) {
                printf("%d, ", arg[i]);
        }
        printf("\n");
}

int main(void)
{
        int arg [] = {9, 8, 7, 6, 5, 4, 3, 2, 1, 0};
        int len = sizeof(arg)/sizeof(arg[0]);

        printf("---- Before sort ----\n");
        show_array(arg, len);
        
        merge_sort(arg, 0, len - 1);
       
        printf("\n\n");
        printf("---- After sort ----\n");
        show_array(arg, len);

        return 0;
}
