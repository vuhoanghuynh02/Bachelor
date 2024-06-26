#ifndef FRACTION_H
#define FRACTION_H

#include <iostream>

class Fraction {
private:
	int64_t numerator, denominator;
	static void simplify(int64_t&, int64_t&);
	static bool toInteger(const std::string&, int64_t&);
	
public:
	Fraction();
	Fraction(const int64_t&);
	Fraction(const int64_t&, const int64_t&);
	Fraction(const Fraction&);
	~Fraction();

	int64_t getNumerator() const;
	int64_t getDenominator() const;
	void set(const int64_t&, const int64_t&);

	static Fraction toFraction(const std::string&);
	static Fraction toFraction(double);
	int64_t toInteger() const;
	double toDouble() const;
	std::string toString() const;

	Fraction operator++();
	Fraction operator++(int);
	Fraction operator--();
	Fraction operator--(int);
	Fraction operator-() const;

	void operator=(const Fraction&);
	void operator+=(const Fraction&);
	void operator-=(const Fraction&);
	void operator*=(Fraction);
	void operator/=(Fraction);

	Fraction operator+(const Fraction&) const;
	Fraction operator-(const Fraction&) const;
	Fraction operator*(const Fraction&) const;
	Fraction operator/(const Fraction&) const;
	
	bool operator<(const Fraction&) const;
	bool operator<=(const Fraction&) const;
	bool operator>(const Fraction&) const;
	bool operator>=(const Fraction&) const;
	bool operator==(const Fraction&) const;
	bool operator!=(const Fraction&) const;
};

std::istream& operator>>(std::istream&, Fraction&);
std::ostream& operator<<(std::ostream&, const Fraction&);

#endif /* FRACTION_H */