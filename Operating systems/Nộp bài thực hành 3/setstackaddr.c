// https://docs.oracle.com/cd/E19455-01/806-5257/6je9h032l/index.html#attrib-95722

// Prototype:
int	pthread_attr_setstackaddr(pthread_attr_t *tattr,void *stackaddr);
#include <pthread.h>

pthread_attr_t tattr;
void *base;
int ret;

base = (void *) malloc(PTHREAD_STACK_MIN + 0x4000);

/* setting a new address */
ret = pthread_attr_setstackaddr(&tattr, base);