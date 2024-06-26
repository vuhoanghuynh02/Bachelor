// https://docs.oracle.com/cd/E19455-01/806-5257/6je9h032l/index.html#attrib-45427

// Prototype:
int	pthread_attr_setstacksize(pthread_attr_t *tattr, int size);
#include <pthread.h>

pthread_attr_t tattr;
int size;
int ret;

size = (PTHREAD_STACK_MIN + 0x4000);

/* setting a new size */
ret = pthread_attr_setstacksize(&tattr, size);