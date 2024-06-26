// https://www.geeksforgeeks.org/program-for-shortest-job-first-sjf-scheduling-set-2-preemptive/
// Chưa hoàn thành


#include <stdio.h>
#include <string.h>
struct Process {
	char name[40]; // Process ID
	int bt; // Burst Time
	int art; // Arrival Time
  int wt;
  int tat;
};

const int INT_MAX = 999999999;
typedef enum { false, true } bool;

// Function to find the waiting time for all
// processes
void findWaitingTime(struct Process proc[], int n)
{
	int rt[n];

	// Copy the burst time into rt[]
	for (int i = 0; i < n; i++)
		rt[i] = proc[i].bt;

	int complete = 0, t = 0, minm = INT_MAX;
	int shortest = 0, finish_time;
	bool check = false;

	// Process until all processes gets
	// completed
	while (complete != n) {

		// Find process with minimum
		// remaining time among the
		// processes that arrives till the
		// current time`
		for (int j = 0; j < n; j++) {
			if ((proc[j].art <= t) &&
			(rt[j] < minm) && rt[j] > 0) {
				minm = rt[j];
				shortest = j;
				check = true;
			}
		}

		if (check == false) {
			t++;
			continue;
		}

		// Reduce remaining time by one
		rt[shortest]--;

		// Update minimum
		minm = rt[shortest];
		if (minm == 0)
			minm = INT_MAX;

		// If a process gets completely
		// executed
		if (rt[shortest] == 0) {

			// Increment complete
			complete++;
			check = false;

			// Find finish time of current
			// process
			finish_time = t + 1;

			// Calculate waiting time
			proc[shortest].wt = finish_time -
						proc[shortest].bt -
						proc[shortest].art;

			if (proc[shortest].wt < 0)
				proc[shortest].wt = 0;
		}
		// Increment time
		t++;
	}
}

// Function to calculate turn around time
void findTurnAroundTime(struct Process proc[], int n)
{
	// calculating turnaround time by adding
	// bt[i] + proc[i].wt
	for (int i = 0; i < n; i++)
		proc[i].tat = proc[i].bt + proc[i].wt;
}

// Function to calculate average time
void findavgTime(struct Process proc[], int n)
{
	int total_wt = 0, total_tat = 0;

	// Function to find waiting time of all
	// processes
	findWaitingTime(proc, n);

	// Function to find turn around time for
	// all processes
	findTurnAroundTime(proc, n);

  FILE *fp;
  fp = fopen("output.txt", "w+");


	// Display processes along with all
	// details
	fprintf(fp, "Processes  Burst time  Waiting time  Turn around time\n");

	// Calculate total waiting time and
	// total turnaround time
	for (int i = 0; i < n; i++) {
		total_wt = total_wt + proc[i].wt;
		total_tat = total_tat + proc[i].tat;
    fputs(proc[i].name, fp);
    fputs("\t\t", fp);
    fputs(proc[i].bt, fp);
    fputs("\t\t ", fp);
    fputs(proc[i].wt, fp);
		fputs("\t\t ", fp);
		fputs(proc[i].tat, fp);
		fputs("\n", fp);
		fputs(" ", fp);
	}

	fputs("\nAverage waiting time = ", fp);
  fputs((float)total_wt / (float)n, fp);
	fputs("\nAverage turn around time = ", fp);
	fputs((float)total_tat / (float)n, fp);

  fclose(fp);
}




// Driver code
int main()
{
	struct Process proc[] = { { "1", 6, 1, 0, 0 }, { "2", 8, 1, 0, 0 },
					{ "3", 7, 2, 0, 0 }, { "4", 3, 3, 0, 0 } };
	int n = sizeof(proc) / sizeof(proc[0]);

	findavgTime(proc, n);
	return 0;
}
