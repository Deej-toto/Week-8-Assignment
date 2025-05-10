-- Clinic Appointment System Database

-- Create the database
CREATE DATABASE ClinicAppointmentSystem;

-- Use the database
USE ClinicAppointmentSystem;

-- Create Departments table
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each department
    department_name VARCHAR(255) NOT NULL UNIQUE    -- Name of the department (unique)
);

-- Create Doctors table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique identifier for each doctor
    name VARCHAR(255) NOT NULL,                   -- Doctor's name (cannot be null)
    specialty VARCHAR(255),                       -- Specialty of the doctor (e.g., Cardiology)
    department_id INT,                            -- Foreign key referencing Departments table
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE SET NULL  -- Links doctor to department
);

-- Create Patients table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique identifier for each patient
    name VARCHAR(255) NOT NULL,                    -- Patient's name (cannot be null)
    email VARCHAR(255) UNIQUE NOT NULL,            -- Patient's email (unique)
    phone_number VARCHAR(15)                      -- Patient's phone number
);

-- Create Appointments table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each appointment
    patient_id INT,                                -- Foreign key referencing Patients table
    doctor_id INT,                                 -- Foreign key referencing Doctors table
    appointment_date DATE NOT NULL,                 -- Date of the appointment
    appointment_time TIME NOT NULL,                 -- Time of the appointment
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,  -- Links appointment to patient
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE    -- Links appointment to doctor
);

-- Insert sample data into Departments table
INSERT INTO Departments (department_name) VALUES 
('Cardiology'),
('Pediatrics'),
('Orthopedics');

-- Insert sample data into Doctors table
INSERT INTO Doctors (name, specialty, department_id) VALUES
('Dr. John Smith', 'Cardiologist', 1),
('Dr. Jane Doe', 'Pediatrician', 2),
('Dr. Sarah White', 'Orthopedic Surgeon', 3);

-- Insert sample data into Patients table
INSERT INTO Patients (name, email, phone_number) VALUES 
('Alice Johnson', 'alice.johnson@example.com', '555-1234'),
('Bob Brown', 'bob.brown@example.com', '555-5678');

-- Insert sample data into Appointments table
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time) VALUES 
(1, 1, '2025-05-12', '09:00:00'),  -- Alice Johnson has an appointment with Dr. John Smith
(2, 2, '2025-05-13', '10:00:00');  -- Bob Brown has an appointment with Dr. Jane Doe

-- Query to view all appointments with patient and doctor names
SELECT p.name AS patient_name, d.name AS doctor_name, a.appointment_date, a.appointment_time
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;
