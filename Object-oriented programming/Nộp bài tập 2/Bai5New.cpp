#include "Bai5New.h"

CDate::CDate() {
    day = 1;
    month = 1;
    year = 1;
}
bool CDate::isValid() const {
    if (this->day > CDate().lastDayOfMonth[this->month]) {
        return false;
    }
    if (this->month == 2 && this->day == 29 && !CDate::isLeapYear(this->year)) {
        return false;
    }
    return true;
}
bool CDate::isLeapYear(const int& year) {
    return year % 400 == 0 || (year % 100 != 0 && year % 4 == 0);
}
int CDate::toDays() const {
    int res = 0;
    for (int i= 2; i <= this->year; i++) {
        if (isLeapYear(i)) {
            res += 366;
        } else {
            res += 365;
        }
    }
    for (int i=1; i<this->month; i++) {
        res += lastDayOfMonth[i];
    }
    res += this->day;
    if (!isLeapYear(this->year) && this->month > 2) {
        res--;
    }
    return res;
}
CDate CDate::standardize(int days) {
    CDate res;
    for (int i= 1; ; i++) {
        bool b = isLeapYear(i);
        if (days <= 365 + b) {
            res.year = i;
            break;
        } 
        days -= 365 + b;
    }
    bool b = isLeapYear(res.year);
    for (int i= 1; ; i++) {
        bool b2 = i == 2 && !b;
        if (days <= CDate().lastDayOfMonth[i] - b2) {
            res.month = i;
            break;
        } 
        days -= CDate().lastDayOfMonth[i] - b2;
    }
    res.day = days;
    return res;
}
CDate CDate::operator++ () {
    *this = *this + 1;
    return *this;    
}
CDate CDate::operator++ (int) {
    CDate res = *this;
    *this = *this + 1;
    return res;    
}
CDate CDate::operator-- () {
    *this = *this - 1;
    return *this;    
}
CDate CDate::operator-- (int) {
    CDate res = *this;
    *this = *this - 1;
    return res;       
}
CDate CDate::operator+ (const int& days) const {
    return standardize(this->toDays() + days);
}
CDate CDate::operator- (const int& days) const {
    return standardize(this->toDays() - days);
}
int CDate::operator- (const CDate& cdate) const {
    if (*this < cdate) {
        cout << "Khong the tru CDate lon hon\n";
        return -1;
    }
    return this->toDays() - cdate.toDays();
}
bool CDate::operator< (const CDate& cdate) const {
    if (this->year < cdate.year) {
        return true;
    } else if (this->year == cdate.year) {
        if (this->month < cdate.month) {
            return true;
        } else if (this->month == cdate.month && this->day < cdate.day) {
            return true;
        }
    }
    return false;
}
void CDate::operator= (const CDate& cdate) {
    this->year = cdate.year;
    this->month = cdate.month;
    this->day = cdate.day;
}
istream& operator>> (istream& in, CDate& cdate) {
    cdate = CDate();
    while(cdate.isValid()) {
        cout << "Nhap ngay: ";
        in >> cdate.day;
        cout << "Nhap thang: ";
        in >> cdate.month;
        cout << "Nhap nam: ";
        in >> cdate.year;
        return in;
    }
}
ostream& operator<< (ostream& out, const CDate& cdate) {
    out << "Ngay " << cdate.day << " thang " << cdate.month << " nam " << cdate.year;
    return out;
}