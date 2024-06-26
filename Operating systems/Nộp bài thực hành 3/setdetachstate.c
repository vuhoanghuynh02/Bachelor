// https://docs.oracle.com/cd/E19455-01/806-5257/6je9h032l/index.html#attrib-69011

// Prototype:
int	pthread_attr_setdetachstate(pthread_attr_t *tattr,int detachstate);
#include <pthread.h>

pthread_attr_t tattr;
int ret;

/* set the thread detach state */
ret = pthread_attr_setdetachstate(&tattr,PTHREAD_CREATE_DETACHED);