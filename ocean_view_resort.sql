-- Create Database
CREATE DATABASE IF NOT EXISTS ocean_view_resort;
USE ocean_view_resort;

-- Users Table (Admin and Staff)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('ADMIN', 'STAFF') NOT NULL,
    profile_image VARCHAR(255) DEFAULT 'default_profile.png',
    email VARCHAR(120),
    phone_number VARCHAR(25),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Guest Table
CREATE TABLE IF NOT EXISTS guests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    contact_number VARCHAR(20) NOT NULL,
    nic VARCHAR(25),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Room Types Table
CREATE TABLE IF NOT EXISTS room_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    rate_per_night DECIMAL(10, 2) NOT NULL
);

-- Rooms Table
CREATE TABLE IF NOT EXISTS rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type_id INT,
    status ENUM('AVAILABLE', 'OCCUPIED', 'CLEANING', 'MAINTENANCE') DEFAULT 'AVAILABLE',
    FOREIGN KEY (room_type_id) REFERENCES room_types(id)
);

-- Reservations Table
CREATE TABLE IF NOT EXISTS reservations (
    reservation_number VARCHAR(20) PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_cost DECIMAL(10, 2),
    status ENUM('BOOKED', 'CHECKED_IN', 'CHECKED_OUT', 'CANCELLED') DEFAULT 'BOOKED',
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guest_id) REFERENCES guests(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- Payments Table
CREATE TABLE IF NOT EXISTS payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_number VARCHAR(20),
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50),
    FOREIGN KEY (reservation_number) REFERENCES reservations(reservation_number)
);

-- Initial Data (INSERT IGNORE so re-running script is safe)
INSERT IGNORE INTO users (username, password, full_name, role, email, phone_number) VALUES 
('admin', 'admin123', 'Project Administrator', 'ADMIN', 'admin@oceanview.com', '+94 11 000 0000'),
('staff1', 'staff123', 'John Doe (Staff)', 'STAFF', 'staff1@oceanview.com', '+94 11 000 0001');

INSERT INTO room_types (type_name, rate_per_night) VALUES 
('Single', 5000.00),
('Double', 8000.00),
('Suite', 15000.00);

INSERT INTO rooms (room_number, room_type_id) VALUES 
('101', 1), ('102', 1),
('201', 2), ('202', 2),
('301', 3);
