/*
2. Hãy trình bày giải thuật và thực hiện cài đặt trộn hai danh sách
liên kết đơn đã có thứ tự (tăng hoặc giảm dần) thành một danh sách có
thứ tự sao cho tối ưu bộ nhớ nhất có thể.
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
        tmp2->value = tmp1->value + rand() % 8;
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

void mergeLL (node **LL, node **LL1, node **LL2) {
    if (*LL2 == NULL) {
        *LL = *LL1;
        *LL1 = NULL;
    }
    else if (*LL1 == NULL) {
        *LL = *LL2;
        *LL2 = NULL;
    }
    else {
        node *tmp1, *tmp2, *last;
        tmp1 = *LL1;
        tmp2 = *LL2;
        if (tmp1->value <= tmp2->value) {
            last = tmp1;
            tmp1 = tmp1->next;
            last->next = NULL;
        }
        else {
            last = tmp2;
            tmp2 = tmp2->next;
            last->next = NULL;
        }
        *LL = last;
        while (tmp1 != NULL && tmp2 != NULL) {
            if (tmp1->value <= tmp2->value) {
                last->next = tmp1;
                tmp1 = tmp1->next;
            }
            else {
                last->next = tmp2;
                tmp2 = tmp2->next;
            }
            last = last->next;
        }
        while (tmp1 != NULL) {
            last->next = tmp1;
            tmp1 = tmp1->next;
            last = last->next;
        }
        while (tmp2 != NULL) {
            last->next = tmp2;
            tmp2 = tmp2->next;
            last = last->next;
        }
        last->next = NULL;
        *LL1 = NULL;
        *LL2 = NULL;
    }
}

int main() {
    node *LL1 = NULL, *LL2 = NULL, *LL = NULL;
    srand(time(NULL));
    creatLL(&LL1, 7);
    printLL(&LL1);
    creatLL(&LL2, 8);
    printLL(&LL2);
    mergeLL(&LL, &LL1, &LL2);
    printLL(&LL);
    return 0;
}