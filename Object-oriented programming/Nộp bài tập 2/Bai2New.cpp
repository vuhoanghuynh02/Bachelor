#ifndef FRACTION_CPP
#define FRACTION_CPP

#include "Bai2New.h"
#include <algorithm>

void Fraction::simplify(int64_t& numerator, int64_t& denominator) {
	if (numerator == 0) {
		denominator = 1;
		return;
	}
	if (denominator < 0) {
		numerator = - numerator;
		denominator = - denominator;
	}	
	int64_t gcd;
	if (numerator < 0) {
		gcd = std::__gcd(- numerator, denominator);
	} else {
		gcd = std::__gcd(numerator, denominator);
	}
	numerator /= gcd;
	denominator /= gcd;
}

bool Fraction::toInteger(const std::string& str, int64_t& res) {
	res = 0;
	int i = 0;
	if (str[0] == '-') {
		i = 1;
	}
	for (; i<str.length(); i++) {
		if (str[i] < '0' || str[i] > '9') {
			return false;
		}
		res = res * 10 + (str[i] - '0');
	}
	if (str[0] == '-') {
		res = - res;
	}
	return true;
}

Fraction::Fraction() {
	this->numerator = 0;
	this->denominator = 1;
}

Fraction::Fraction(const int64_t& numerator) {
	this->numerator = numerator;
	this->denominator = 1;
}

Fraction::Fraction(const int64_t& numerator, const int64_t& denominator) {
	*this = Fraction();
	this->set(numerator, denominator);		
}

Fraction::Fraction(const Fraction& fraction) {
	this->numerator = fraction.numerator;
	this->denominator = fraction.denominator;
}

Fraction::~Fraction() {}

int64_t Fraction::getNumerator() const {
	return this->numerator;
}

int64_t Fraction::getDenominator() const {
	return this->denominator;
}

void Fraction::set(const int64_t& numerator, const int64_t& denominator) {
	if (denominator == 0) {
		std::cout << "The denominator has not to be zero.\n";
		return;
	}
	this->numerator = numerator;
	this->denominator = denominator;
	Fraction::simplify(this->numerator, this->denominator);
}

Fraction Fraction::toFraction(const std::string& num) {
	int64_t numerator, denominator;
	size_t pos = num.find("/");
	if (pos == std::string::npos || !Fraction::toInteger(num.substr(0, pos), numerator) || !Fraction::toInteger(num.substr(pos + 1), denominator)) {
		std::cout << "Can not convert \"" << num << "\" to Fraction.\n";
		std::cout << "A string should be like numerator/denominator.\n";
		return Fraction();
	}
	return Fraction(numerator, denominator);
}

Fraction Fraction::toFraction(double num) {
	int64_t denominator = 1;
	while (num < 1e9 - 1) {
		num *= 2;
		denominator <<= 1;
	}
	return Fraction(int64_t(num), denominator);
}

int64_t Fraction::toInteger() const {
	return this->numerator / this->denominator;
}

double Fraction::toDouble() const {
	return double(this->numerator) / this->denominator;
}

std::string Fraction::toString() const {
	return std::to_string(this->numerator) + '/' + std::to_string(this->denominator);
}

Fraction Fraction::operator++() {
	this->numerator += this->denominator;
	return *this;
}

Fraction Fraction::operator++(int) {
	Fraction fraction(*this);
	this->numerator += this->denominator;
	return fraction;
}

Fraction Fraction::operator--() {
	this->numerator -= this->denominator;
	return *this;
}

Fraction Fraction::operator--(int) {
	Fraction fraction(*this);
	this->numerator -= this->denominator;
	return fraction;
}

Fraction Fraction::operator-() const {
	Fraction fraction(*this);
	fraction.numerator = - fraction.numerator;
	return fraction;
}

void Fraction::operator=(const Fraction& fraction) {
	this->numerator = fraction.numerator;
	this->denominator = fraction.denominator;
}

void Fraction::operator+=(const Fraction& fraction) {
	int64_t lcd = this->denominator / std::__gcd(this->denominator, fraction.denominator) * fraction.denominator;
	this->numerator = this->numerator * (lcd / this->denominator) + fraction.numerator * (lcd / fraction.denominator);
	this->denominator = lcd;
	Fraction::simplify(this->numerator, this->denominator);
}

void Fraction::operator-=(const Fraction& fraction) {
	*this += - fraction;
}

void Fraction::operator*=(Fraction fraction) {
	if (fraction.numerator == 0) {
		this->numerator = 0;
		this->denominator = 1;
		return;
	}
	Fraction::simplify(this->numerator, fraction.denominator);
	Fraction::simplify(fraction.numerator, this->denominator);
	this->numerator *= fraction.numerator;
	this->denominator *= fraction.denominator;
}

void Fraction::operator/=(Fraction fraction) {
	if (fraction.denominator == 0) {
		std::cout << "Can not divide by 0.\n";
	}
	std::swap(fraction.numerator, fraction.denominator);
	*this *= fraction;
}

Fraction Fraction::operator+(const Fraction& fraction) const {
	Fraction resultFraction(*this);
	resultFraction += fraction;
	return resultFraction;
}

Fraction Fraction::operator-(const Fraction& fraction) const {
	Fraction resultFraction(*this);
	resultFraction -= fraction;
	return resultFraction;
}

Fraction Fraction::operator*(const Fraction& fraction) const {
	Fraction resultFraction(*this);
	resultFraction *= fraction;
	return resultFraction;
}

Fraction Fraction::operator/(const Fraction& fraction) const {
	Fraction resultFraction(*this);
	resultFraction /= fraction;
	return resultFraction;
}

bool Fraction::operator<(const Fraction& fraction) const {
	return (*this - fraction).numerator < 0;
}

bool Fraction::operator<=(const Fraction& fraction) const {
	return (*this - fraction).numerator <= 0;
}

bool Fraction::operator>(const Fraction& fraction) const {
	return (*this - fraction).numerator > 0;
}

bool Fraction::operator>=(const Fraction& fraction) const {
	return (*this - fraction).numerator >= 0;
}

bool Fraction::operator==(const Fraction& fraction) const {
	return (*this - fraction).numerator == 0;
}

bool Fraction::operator!=(const Fraction& fraction) const {
	return (*this - fraction).numerator != 0;
}

// std::istream& operator>>(std::istream& in, Fraction& fraction) {
// 	std::string str;
// 	in >> str;
// 	fraction = Fraction::toFraction(str);
// 	return in;
// }

std::istream& operator>>(std::istream& in, Fraction& fraction) {
	int64_t numerator, denominator;
	std::cout << "Nhap tu so: ";
	in >> numerator;
	std::cout << "Nhap mau so: ";
	in >> denominator;
	while (denominator == 0) {
		std::cout << "Mau so phai khac khong, moi nhap lai.\nNhap tu so: ";
		in >> numerator;
		std::cout << "Nhap mau so: ";
		in >> denominator;
	}
	fraction.set(numerator, denominator);
	return in;
}

// std::ostream& operator<<(std::ostream& out, const Fraction& fraction) {
// 	out << fraction.toString();
// 	return out;
// }

std::ostream& operator<<(std::ostream& out, const Fraction& fraction) {
	if (fraction.getNumerator() == 0) {
		out << 0;
		return out;
	}
	if (fraction.getDenominator() == 0) {
		out << "inf";
		return out;
	}
	if (fraction.getDenominator() == 1) {
		out << fraction.getNumerator();
		return out;
	}
	out << fraction.getNumerator() << '/' << fraction.getDenominator();
	return out;
}

#endif /* FRACTION_CPP */