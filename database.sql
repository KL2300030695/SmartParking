-- Create database if it does not exist
CREATE DATABASE IF NOT EXISTS smart_parking_db;
USE smart_parking_db;

-- Drop existing tables to apply updated schema
DROP TABLE IF EXISTS parking_bills;
DROP TABLE IF EXISTS parking_slots;

-- ===== Parking Slots Table =====
CREATE TABLE parking_slots (
    slot_id INT AUTO_INCREMENT PRIMARY KEY,
    slot_number VARCHAR(10) NOT NULL UNIQUE,
    floor_level VARCHAR(20) NOT NULL,
    vehicle_type VARCHAR(20) NOT NULL,
    is_occupied BOOLEAN DEFAULT FALSE,
    vehicle_number VARCHAR(50) DEFAULT NULL,
    owner_name VARCHAR(100) DEFAULT NULL,
    occupied_since DATETIME DEFAULT NULL
);

-- ===== Parking Bills Table =====
CREATE TABLE parking_bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_name VARCHAR(100),
    contact_number VARCHAR(20),
    vehicle_number VARCHAR(50) NOT NULL,
    vehicle_type VARCHAR(20) NOT NULL,
    slot_number VARCHAR(10),
    entry_time DATETIME,
    exit_time DATETIME,
    total_duration_minutes BIGINT,
    billable_hours BIGINT,
    grace_applied BOOLEAN,
    hourly_rate DECIMAL(10, 2),
    parking_fee DECIMAL(10, 2),
    lost_ticket BOOLEAN,
    daily_cap_applied BOOLEAN,
    total_amount DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===== Seed Parking Slots =====

-- Ground Floor (G) - 5 Car, 5 Bike, 3 SUV
INSERT INTO parking_slots (slot_number, floor_level, vehicle_type) VALUES
('G-C1', 'Ground Floor', 'Car'), ('G-C2', 'Ground Floor', 'Car'), ('G-C3', 'Ground Floor', 'Car'),
('G-C4', 'Ground Floor', 'Car'), ('G-C5', 'Ground Floor', 'Car'),
('G-B1', 'Ground Floor', 'Bike'), ('G-B2', 'Ground Floor', 'Bike'), ('G-B3', 'Ground Floor', 'Bike'),
('G-B4', 'Ground Floor', 'Bike'), ('G-B5', 'Ground Floor', 'Bike'),
('G-S1', 'Ground Floor', 'SUV'), ('G-S2', 'Ground Floor', 'SUV'), ('G-S3', 'Ground Floor', 'SUV');

-- First Floor (1F) - 5 Car, 5 Bike, 3 SUV
INSERT INTO parking_slots (slot_number, floor_level, vehicle_type) VALUES
('1F-C1', '1st Floor', 'Car'), ('1F-C2', '1st Floor', 'Car'), ('1F-C3', '1st Floor', 'Car'),
('1F-C4', '1st Floor', 'Car'), ('1F-C5', '1st Floor', 'Car'),
('1F-B1', '1st Floor', 'Bike'), ('1F-B2', '1st Floor', 'Bike'), ('1F-B3', '1st Floor', 'Bike'),
('1F-B4', '1st Floor', 'Bike'), ('1F-B5', '1st Floor', 'Bike'),
('1F-S1', '1st Floor', 'SUV'), ('1F-S2', '1st Floor', 'SUV'), ('1F-S3', '1st Floor', 'SUV');

-- Second Floor (2F) - 5 Car, 5 Bike, 3 SUV
INSERT INTO parking_slots (slot_number, floor_level, vehicle_type) VALUES
('2F-C1', '2nd Floor', 'Car'), ('2F-C2', '2nd Floor', 'Car'), ('2F-C3', '2nd Floor', 'Car'),
('2F-C4', '2nd Floor', 'Car'), ('2F-C5', '2nd Floor', 'Car'),
('2F-B1', '2nd Floor', 'Bike'), ('2F-B2', '2nd Floor', 'Bike'), ('2F-B3', '2nd Floor', 'Bike'),
('2F-B4', '2nd Floor', 'Bike'), ('2F-B5', '2nd Floor', 'Bike'),
('2F-S1', '2nd Floor', 'SUV'), ('2F-S2', '2nd Floor', 'SUV'), ('2F-S3', '2nd Floor', 'SUV');
