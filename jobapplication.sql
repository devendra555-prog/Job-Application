-- ==========================================
-- JOB PORTAL / RECRUITMENT DATABASE
-- ==========================================

-- STEP 1: Create Database

CREATE DATABASE IF NOT EXISTS JobPortalDB;

USE JobPortalDB;


-- ==========================================
-- STEP 2: USERS TABLE
-- ==========================================

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('candidate', 'employer') NOT NULL
);


-- ==========================================
-- STEP 3: JOBLISTINGS TABLE
-- ==========================================

CREATE TABLE JobListings (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    employer_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    salary DECIMAL(12,2),
    location VARCHAR(100),

    CONSTRAINT fk_job_employer
    FOREIGN KEY (employer_id)
    REFERENCES Users(user_id)
);


-- ==========================================
-- STEP 4: APPLICATIONS TABLE
-- ==========================================

CREATE TABLE Applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    user_id INT NOT NULL,

    status ENUM(
        'Applied',
        'Shortlisted',
        'Rejected',
        'Selected'
    ) NOT NULL DEFAULT 'Applied',

    CONSTRAINT fk_application_job
    FOREIGN KEY (job_id)
    REFERENCES JobListings(job_id),

    CONSTRAINT fk_application_user
    FOREIGN KEY (user_id)
    REFERENCES Users(user_id),

    CONSTRAINT unique_job_application
    UNIQUE (job_id, user_id)
);


-- ==========================================
-- STEP 5: MESSAGES TABLE
-- ==========================================

CREATE TABLE Messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    message_text TEXT NOT NULL,

    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_message_sender
    FOREIGN KEY (sender_id)
    REFERENCES Users(user_id),

    CONSTRAINT fk_message_receiver
    FOREIGN KEY (receiver_id)
    REFERENCES Users(user_id)
);


-- ==========================================
-- STEP 6: CHECK TABLES
-- ==========================================

SHOW TABLES;

DESCRIBE Users;
DESCRIBE JobListings;
DESCRIBE Applications;
DESCRIBE Messages;
