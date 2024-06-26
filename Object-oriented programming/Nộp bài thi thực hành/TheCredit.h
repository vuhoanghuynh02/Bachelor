#ifndef THE_CREDIT_H
#define THE_CREDIT_H

#include "The.h"

class TheCredit : public The {
protected:
    int hanMuc;
public:
    int tinhTienMatToiDa() const;
    void doInStream(std::istream &in);
    void doOutStream(std::ostream &in);
};

#include "TheCredit.cpp"
#endif // THE_CREDIT_H