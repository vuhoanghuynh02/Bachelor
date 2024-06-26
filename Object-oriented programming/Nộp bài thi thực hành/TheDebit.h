#ifndef THE_DEBIT_H
#define THE_DEBIT_H

#include "The.h"

class TheDebit : public The {
public:
    int tinhTienMatToiDa() const;
    void doInStream(std::istream &in);
    void doOutStream(std::ostream &in);
};

#include "TheDebit.cpp"
#endif // THE_DEBIT_H