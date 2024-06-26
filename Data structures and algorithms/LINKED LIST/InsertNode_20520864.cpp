#include <iostream>
using namespace std;

class node {
    public:
    int value;
    node *next;
};

void createLL(node &head, int n);
void printLL(node &head);
void insertNode(node &head, int value, int index);

int main() {
    node head;
    createLL(head, 5);
    printLL(head);
    insertNode(head, 5, 0);
    insertNode(head, 6, -1);
    insertNode(head, 7, 3);
    printLL(head);
}

void createLL(node &head, int n) {
    node *tmp = &head;
    tmp->value = 0;
    for (int i=1; i<n; i++) {
        node *next = new node;
        next->value = i;
        next->next = NULL;
        tmp->next = next;
        tmp = next;
    }
}

void printLL(node &head) {
    node *tmp = &head;
    do {
        cout << tmp->value << " ";
        tmp = tmp->next;
    } 
    while(tmp != NULL);
    cout << endl;
}

void insertNode(node &head, int value, int index) {
    // 0 is first, -1 is last, other is index
    if (index == 0) {
        node *tmp = new node;
        tmp->value = head.value;
        tmp->next = head.next;
        head.value = value;
        head.next = tmp;
    }
    else if (index == -1) {
        node *tmp = &head;
        while (tmp->next != NULL)
            tmp = tmp->next;
        node *tmp2 = new node;
        tmp2->value = value;
        tmp2->next = NULL;
        tmp->next = tmp2;
    }
    else {
        node *tmp = &head;
        int i = 0;
        while(tmp->next != NULL && i < index) {
            tmp = tmp->next;
            i++;
        }
        if (i < index) return;
        node *tmp2 = new node;
        tmp2->value = tmp->value;
        tmp2->next = tmp->next;
        tmp->value = value;
        tmp->next = tmp2;
    }
}