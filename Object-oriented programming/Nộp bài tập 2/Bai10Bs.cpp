#include "Bai10Bs.h"
#include <iostream>
using namespace std;

DTB2::DTB2() {
    a = 1;
    b = 0;
    c = 0;
}
DTB2::~DTB2() {}
double DTB2::F(const double& x) {
    return a*x*x + b*x + c;
}
DTB2 DTB2::operator+ (const DTB2& dtb2) const {
    DTB2 res;
    res.a = this->a + dtb2.a;
    res.b = this->b + dtb2.b;
    res.c = this->c + dtb2.c;
    if (res.a == 0) {
        cout << "Da thuc moi khong phai bac 2\n";
        return DTB2();
    }
    return res;
}