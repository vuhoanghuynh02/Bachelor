/*######################################
# University of Information Technology #
# IT007 Operating System               #
# Huỳnh Hoàng Vũ, MSSV 20520864        #
# File: bt1.c                          #
######################################*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

int loop_forever = 1;
void on_sigint() {
    printf("\nYou are pressed CTRL+C! Goodbye!\n");
    loop_forever = 0;
};

int main() {
    system("echo \"Welcome to IT007, I am 20520864!\"");
    
    pid_t pid = fork();
    if (pid > 0) {
        loop_forever = 1;
        signal(SIGINT, on_sigint); 
        while(loop_forever) {}
    } else {
        system("/usr/bin/gedit ./abcd.txt");
    }

    return 0;
}
