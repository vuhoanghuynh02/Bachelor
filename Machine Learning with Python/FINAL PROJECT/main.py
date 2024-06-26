# Import các thư viện cần thiết
import argparse
import sys
import os
import pandas as pd
from joblib import dump, load
from sklearn.preprocessing import LabelEncoder
from xgboost import XGBClassifier


# Hàm để chạy quá trình huấn luyện
def run_train(train_dir, dev_dir, model_dir):
    # Tạo thư mục cho mô hình nếu nó chưa tồn tại
    os.makedirs(model_dir, exist_ok=True)

    # Đường dẫn đến các tệp dữ liệu
    train_file = os.path.join(train_dir, "train.csv")

    # Đọc dữ liệu huấn luyện và phát triển
    train_data = pd.read_csv(train_file)

    # Chuẩn bị dữ liệu cho quá trình huấn luyện
    X_train = train_data.drop("diagnosis", axis=1)
    Y_train = train_data["diagnosis"]

    encoder = LabelEncoder().fit(Y_train)
    Y_train = encoder.transform(Y_train)

    # Tạo và huấn luyện mô hình
    model = XGBClassifier(random_state=20520864)
    model.fit(X_train, Y_train)

    # Lưu mô hình
    model_path = os.path.join(model_dir, "trained_model.joblib")
    encoder_path = os.path.join(model_dir, "encoder.joblib")
    dump(model, model_path)
    dump(encoder, encoder_path)


# Hàm để chạy quá trình dự đoán
def run_predict(model_dir, input_dir, output_path):
    # Đường dẫn đến mô hình và dữ liệu đầu vào
    model_path = os.path.join(model_dir, "trained_model.joblib")
    encoder_path = os.path.join(model_dir, "encoder.joblib")
    input_file = os.path.join(input_dir, "test.csv")

    # Tải mô hình
    model = load(model_path)
    encoder = load(encoder_path)

    # Đọc dữ liệu kiểm tra
    test_data = pd.read_csv(input_file)

    # Chuẩn bị dữ liệu kiểm tra
    X_test = test_data

    # Thực hiện dự đoán
    predictions = model.predict(X_test)
    predictions = encoder.inverse_transform(predictions)

    # Lưu kết quả dự đoán
    pd.DataFrame(predictions, columns=["diagnosis"]).to_json(
        output_path, orient="records", lines=True
    )


# Hàm chính để xử lý lệnh từ dòng lệnh
def main():
    # Tạo một parser cho các lệnh từ dòng lệnh
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command")

    # Tạo parser cho lệnh 'train'
    parser_train = subparsers.add_parser("train")
    parser_train.add_argument("--train_dir", type=str)
    parser_train.add_argument("--dev_dir", type=str)
    parser_train.add_argument("--model_dir", type=str)

    # Tạo parser cho lệnh 'predict'
    parser_predict = subparsers.add_parser("predict")
    parser_predict.add_argument("--model_dir", type=str)
    parser_predict.add_argument("--input_dir", type=str)
    parser_predict.add_argument("--output_path", type=str)

    # Xử lý các đối số nhập vào
    args = parser.parse_args()

    # Chọn hành động dựa trên lệnh
    if args.command == "train":
        run_train(args.train_dir, args.dev_dir, args.model_dir)
    elif args.command == "predict":
        run_predict(args.model_dir, args.input_dir, args.output_path)
    else:
        parser.print_help()
        sys.exit(1)


# Điểm khởi đầu của chương trình
if __name__ == "__main__":
    main()
