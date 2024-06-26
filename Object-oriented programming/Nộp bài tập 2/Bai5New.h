#include <iostream>
using namespace std;

class CDate {
private:
    int day, month, year;
    const int lastDayOfMonth[13] = {-1, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    bool isValid() const;

public:
    CDate();
    ~CDate();
    
    static bool isLeapYear(const int&);
    int toDays() const;
    static CDate standardize(int);

    CDate operator++ ();
    CDate operator++ (int);
    CDate operator-- ();
    CDate operator-- (int);
    CDate operator+ (const int&) const;
    CDate operator- (const int&) const;
    int operator- (const CDate&) const;
    bool operator< (const CDate&) const;
    void operator= (const CDate&);
    friend istream& operator>> (istream&, CDate&);
    friend ostream& operator<< (ostream&, const CDate&);
};