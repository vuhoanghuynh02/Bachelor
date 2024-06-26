// https://docs.oracle.com/cd/E19455-01/806-5257/6je9h032l/index.html#attrib-30369

// Prototype:
int	pthread_attr_setinheritsched(pthread_attr_t *tattr, int inherit);
#include <pthread.h>

pthread_attr_t tattr;
int inherit;
int ret;

/* use the current scheduling policy */
ret = pthread_attr_setinheritsched(&tattr, PTHREAD_EXPLICIT_SCHED);