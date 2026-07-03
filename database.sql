-- Create database if it does not exist
CREATE DATABASE IF NOT EXISTS smart_parking_db;
USE smart_parking_db;

-- Drop existing table to apply updated schema
DROP TABLE IF EXISTS parking_bills;

-- Create parking_bills table with owner details
CREATE TABLE parking_bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_name VARCHAR(100),
    contact_number VARCHAR(20),
    vehicle_number VARCHAR(50) NOT NULL,
    vehicle_type VARCHAR(20) NOT NULL,
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
