// https://docs.oracle.com/cd/E19455-01/806-5257/6je9h032l/index.html#attrib-76485

// Prototype:
int	pthread_attr_setscope(pthread_attr_t *tattr,int scope);
#include <pthread.h>

pthread_attr_t tattr;
int ret;

/* bound thread */
ret = pthread_attr_setscope(&tattr, PTHREAD_SCOPE_SYSTEM);

/* unbound thread */
ret = pthread_attr_setscope(&tattr, PTHREAD_SCOPE_PROCESS);