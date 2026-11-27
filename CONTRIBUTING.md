# Quy ước đóng góp dự án trạm sạc xe điện

## Công nghệ và phạm vi

- Gateway, Tài khoản và Vận hành dùng Express 5 trên Node.js 24. Vận hành gồm trạm/giá, đặt chỗ và phiên sạc trong cùng dịch vụ.
- Thu phí và Service Registry chạy riêng bằng Spring Boot trên Java 21. Worker Express gửi công việc lập phiếu sang Thu phí. Worker Spring Boot xử lý thanh toán mô phỏng đến hạn bằng cùng mã khi thử lại.
- Dịch vụ giao tiếp bằng REST/JSON. MySQL 8.4 dùng ba lược đồ và tài khoản riêng cho Tài khoản, Vận hành và Thu phí. Mỗi dịch vụ quản lý migration của mình.
- Giao diện web responsive gọi qua Gateway. Nhóm chốt công nghệ giao diện cùng PR khung giao diện.
- P1 dùng trạm, trụ, cổng và tài khoản mẫu. Khách đặt và thanh toán dịch vụ sạc mô phỏng. Quản lý cập nhật giá và tra cứu giao dịch. Tạo/sửa trạm, tổng tiền đã thu và đối soát thủ công thuộc P2.

## Nhánh và Pull Request

- `main` giữ bản ổn định để demo. Người phụ trách repo mở PR từ `develop` sang `main` khi bàn giao đợt.
- `develop` là nhánh tích hợp. Tạo một nhánh `feature/...` hoặc `fix/...` cho mỗi việc từ `develop` mới nhất. Sau khi khởi tạo, mọi thay đổi vào `main` và `develop` đi qua PR.
- Commit theo dạng `loại: mô tả`, ví dụ `feat: giu khe sac`. Trước khi commit, chạy kiểm tra liên quan và xem các file đã stage.
- Gắn số Issue nếu có, ghi các bước chạy lại, kết quả thực tế và ảnh nếu đổi giao diện. Báo người dùng API nếu đổi hợp đồng hoặc migration. Không commit `.env`, dữ liệu thật hoặc file build.
- Nhờ ít nhất một người khác rà theo [phân công đợt 1](docs/dot-1.md). Người rà chạy lại ca liên quan. Cập nhật cùng nhánh sau góp ý và ghép khi đã được duyệt, xử lý xong xung đột và kiểm tra đạt.

```sh
git switch develop
git pull --ff-only origin develop
git switch -c feature/giu-khe-sac
# Sau khi sửa, chạy kiểm thử và commit
git fetch origin
git merge origin/develop
git push -u origin feature/giu-khe-sac
```

Mở PR vào `develop`. Khi làm phần Express dùng `npm test` nếu mô-đun đã có lệnh đó. Với Spring Boot dùng Maven Wrapper khi đã được thêm. Khi đổi API, kiểm tra cả phía gọi và phía nhận bằng bộ dữ liệu mẫu.
