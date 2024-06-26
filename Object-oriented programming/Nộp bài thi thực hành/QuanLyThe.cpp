#include "QuanLyThe.h"

void QuanLyThe::nhapThe() {
    int n;
    std::cout << "Nhap bao nhieu the? ";
    std::cin >> n;
    cacThe.resize(n);
    for (int i=0; i<n; i++) {
        std::cin >> *cacThe[i];
    }
}

void QuanLyThe::xuatTienMatToiDaMoiThe() const {
    int n = cacThe.size();
    for (int i = 0; i < n; i++) {
        std::cout << "Tien mat toi da rut duoc: " << cacThe[i]->tinhTienMatToiDa() << "\n";
    }
}

void QuanLyThe::thanhToanOnline(int tien) {
    
}