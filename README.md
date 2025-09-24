# 🏥 Clinic Booking System Database

## 📝 Overview

This project provides a **Clinic Booking System Database** for managing **patients**, **doctors**, **appointments**, **prescriptions**, and **insurance information**.  
It includes a **clean setup** script with **sample data** for testing and development.

The database is built using **MySQL** and includes indexes for better performance on common queries. ⚡

---

## 🗂 Database Structure

### 🧑‍🤝‍🧑 Tables

1. **Patients**
   - `patient_id` (PK)
   - `first_name`
   - `last_name`
   - `date_of_birth`
   - `phone_number` (unique)
   - `email` (unique)
   - `created_at` (timestamp)

2. **Doctors**
   - `doctor_id` (PK)
   - `first_name`
   - `last_name`
   - `specialty`
   - `phone_number` (unique)
   - `email` (unique)
   - `created_at` (timestamp)

3. **Appointments**
   - `appointment_id` (PK)
   - `patient_id` (FK → Patients)
   - `doctor_id` (FK → Doctors)
   - `appointment_date`
   - `reason`
   - `status` (Scheduled, Completed, Cancelled) ✅

4. **Prescriptions**
   - `prescription_id` (PK)
   - `appointment_id` (FK → Appointments)
   - `medication`
   - `dosage`
   - `duration`

5. **InsuranceCompanies**
   - `insurance_id` (PK)
   - `name`
   - `contact_number`

6. **PatientInsurance** (many-to-many relation)
   - `patient_id` (FK → Patients)
   - `insurance_id` (FK → InsuranceCompanies)
   - `policy_number` (unique)

### ⚡ Indexes
- `idx_appointment_date` on Appointments(appointment_date)
- `idx_patient_last_name` on Patients(last_name)
- `idx_doctor_last_name` on Doctors(last_name)

---

## ⚙️ Setup Instructions

1. **Create the Database** 🛠️
   
   Run the SQL script `clinic_db_setup.sql` in MySQL Workbench or CLI. The script:
   - Drops existing database `ClinicDB` if it exists ❌
   - Creates a new `ClinicDB` 🆕
   - Creates all necessary tables 📊
   - Adds indexes ⚡
   - Inserts sample data 🧪

   ```sql
   -- Example:
   SOURCE path/to/clinic_db_setup.sql;
