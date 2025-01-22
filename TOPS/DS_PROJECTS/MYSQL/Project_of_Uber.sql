CREATE DATABASE UBER;

USE UBER;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    role ENUM('passenger', 'driver') NOT NULL, 
    password varchar(255)NOT NULL, 
    status ENUM('active', 'inactive') DEFAULT 'active', 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL, 
    make VARCHAR(50),
    model VARCHAR(50),
    license_plate VARCHAR(20) UNIQUE,
    year INT,
    color VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
CREATE TABLE trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT NOT NULL,
    driver_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    start_location VARCHAR(255),
    end_location VARCHAR(255),
    start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_time TIMESTAMP,
    status ENUM('pending', 'in_progress', 'completed', 'cancelled') NOT NULL, 
    fare DECIMAL(10, 2),
	passenger_rating INT DEFAULT NULL,
    driver_rating INT DEFAULT NULL, 
    passenger_feedback TEXT DEFAULT NULL,
    driver_feedback TEXT DEFAULT NULL,
    FOREIGN KEY (passenger_id) REFERENCES users(user_id),
    FOREIGN KEY (driver_id) REFERENCES users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('pending', 'completed', 'failed') NOT NULL, 
    payment_method ENUM('cash', 'credit_card', 'debit_card') NOT NULL, 
    payment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id)
);

INSERT INTO users (name, email, phone_number, role, password, status)
VALUES 
('Amit Patel', 'amit.patel@gujaratmail.com', '9876543210', 'passenger', 'amit123', 'active'),
('Neha Desai', 'neha.desai@gujaratmail.com', '8765432109', 'driver', 'neha456', 'active'),
('Rajesh Kumar', 'rajesh.kumar@gujaratmail.com', '7654321098', 'passenger', 'rajesh789', 'active'),
('Priya Mehta', 'priya.mehta@gujaratmail.com', '6543210987', 'driver', 'priya101', 'inactive'),
('Ravi Shah', 'ravi.shah@gujaratmail.com', '5432109876', 'passenger', 'ravi202', 'active'),
('Sita Yadav', 'sita.yadav@gujaratmail.com', '4321098765', 'driver', 'sita303', 'active'),
('Manish Singh', 'manish.singh@gujaratmail.com', '3210987654', 'passenger', 'manish404', 'active'),
('Kajal Sharma', 'kajal.sharma@gujaratmail.com', '2109876543', 'driver', 'kajal505', 'active'),
('Gaurav Joshi', 'gaurav.joshi@gujaratmail.com', '1098765432', 'passenger', 'gaurav606', 'inactive'),
('Rina Shah', 'rina.shah@gujaratmail.com', '9988776655', 'driver', 'rina707', 'active'),
('Rajiv Patel', 'rajiv.patel@gujaratmail.com', '8877665544', 'passenger', 'rajiv808', 'active'),
('Sunil Desai', 'sunil.desai@gujaratmail.com', '7766554433', 'driver', 'sunil909', 'inactive'),
('Nisha Mehta', 'nisha.mehta@gujaratmail.com', '6655443322', 'passenger', 'nisha010', 'active'),
('Vipul Bhatt', 'vipul.bhatt@gujaratmail.com', '5544332211', 'driver', 'vipul121', 'active'),
('Jayshree Yadav', 'jayshree.yadav@gujaratmail.com', '4433221100', 'passenger', 'jayshree232', 'inactive'),
('Vikram Patil', 'vikram.patil@gujaratmail.com', '3322110099', 'driver', 'vikram343', 'active'),
('Pooja Shah', 'pooja.shah@gujaratmail.com', '2211009988', 'passenger', 'pooja454', 'active'),
('Ketan Joshi', 'ketan.joshi@gujaratmail.com', '1100998877', 'driver', 'ketan565', 'active'),
('Shivani Patel', 'shivani.patel@gujaratmail.com', '9988776654', 'passenger', 'shivani676', 'inactive'),
('Aakash Joshi', 'aakash.joshi@gujaratmail.com', '8857665544', 'driver', 'aakash787', 'active');

INSERT INTO vehicles (user_id, make, model, license_plate, year, color)
VALUES
(2, 'Maruti Suzuki', 'Swift', 'GJ01AB1234', 2020, 'White'),
(4, 'Honda', 'City', 'GJ02CD5678', 2021, 'Black'),
(6, 'Toyota', 'Innova', 'GJ03EF9012', 2019, 'Silver'),
(8, 'Ford', 'EcoSport', 'GJ04GH3456', 2020, 'Blue'),
(10, 'Hyundai', 'Creta', 'GJ05IJ7890', 2021, 'Red'),
(12, 'Mahindra', 'XUV700', 'GJ06KL2345', 2021, 'White'),
(14, 'Tata', 'Harrier', 'GJ07MN6789', 2020, 'Yellow'),
(16, 'Renault', 'Duster', 'GJ08OP1234', 2018, 'Black'),
(18, 'Skoda', 'Octavia', 'GJ09QR4567', 2021, 'Grey'),
(20, 'Nissan', 'Kicks', 'GJ10ST8910', 2021, 'Blue');


INSERT INTO trips (passenger_id, driver_id, vehicle_id, start_location, end_location, status, fare)
VALUES
(1, 2, 1, 'Prahlad Nagar', 'C G Road', 'completed', 350.00),
(3, 4, 2, 'Ellis Bridge', 'Vastrapur Lake', 'pending', 500.00),
(5, 6, 3, 'Satellite', 'Sardar Vallabhbhai Patel Statue', 'completed', 450.00),
(7, 8, 4, 'Navrangpura', 'Maninagar', 'completed', 400.00),
(9, 10, 5, 'Bopal', 'Ambli', 'completed', 380.00),
(11, 12, 6, 'SG Highway', 'Paldi', 'completed', 600.00),
(13, 14, 7, 'Vasna', 'Nehru Bridge', 'completed', 550.00),
(15, 16, 8, 'Khodiyar Nagar', 'Chandkheda', 'completed', 470.00),
(17, 18, 9, 'Ambawadi', 'Kankaria Lake', 'completed', 450.00),
(19, 20, 10, 'Ashram Road', 'Sector 21', 'completed', 530.00);

INSERT INTO payments (trip_id, amount, payment_status, payment_method, payment_time)
VALUES
(1, 350.00, 'completed', 'credit_card', '2025-01-02 09:30:00'),
(2, 500.00, 'pending', 'debit_card', '2025-01-02 10:00:00'),
(3, 450.00, 'completed', 'cash', '2025-01-02 11:15:00'),
(4, 400.00, 'completed', 'credit_card', '2025-01-02 12:00:00'),
(5, 380.00, 'completed', 'debit_card', '2025-01-02 12:45:00'),
(6, 600.00, 'completed', 'credit_card', '2025-01-02 13:30:00'),
(7, 550.00, 'completed', 'cash', '2025-01-02 14:00:00'),
(8, 470.00, 'completed', 'credit_card', '2025-01-02 14:30:00'),
(9, 450.00, 'completed', 'debit_card', '2025-01-02 15:00:00'),
(10, 530.00, 'completed', 'cash', '2025-01-02 15:45:00')
;

-- 1. Find available drivers where status = 'active'
SELECT user_id, name, phone_number
FROM users
WHERE role = 'driver' AND status = 'active'
ORDER BY RAND() LIMIT 1;

-- 2. Insert a new trip for the passenger
INSERT INTO trips (passenger_id, driver_id, vehicle_id, start_location, end_location, status)
VALUES (1, 2, 1, 'Ahmedabad', 'Gandhinagar', 'pending');

-- 3. Start the ride and change the status to 'in_progress'
UPDATE trips
SET status = 'in_progress', start_time = CURRENT_TIMESTAMP
WHERE trip_id = 1;

-- 4. Complete the ride and change the status to 'completed'
UPDATE trips
SET status = 'completed', end_time = CURRENT_TIMESTAMP, fare = 25.50 
WHERE trip_id = 1;

-- 5. Passenger rates the driver
UPDATE trips
SET passenger_rating = 5, passenger_feedback = 'Great driver!'
WHERE trip_id = 1;

-- 6. Driver rates the passenger
UPDATE trips
SET driver_rating = 4, driver_feedback = 'Good passenger!'
WHERE trip_id = 1;

-- 7. Insert payment details once the trip is completed
INSERT INTO payments (trip_id, amount, payment_status, payment_method)
VALUES (1, 25.50, 'completed', 'credit_card');

-- 8. View the ride history for a passenger
SELECT trip_id, start_location, end_location, start_time, end_time, fare, driver_rating, driver_feedback
FROM trips
WHERE passenger_id = 1 AND status = 'completed'
ORDER BY start_time DESC;

-- 9. View the ride history for a driver
SELECT trip_id, start_location, end_location, start_time, end_time, fare, passenger_rating, passenger_feedback
FROM trips
WHERE driver_id = 2 AND status = 'completed'
ORDER BY start_time DESC;

-- 10. Cancel the trip
UPDATE trips
SET status = 'cancelled'
WHERE trip_id = 1;
