#include <iostream>
#include <vector>
using namespace std;

void input (int& n, vector<int>& value, int& k) {
    cout << "Nhap n, chuoi tang dan va k";
    cin >> n;
    value.resize(n);
    cin >> value[0];
    for (int i=1; i<n; i++) {
        cin >> value[i];
        while (value[i] <= value[i-1]) {
            cout << endl << "Yeu cau nhap chuoi tang dan";
            cin >> value[i];
        }
    }
    cin >> k;
}
void output (int pos, int k) {
    cout << endl;
    if (pos == -1) cout << k << " khong co trong chuoi";
    else cout << k << " co vi tri " << pos;
}

int binary_search (int k, vector<int>& value) {
    int left, right, mid;
    left = 0;
    right = value.size() - 1;
    while (1) {
        mid = left + (right - left) / 2;
        if (value[mid] == k) return mid;
        else if (k > value[mid]) left = mid + 1;
        else right = mid - 1;
        if (right < left) return -1;
    }
}
int interpolation_search (int k, vector<int>& value) {
    int left, right, mid;
    left = 0;
    right = value.size() - 1;
    while (1) {
        mid = left + (right - left) / (value[right]-value[left]) * (k-value[left]);
        if (k == value[mid]) return mid;
        else if (k > value[mid]) left = mid + 1;
        else right = mid - 1;
        if (right < left) return -1;
    }
}
int linear_search (int k, vector<int>& value) {
    for (int i=0; i < value.size(); i++) {
        if (k == value[i]) return i;
    }
    return -1;
}
int main() {
    vector <int> value;
    int n, k;
    input(n, value, k);
    output(binary_search(k, value), k);
    output(interpolation_search(k, value), k);
    output(linear_search(k, value), k);
    return 0;
}
