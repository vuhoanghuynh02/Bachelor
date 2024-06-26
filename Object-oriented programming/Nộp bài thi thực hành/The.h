#ifndef THE_H
#define THE_H

#include <string>
#include <iostream>

class The {
protected:
    int soDu, phiThuongNien;
    std::string daySo, ngaySaoKe;
public:
    virtual int tinhTienMatToiDa() = 0;
    virtual void doInStream(std::istream &in);
    virtual void doOutStream(std::ostream &out) const;
    virtual bool coTheThanhToanOnline(int tien);
};
std::istream & operator >> (std::istream &in,  The &the);
std::ostream & operator << (std::ostream &out, const The &the);

#include "The.cpp"
#endif // THE_H