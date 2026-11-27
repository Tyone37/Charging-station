# Phân công triển khai đợt 1

| Thành viên | Việc bắt đầu và đầu ra | Người rà |
| --- | --- | --- |
| Nguyễn Thanh Tú | Dựng Gateway và Tài khoản bằng Express, tài khoản mẫu, đăng nhập/đăng xuất và phân quyền. Chốt khung giao diện, ghép Gateway với Registry và điều phối tích hợp. | Minh Toàn rà quyền và luồng xuyên dịch vụ. |
| Nguyễn Thành Toàn | Tạo dữ liệu trạm, trụ và cổng. Làm tìm trạm, xem cổng, cập nhật giá và nhật ký. Làm nguồn thiết bị mô phỏng B theo hợp đồng chung. | Tín rà chốt giá và hợp đồng thiết bị. |
| Hồ Thế Nguyên | Làm giữ khe, chống trùng, hủy, hết hạn và lịch sử đặt. Bàn giao kiểm tra quyền sử dụng lượt đặt cho phiên sạc. | Tín rà giao tiếp đặt chỗ với phiên. |
| Võ Trọng Tín | Làm phiên sạc, thiết bị mô phỏng A và outbox lập phiếu. Dựng Service Registry Spring Boot với đăng ký, gia hạn, tra cứu và dọn đăng ký hết hạn. | Nguyên rà giữ cổng, Tú rà Registry. |
| Nguyễn Minh Toàn | Dựng Thu phí Spring Boot, tạo phiếu theo mã phiên, worker thanh toán định kỳ, màn hình thanh toán và tra cứu quản lý. | Tín rà giao việc lập phiếu, Tú rà tra cứu. |

## Thứ tự ghép

1. Chốt tên dịch vụ, dữ liệu mẫu, các trạng thái và API. Thành Toàn, Nguyên và Tín chốt migration Vận hành. Tú và Tín chốt đăng ký và tra cứu dịch vụ. Tín và Minh Toàn chốt `SessionFinalized.v1` và mã chống lặp. Mỗi người có thể code theo hợp đồng với dữ liệu thử trong lúc chờ phần phụ thuộc.
2. Ghép đăng nhập, tìm trạm/xem cổng và cập nhật giá trước. Sau đó ghép giữ khe, phiên sạc và bàn giao cổng với hai nguồn mô phỏng.
3. Ghép lập phiếu, thanh toán mô phỏng và tra cứu quản lý trên cùng giao dịch. Chạy lại CR-01 đến CR-08 theo bản phân công chính trước PR bàn giao. Giữ các ca đặt trùng, phản hồi muộn và gửi lặp thanh toán. Ghi commit, dữ liệu thử, kết quả thực tế và mã giao dịch khi có.

Mỗi người tách việc thành PR nhỏ. Ghi rõ PR hoặc hợp đồng mình đang chờ. Tú điều phối ghép trên `develop` và chuẩn bị PR sang `main` khi bản tích hợp chạy được từ một lượt clone mới.
