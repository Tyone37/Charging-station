# Hệ thống trạm sạc xe điện

Bản khởi tạo đợt 1 gồm cấu hình MySQL cục bộ và tài liệu làm việc nhóm. Các phần Gateway, giao diện và dịch vụ được thêm qua PR theo [phân công đợt 1](docs/dot-1.md).

## Clone và chạy MySQL

```powershell
git clone https://github.com/Tyone37/Charging-station
git switch develop
Copy-Item .env.example .env
docker compose up -d --wait
docker compose ps
```

Mở Docker Desktop trước khi chạy Compose. Cần Node.js 24 và Java 21 cho các phần backend tương ứng khi nhóm thêm mã nguồn. MySQL lắng nghe tại `127.0.0.1:3307` theo mặc định. Nếu trùng cổng, đổi `MYSQL_PORT` trong `.env`.

| Dịch vụ | Lược đồ | Người dùng | Mật khẩu mẫu cục bộ |
| --- | --- | --- | --- |
| Tài khoản | `identity` | `identity_app` | `local_identity_only` |
| Vận hành | `operations` | `operations_app` | `local_operations_only` |
| Thu phí | `billing` | `billing_app` | `local_billing_only` |

MySQL tạo lược đồ và tài khoản khi volume được khởi tạo lần đầu. Các tài khoản trên chỉ dùng cho môi trường phát triển cục bộ. Dừng bằng `docker compose down` để giữ dữ liệu. Mỗi service thêm migration và hướng dẫn chạy vào PR của mình.

Đọc [quy ước đóng góp](CONTRIBUTING.md) trước khi mở PR.

## CI/CD trên GitHub Actions

| Khi nào | Kết quả |
| --- | --- |
| PR vào `develop` hoặc `main`, hoặc push lên hai nhánh này | Job **Verify** khởi tạo MySQL 8.4, thử kết nối bằng ba tài khoản dịch vụ, rồi kiểm thử và build những dự án Node/Maven đã thêm. |
| Push lên `main` và **Verify** đạt | Job **Package source** đóng gói đúng commit thành `.tar.gz` kèm checksum SHA-256. Tải bản bàn giao trong **Actions → CI and delivery → Artifacts** trong vòng 30 ngày. |

Đợt 1 bàn giao qua artifact GitHub Actions. Nhóm tải bản này để chạy demo trên máy của mình. Khi repo mới có cấu hình, mục Summary ghi rõ phạm vi kiểm tra là MySQL.

Khi thêm mô-đun độc lập, đưa `package-lock.json` và lệnh `npm test` vào mỗi dự án Node. CI dùng Node 24, chạy `npm ci`, `npm test` và build nếu có script `build`. Với mỗi dự án Maven, commit Maven Wrapper (`mvnw`, `mvnw.cmd` và `.mvn/wrapper/`) để CI chạy `verify` trên Java 21. Dùng tài khoản mẫu trong bảng trên nếu kiểm thử cần MySQL.

Người rà PR kiểm tra **Verify** đã đạt trước khi ghép. Nếu CI thất bại, mở bước lỗi trong tab **Checks** để xem log rồi push bản sửa lên cùng nhánh.
