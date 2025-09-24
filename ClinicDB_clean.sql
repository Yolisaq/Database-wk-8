-- ===================================================
-- Clinic Booking System Database (Clean Setup + Sample Data)
-- ===================================================

-- 1. Drop database if it exists
DROP DATABASE IF EXISTS ClinicDB;

-- 2. Create Database
CREATE DATABASE ClinicDB;
USE ClinicDB;

-- 3. Create Tables

-- Patients Table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialty VARCHAR(100),
    phone_number VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR(255),
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- Prescriptions Table
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    duration VARCHAR(50),
    CONSTRAINT fk_appointment FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- Insurance Companies Table
CREATE TABLE InsuranceCompanies (
    insurance_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15)
);

-- PatientInsurance Table
CREATE TABLE PatientInsurance (
    patient_id INT NOT NULL,
    insurance_id INT NOT NULL,
    policy_number VARCHAR(50) UNIQUE,
    PRIMARY KEY (patient_id, insurance_id),
    CONSTRAINT fk_pi_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_pi_insurance FOREIGN KEY (insurance_id) REFERENCES InsuranceCompanies(insurance_id) ON DELETE CASCADE
);

-- 4. Indexes for performance
CREATE INDEX idx_appointment_date ON Appointments(appointment_date);
CREATE INDEX idx_patient_last_name ON Patients(last_name);
CREATE INDEX idx_doctor_last_name ON Doctors(last_name);

-- ===================================================
-- 5. Insert Sample Data
-- ===================================================

-- Patients
INSERT INTO Patients (first_name, last_name, date_of_birth, phone_number, email)
VALUES 
('John', 'Doe', '1985-03-15', '0812345678', 'john.doe@example.com'),
('Jane', 'Smith', '1990-07-22', '0823456789', 'jane.smith@example.com'),
('Alice', 'Brown', '1975-12-05', '0834567890', 'alice.brown@example.com');

-- Doctors
INSERT INTO Doctors (first_name, last_name, specialty, phone_number, email)
VALUES 
('Michael', 'Johnson', 'Cardiology', '0845678901', 'm.johnson@example.com'),
('Sarah', 'Williams', 'Dermatology', '0856789012', 's.williams@example.com'),
('Robert', 'Taylor', 'General Medicine', '0867890123', 'r.taylor@example.com');

-- Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason, status)
VALUES
(1, 1, '2025-09-30 09:00:00', 'Heart check-up', 'Scheduled'),
(2, 2, '2025-09-30 10:30:00', 'Skin rash', 'Scheduled'),
(3, 3, '2025-09-30 11:00:00', 'General consultation', 'Scheduled');

-- Prescriptions
INSERT INTO Prescriptions (appointment_id, medication, dosage, duration)
VALUES
(1, 'Aspirin', '100mg', '30 days'),
(2, 'Hydrocortisone Cream', 'Apply twice daily', '14 days'),
(3, 'Paracetamol', '500mg', '5 days');

-- Insurance Companies
INSERT INTO InsuranceCompanies (name, contact_number)
VALUES
('HealthFirst', '0111234567'),
('MediCover', '0112345678');

-- PatientInsurance
INSERT INTO PatientInsurance (patient_id, insurance_id, policy_number)
VALUES
(1, 1, 'HF-1001'),
(2, 2, 'MC-2001'),
(3, 1, 'HF-1002');

-- ===================================================
-- 6. Test SELECTs
-- ===================================================
SELECT * FROM Patients;
SELECT * FROM Doctors;
SELECT * FROM Appointments;
SELECT * FROM Prescriptions;
SELECT * FROM InsuranceCompanies;
SELECT * FROM PatientInsurance;
