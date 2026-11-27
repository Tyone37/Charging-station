# Hệ thống trạm sạc xe điện

Bản khởi tạo đợt 1 gồm cấu hình MySQL cục bộ và tài liệu làm việc nhóm. Các phần Gateway, giao diện và dịch vụ được thêm qua PR theo [phân công đợt 1](docs/dot-1.md).

## Cấu trúc dự án

```text
apps/
  web-gateway/
services/
  identity/
  operations/
  billing/
  registry/
simulators/
  chargers/
  payment/
tests/
  contract/
  integration/
  end-to-end/
```

- `apps/web-gateway/` chứa Gateway Express và phần giao diện web.
- `services/` chứa Tài khoản và Vận hành (Express), Thu phí và Service Registry (Spring Boot).
- `simulators/` chứa hai nguồn thiết bị sạc mô phỏng A/B và nguồn thanh toán mô phỏng.
- `tests/` chứa kiểm thử hợp đồng API, tích hợp và luồng đặt → sạc → thanh toán.

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
