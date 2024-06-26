/*
Giả sử cho thông tin một sinh viên bao gồm các thông tin:

- Mã sinh viên : dạng số nguyên dương, mã sinh viên là giá trị duy nhất để phân biệt
- Họ sinh viên : dạng chuỗi
- Tên sinh viên : dạng chuỗi
- Điểm trung bình học tập : dạng số thực, có miền giá trị từ 0.0 đến 10.0

Hãy thực hiện các yêu cầu sau:

1. Khai báo cấu trúc cây nhị phân tìm kiếm để lưu thông tin sinh viên theo mô tả ở trên.
2. Viết hàm thêm các sinh viên vào cây.
3. Viết hàm xóa các sinh viên có điểm trung bình < 5.0 ra khỏi cây.
4. Viết hàm hiển thị danh sách sinh viên khi duyệt cây theo thứ tự trước.
*/
#include <iostream>
using namespace std;

class Student {
    public:
    int MSSV;
    string Ho;
    string Ten;
    float DTB;
};

class BinarySearchTree {
    public:
    Student *data;
    BinarySearchTree *left, *right;
};

void Insert(BinarySearchTree **root, Student *new_student) {
    if (*root == NULL) {
        *root = new BinarySearchTree;
        (*root)->data = new_student;
        (*root)->left = NULL;
        (*root)->right = NULL;
    }
    else if (new_student->DTB >= (*root)->data->DTB)
        Insert(&((*root)->right), new_student);
    else
        Insert(&((*root)->left), new_student);
}

void DeleteBST(BinarySearchTree **root) {
    if (*root == NULL)
        return;
    DeleteBST(&((*root)->left));
    DeleteBST(&((*root)->right));
    delete (*root)->data;
    *root = NULL;
}

void DeleteBadGrade(BinarySearchTree **root) {
    BinarySearchTree *tmp = *root;
    if (tmp == NULL)
        return;
    if (tmp->data->DTB >= 5.0) {
        while (1) {
            if (tmp == NULL) break;
            if (tmp->data->DTB < 5.0) break;
            tmp = tmp->left;
        }
        DeleteBadGrade(&tmp);
    }
    else {
        *root = (*root)->right;
        tmp->right = NULL;
        DeleteBST(&tmp);
        DeleteBadGrade(root);
    }
}

void Preorder(BinarySearchTree **root) {
    if (*root == NULL)
        return;
    cout << (*root)->data->MSSV << " ";
    Preorder(&((*root)->left));
    Preorder(&((*root)->right));
}

int main() {

    return 0;
}


