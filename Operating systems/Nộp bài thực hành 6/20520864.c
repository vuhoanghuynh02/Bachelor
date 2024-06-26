#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// #include <stdbool.h>
#define INF 999999999

int calNumOfPageFault(char** table, const int numOfRefSeq, const int numOfPageFrame) {
	const char* pageFault = table[numOfPageFrame];
    int numOfPageFault = 0;
	for(int i=0; i < numOfRefSeq; i++) {
		if (pageFault[i] == '*') {
			numOfPageFault++;
        }
	}
    return numOfPageFault;
}

void printRes(const char* refSeq, const int numOfRefSeq, const int numOfPageFrame, char** table) {
	const char* pageFault = table[numOfPageFrame];
    int numOfPageFault = 0;

	printf("\t--- Page Replacement algorithm ---\n");
    printf("\t");
	for(int i=0; i < numOfRefSeq; i++) {
		printf("%c ", refSeq[i]);
    }
    printf("\n");

	for(int i=0; i < numOfPageFrame + 1; i++) {
        printf("\t");
		for(int j = 0; j < numOfRefSeq; j++) {
            printf("%c ", table[i][j]);
        }
        printf("\n");
	}

	for(int i=0; i < numOfRefSeq; i++) {
		if (pageFault[i] == '*') {
			numOfPageFault++;
        }
	}

	printf("\n\tNumber of Page Fault: %d\n", numOfPageFault);
}

void FIFO(const char* refSeq, const int numOfRefSeq, const int numOfPageFrame, char** table) {
    char* pageFault = table[numOfPageFrame];
	int first, id;

    table[0][0] = refSeq[0];
    pageFault[0] = '*';
    first = 0;

	for(int j=1; j < numOfRefSeq; j++) {
		for(int i=0; i < numOfPageFrame; i++) {
			table[i][j] = table[i][j - 1];
        }
		id = -1;
        for(int v=0; v < numOfPageFrame; v++) {
    		if (table[v][j] == refSeq[j] || table[v][j] == ' ') {
                id = v;
                break;
            }
        }
		if (id == -1) {
			pageFault[j] = '*';
			table[first][j] = refSeq[j];
			first = (first + 1) % numOfPageFrame;
		}
        else if (table[id][j] == ' ') {
				table[id][j] = refSeq[j];
				pageFault[j] = '*';
        }
	}
}

void OPT(const char* refSeq, const int numOfRefSeq, const int numOfPageFrame, char** table) {
    char* pageFault = table[numOfPageFrame];
	int* next = malloc(numOfPageFrame * sizeof(int));
    int id;

	table[0][0] = refSeq[0];
	pageFault[0] = '*';
    next[0] = INF;
	for(int v = 1; v < numOfRefSeq; v++) {
        if (refSeq[v] == refSeq[0]) {
	        next[0] = v;
            break;
        }
    }

	for(int j=1; j < numOfRefSeq; j++) {
		for(int i = 0; i < numOfPageFrame; i++) {
            table[i][j] = table[i][j - 1];
        }
        id = -1;
        for(int v = 0; v < numOfPageFrame; v++) {
    		if (table[v][j] == refSeq[j] || table[v][j] == ' ') {
                id = v;
                break;
            }
        }
		if (id == -1) {
			int choose = 0;
			for(int i = 1; i < numOfPageFrame; i++) {
				if (next[choose] < next[i]) {
					choose = i;
                }
            }
			table[choose][j] = refSeq[j];
            next[choose] = INF;
			for(int v = j + 1; v < numOfRefSeq; v++) {
				if (refSeq[v] == refSeq[j]) {
			        next[choose] = v;
					break;
                }
            }
			pageFault[j] = '*';
		}
        else {
			if (table[id][j] == ' ') {
				table[id][j] = refSeq[j];
				pageFault[j] = '*';
			}
            next[id] = INF;
			for(int i = j + 1; i < numOfRefSeq; i++) {
				if (refSeq[i] == refSeq[j]) {
			        next[id] = i;
					break;
                }
            }
		}
	}
    free(next);
}

void LRU(const char* refSeq, const int numOfRefSeq, const int numOfPageFrame, char** table) {
    char* pageFault = table[numOfPageFrame];
	int* last = malloc(numOfPageFrame * sizeof(int));
    int id;

	table[0][0] = refSeq[0];
	pageFault[0] = '*';
	last[0] = 0;
	
	for(int j = 1; j < numOfRefSeq; j++) {
		for(int i = 0; i < numOfPageFrame; i++) {
			table[i][j] = table[i][j - 1];
        }
		id = -1;
        for(int v=0; v < numOfPageFrame; v++) {
    		if (table[v][j] == refSeq[j] || table[v][j] == ' ') {
                id = v;
                break;
            }
        }
        if (id == -1) {
			pageFault[j] = '*';
			int min_ref = 0;
			for(int v = 1; v < numOfPageFrame; v++) {
				if (last[v] < last[min_ref]) {
					min_ref = v;
                }
            }
			last[min_ref] = j;
			table[min_ref][j] = refSeq[j];
		}
		else
		{
			if (table[id][j] == ' ') {
				table[id][j] = refSeq[j];
				pageFault[j] = '*';
			}
			last[id] = j;
		}
	}
}

int main() {
    char* refSeq;
    char** table;
    int option, numOfPageFrame, numOfRefSeq;
	printf("\t--- Page Replacement algorithm ---\n");
	printf("\t1. Default referenced sequence\n");
	printf("\t2. Manual input sequence\n");
    scanf("%d", &option);
    char a[] = {'v', '\0'};
    switch(option) {
        case 1:
            refSeq = calloc(8 + 3 +1, sizeof(char));
            strcpy(refSeq,"20520864007");
            break;
        case 2:
            refSeq = calloc(2, sizeof(char));
            strcpy(refSeq,"");
            a[0] = fgetc(stdin);
            if (a[0] == '\n') {
                a[0] = fgetc(stdin);
            }
            while (a[0] != '\n') {
                if (a[0] != ',' && a[0] != ' ') {
                    if (sizeof(refSeq) - 1 == strlen(a)) {
                        refSeq = realloc(refSeq, sizeof(char) * sizeof(refSeq) * 2);
                    }
                    strcat(refSeq, a);
                a[0] = fgetc(stdin);
                }
            }
            break;        
        default:
            return 0;
    }
	numOfRefSeq = strlen(refSeq);
    
    system("clear");
    printf("\t--- Page Replacement algorithm ---\n");
	printf("\tInput page frames: ");
	scanf("%d", &numOfPageFrame);	
    table = calloc(numOfPageFrame + 1, sizeof(*table));
    for(int i=0; i < numOfPageFrame + 1; i++) {
        table[i] = calloc(numOfRefSeq, sizeof(table[0]));
        for(int j=0; j < numOfRefSeq; j++) {
            table[i][j] = ' ';
        }
    }

    system("clear");
    printf("\t--- Page Replacement algorithm ---\n");
    printf("\t1. FIFO algorithm\n");
    printf("\t2. OPT algorithm\n");
    printf("\t3. LRU algorithm\n");
    printf("\t4. All algorithms\n");
    scanf("%d", &option);
    switch(option) {
        case 1: 
            FIFO(refSeq, numOfRefSeq, numOfPageFrame, table);
            break;
        case 2: 
            OPT(refSeq, numOfRefSeq, numOfPageFrame, table);
            break;
        case 3: 
            LRU(refSeq, numOfRefSeq, numOfPageFrame, table);
            break;
        case 4:
            system("clear");
            FIFO(refSeq, numOfRefSeq, numOfPageFrame, table);
            printRes(refSeq, numOfRefSeq, numOfPageFrame, table);
            OPT(refSeq, numOfRefSeq, numOfPageFrame, table);
            printRes(refSeq, numOfRefSeq, numOfPageFrame, table);
            LRU(refSeq, numOfRefSeq, numOfPageFrame, table);
            printRes(refSeq, numOfRefSeq, numOfPageFrame, table);
            return 0;
        default:
            return 0;
    }

    system("clear");
    printRes(refSeq, numOfRefSeq, numOfPageFrame, table);

    int pf1 = calNumOfPageFault(table, numOfRefSeq, numOfPageFrame);
    for(int i=0; i < numOfPageFrame + 1; i++) {
        free(table[i]);
    }
    free(table);
    numOfPageFrame += 1;
    table = calloc(numOfPageFrame + 1, sizeof(*table));
    for(int i=0; i < numOfPageFrame + 1; i++) {
        table[i] = calloc(numOfRefSeq, sizeof(table[0]));
        for(int j=0; j < numOfRefSeq; j++) {
            table[i][j] = ' ';
        }
    }
    switch(option) {
    case 1: 
        FIFO(refSeq, numOfRefSeq, numOfPageFrame, table);
        break;
    case 2: 
        OPT(refSeq, numOfRefSeq, numOfPageFrame, table);
        break;
    case 3: 
        LRU(refSeq, numOfRefSeq, numOfPageFrame, table);
        break;
    default:
        return 0;
    }
    int pf2 = calNumOfPageFault(table, numOfRefSeq, numOfPageFrame);

    if (pf2 > pf1) {
        printRes(refSeq, numOfRefSeq, numOfPageFrame, table);
    }

	return 0;
}