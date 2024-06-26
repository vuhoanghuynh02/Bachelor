#include "The.h"

void The::doInStream(std::istream &in) {
    in >> "Nhap so du: ";
    in >> soDu;
}

void The::doOutStream(std::ostream &out) const {
    out << "So du: " << soDu << "\n";
}

std::istream & operator >> (std::istream &in,  The &the) {
    the.doInStream(in);
    return in;
}

std::ostream & operator << (std::ostream &out, const The &the) {
    the.doOutStream(out);
    return out;
}