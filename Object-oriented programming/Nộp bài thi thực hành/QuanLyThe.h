#ifndef QUAN_LY_THE_H
#define QUAN_LY_THE_H

#include <vector>
#include "The.h"

class QuanLyThe {
private:
    std::vector<The*> cacThe;
public:
    void nhapThe();
    void xuatTienMatToiDaMoiThe() const;
    void thanhToanOnline(int tien);
};

#include "QuanLyThe.cpp"
#endif // QUAN_LY_THE_H




