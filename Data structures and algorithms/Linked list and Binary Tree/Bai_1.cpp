/*
1.Giả sử cho một danh sách liên kết đơn có thành phần dữ liệu
là các số nguyên dương, người ta muốn tách danh sách đã cho thành
hai danh sách riêng biệt, trong đó một danh sách lưu số chẵn, một
danh sách lưu số lẻ. Hãy trình bày giải thuật và thực hiện cài đặt
để tách danh sách đã cho sao cho hiệu quả nhất về thời gian xử lý
và bộ nhớ sử dụng, đặc biệt xét cả trong trường hợp danh sách đã
cho bao gồm tất cả là số chẵn hoặc số lẻ.
*/
#include <iostream>
#include <stdlib.h>     /* srand, rand */
#include <time.h>       /* time */
using namespace std;

class node
{
    public:
    int value;
    node *next;
};

void creatLL(node **head, int numofvalue) {
    //srand(time(NULL)); before first create
    *head = new node;
    node *tmp1 = *head;
    tmp1->value = rand() % 8;
    for (int i=1; i<numofvalue; i++) {
        node *tmp2 = new node;
        tmp2->value = rand() % 16;
        tmp1->next = tmp2;
        tmp1 = tmp1->next;
    }
    tmp1->next = NULL;
    return;
}

void printLL(node **head) {
    if (*head == NULL) return;
    node *tmp = *head;
    while (tmp->next != NULL)
    {
        cout << tmp->value << " ";
        tmp = tmp->next;
    }
    cout << tmp->value << endl;
    return;
}

void split_parity(node **head, node **even, node **odd) {
    *even = NULL;
    *odd = NULL;
    if (*head == NULL) return;
    node *tmp, *last_even, *last_odd;
    tmp = *head;
    last_even = NULL;
    last_odd = NULL;
    while (tmp != NULL) {
        if (tmp->value % 2 == 0) {
            if (last_even == NULL) {
                last_even = tmp;
                *even = last_even;
                tmp = tmp->next;
            }
            else {
                last_even->next = tmp;
                last_even = tmp;
                tmp = tmp->next;
            }
        }
        else {
            if (last_odd == NULL) {
                last_odd = tmp;
                *odd = last_odd;
                tmp = tmp->next;
            }
            else {
                last_odd->next = tmp;
                last_odd = tmp;
                tmp = tmp->next;
            }
        }
    }
    last_even->next = NULL;
    last_odd->next = NULL;
    *head = NULL;
}

int main() {
    node *head = NULL, *even = NULL, *odd = NULL;
    srand(time(NULL));
    creatLL(&head, 10);
    printLL(&head);
    split_parity(&head, &even, &odd);
    printLL(&even);
    printLL(&odd);
    return 0;
}