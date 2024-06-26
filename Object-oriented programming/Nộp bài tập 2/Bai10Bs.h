class DTB2 {
private:
    double a, b, c;
public:
    DTB2();   
    ~DTB2();
    double F(const double&);
    DTB2 operator+ (const DTB2& dtb2) const;
};