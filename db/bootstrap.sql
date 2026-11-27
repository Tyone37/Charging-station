-- Local development only. Service tables belong in their own migrations.
CREATE DATABASE IF NOT EXISTS `identity` CHARACTER SET utf8mb4;
CREATE DATABASE IF NOT EXISTS `operations` CHARACTER SET utf8mb4;
CREATE DATABASE IF NOT EXISTS `billing` CHARACTER SET utf8mb4;

CREATE USER IF NOT EXISTS 'identity_app'@'%' IDENTIFIED BY 'local_identity_only';
CREATE USER IF NOT EXISTS 'operations_app'@'%' IDENTIFIED BY 'local_operations_only';
CREATE USER IF NOT EXISTS 'billing_app'@'%' IDENTIFIED BY 'local_billing_only';

GRANT ALL PRIVILEGES ON `identity`.* TO 'identity_app'@'%';
GRANT ALL PRIVILEGES ON `operations`.* TO 'operations_app'@'%';
GRANT ALL PRIVILEGES ON `billing`.* TO 'billing_app'@'%';
