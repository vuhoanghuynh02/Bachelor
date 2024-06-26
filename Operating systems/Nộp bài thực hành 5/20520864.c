#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
#include <time.h>
#include <stdlib.h>
#define n 33333
#define SEMAPHORE 1

int a[n];
sem_t sem;
int size = 0;

void* them(void* arg) {
    while(1) {
#if SEMAPHORE
        sem_wait(&sem);
        sem_getvalue(&sem, &size);
        size = n - size;
#endif

        a[size] = rand();
        size++;
        printf("Vua THEM, dang co %d phan tu\n", size);
    }
    return NULL;
}

void* xoa(void* arg) {
    while(1) {
#if SEMAPHORE
        sem_getvalue(&sem, &size);
        size = n - size;
#endif

        if (size == 0) {
            printf("Nothing in array a\n");
            continue;
        }

        int index = rand() % size;
        a[index] = a[size-1];
        size--;
        printf("Vua XOA, dang co %d phan tu\n", size);
#if SEMAPHORE
        sem_post(&sem);
#endif
    }
    return NULL;
}

int main() {
    sem_init(&sem, 0, n);
    srand(time(NULL));

    pthread_t t1,t2;
    pthread_create(&t1,NULL,them,NULL);
    pthread_create(&t2,NULL,xoa,NULL);
    pthread_join(t1,NULL);
    pthread_join(t2,NULL);
    sem_destroy(&sem);

    return 0;
}