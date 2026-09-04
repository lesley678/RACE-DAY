/* =========================================================
   RaceDay System - Part 1 Database Script
   ========================================================= */

/* 1. Create Database */
IF DB_ID('RaceDay') IS NULL
BEGIN
    CREATE DATABASE RaceDay;
END
GO

USE RaceDay;
GO


/* 2. Create USER table */
CREATE TABLE [USER]
(
    USER_ID INT IDENTITY(1,1) PRIMARY KEY,
    FIRSTNAME NVARCHAR(50) NOT NULL,
    LASTNAME NVARCHAR(50) NOT NULL,
    EMAIL NVARCHAR(100) NOT NULL UNIQUE,
    PASSWORD_HASH NVARCHAR(255) NOT NULL,
    ROLE NVARCHAR(20) NOT NULL,
    CREATED_AT DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT CK_USER_ROLE
        CHECK (ROLE IN ('Participant', 'Organiser'))
);
GO


/* 3. Create PARTICIPANT table */
CREATE TABLE PARTICIPANT
(
    PARTICIPANT_ID INT IDENTITY(1,1) PRIMARY KEY,
    USER_ID INT NOT NULL,
    DATE_OF_BIRTH DATE NOT NULL,
    GENDER NVARCHAR(20) NOT NULL,
    EMERGENCY_CONTACT NVARCHAR(100) NOT NULL,

    CONSTRAINT FK_PARTICIPANT_USER
        FOREIGN KEY (USER_ID)
        REFERENCES [USER](USER_ID),

    CONSTRAINT UQ_PARTICIPANT_USER
        UNIQUE (USER_ID)
);
GO


/* 4. Create ORGANISER table */
CREATE TABLE ORGANISER
(
    ORGANISER_ID INT IDENTITY(1,1) PRIMARY KEY,
    USER_ID INT NOT NULL,
    ORGANISATION_NAME NVARCHAR(100) NOT NULL,
    CONTACT_NUMBER NVARCHAR(20) NOT NULL,

    CONSTRAINT FK_ORGANISER_USER
        FOREIGN KEY (USER_ID)
        REFERENCES [USER](USER_ID),

    CONSTRAINT UQ_ORGANISER_USER
        UNIQUE (USER_ID)
);
GO


/* 5. Create EVENT table */
CREATE TABLE EVENT
(
    EVENT_ID INT IDENTITY(1,1) PRIMARY KEY,
    ORGANISER_ID INT NOT NULL,
    EVENT_NAME NVARCHAR(100) NOT NULL,
    DESCRIPTION NVARCHAR(500) NOT NULL,
    EVENT_DATE DATE NOT NULL,
    LOCATION NVARCHAR(150) NOT NULL,
    STATUS NVARCHAR(20) NOT NULL DEFAULT 'Upcoming',

    CONSTRAINT FK_EVENT_ORGANISER
        FOREIGN KEY (ORGANISER_ID)
        REFERENCES ORGANISER(ORGANISER_ID),

    CONSTRAINT CK_EVENT_STATUS
        CHECK (STATUS IN ('Upcoming', 'Open', 'Completed', 'Cancelled'))
);
GO


/* 6. Create CATEGORY table */
CREATE TABLE CATEGORY
(
    CATEGORY_ID INT IDENTITY(1,1) PRIMARY KEY,
    EVENT_ID INT NOT NULL,
    CATEGORY_NAME NVARCHAR(100) NOT NULL,
    DISTANCE DECIMAL(6,2) NOT NULL,
    ENTRY_FEE DECIMAL(10,2) NOT NULL DEFAULT 0.00,

    CONSTRAINT FK_CATEGORY_EVENT
        FOREIGN KEY (EVENT_ID)
        REFERENCES EVENT(EVENT_ID),

    CONSTRAINT CK_CATEGORY_DISTANCE
        CHECK (DISTANCE > 0),

    CONSTRAINT CK_CATEGORY_ENTRY_FEE
        CHECK (ENTRY_FEE >= 0)
);
GO


/* 7. Create ENROLMENT table */
CREATE TABLE ENROLMENT
(
    ENROLMENT_ID INT IDENTITY(1,1) PRIMARY KEY,
    PARTICIPANT_ID INT NOT NULL,
    CATEGORY_ID INT NOT NULL,
    ENROLMENT_DATE DATETIME2 NOT NULL DEFAULT GETDATE(),
    STATUS NVARCHAR(20) NOT NULL DEFAULT 'Active',

    CONSTRAINT FK_ENROLMENT_PARTICIPANT
        FOREIGN KEY (PARTICIPANT_ID)
        REFERENCES PARTICIPANT(PARTICIPANT_ID),

    CONSTRAINT FK_ENROLMENT_CATEGORY
        FOREIGN KEY (CATEGORY_ID)
        REFERENCES CATEGORY(CATEGORY_ID),

    CONSTRAINT UQ_ENROLMENT_PARTICIPANT_CATEGORY
        UNIQUE (PARTICIPANT_ID, CATEGORY_ID),

    CONSTRAINT CK_ENROLMENT_STATUS
        CHECK (STATUS IN ('Active', 'Cancelled', 'Completed'))
);
GO


/* 8. Create RESULT table */
CREATE TABLE RESULT
(
    RESULT_ID INT IDENTITY(1,1) PRIMARY KEY,
    ENROLMENT_ID INT NOT NULL,
    FINISH_TIME TIME NULL,
    POSITION INT NULL,
    RESULT_STATUS NVARCHAR(20) NOT NULL DEFAULT 'Pending',

    CONSTRAINT FK_RESULT_ENROLMENT
        FOREIGN KEY (ENROLMENT_ID)
        REFERENCES ENROLMENT(ENROLMENT_ID),

    CONSTRAINT UQ_RESULT_ENROLMENT
        UNIQUE (ENROLMENT_ID),

    CONSTRAINT CK_RESULT_POSITION
        CHECK (POSITION IS NULL OR POSITION > 0),

    CONSTRAINT CK_RESULT_STATUS
        CHECK (RESULT_STATUS IN
        ('Pending', 'Finished', 'Did Not Finish', 'Disqualified'))
);
GO


/* =========================================================
   SEED DATA
   ========================================================= */

/* 9. Insert Users */
INSERT INTO [USER]
    (FIRSTNAME, LASTNAME, EMAIL, PASSWORD_HASH, ROLE)
VALUES
    ('Thabo', 'Mokoena', 'thabo@raceday.co.za', 'DemoHash123!', 'Organiser'),
    ('Lerato', 'Molefe', 'lerato@raceday.co.za', 'DemoHash456!', 'Organiser'),
    ('Peter', 'Nkosi', 'peter@raceday.co.za', 'DemoHash789!', 'Participant'),
    ('Naledi', 'Maseko', 'naledi@raceday.co.za', 'DemoHash321!', 'Participant');
GO


/* 10. Insert Participants */
INSERT INTO PARTICIPANT
    (USER_ID, DATE_OF_BIRTH, GENDER, EMERGENCY_CONTACT)
VALUES
    (3, '2001-05-14', 'Male', '0821234567'),
    (4, '2002-09-22', 'Female', '0839876543');
GO


/* 11. Insert Organisers */
INSERT INTO ORGANISER
    (USER_ID, ORGANISATION_NAME, CONTACT_NUMBER)
VALUES
    (1, 'RaceDay Events', '0712345678'),
    (2, 'Limpopo Running Club', '0723456789');
GO


/* 12. Insert Events */
INSERT INTO EVENT
    (ORGANISER_ID, EVENT_NAME, DESCRIPTION, EVENT_DATE, LOCATION, STATUS)
VALUES
    (1, 'Limpopo Marathon', 'Annual marathon event',
     '2026-11-15', 'Polokwane', 'Open'),

    (1, 'Spring Fun Run', 'Community 5km fun run',
     '2026-10-10', 'Mokopane', 'Open'),

    (2, 'Mountain Challenge', 'Trail running competition',
     '2026-12-05', 'Magoebaskloof', 'Upcoming');
GO


/* 13. Insert Categories */
INSERT INTO CATEGORY
    (EVENT_ID, CATEGORY_NAME, DISTANCE, ENTRY_FEE)
VALUES
    (1, 'Full Marathon', 42.20, 350.00),
    (1, 'Half Marathon', 21.10, 250.00),
    (2, 'Fun Run', 5.00, 100.00),
    (3, 'Trail Challenge', 15.00, 200.00);
GO


/* 14. Insert Enrolments */
INSERT INTO ENROLMENT
    (PARTICIPANT_ID, CATEGORY_ID, STATUS)
VALUES
    (1, 1, 'Active'),
    (1, 3, 'Active'),
    (2, 2, 'Active'),
    (2, 4, 'Active');
GO


/* 15. Insert Results */
INSERT INTO RESULT
    (ENROLMENT_ID, FINISH_TIME, POSITION, RESULT_STATUS)
VALUES
    (1, '03:45:20', 12, 'Finished'),
    (2, '00:28:15', 5, 'Finished'),
    (3, '01:58:40', 8, 'Finished'),
    (4, NULL, NULL, 'Pending');
GO


/* =========================================================
   VERIFICATION
   ========================================================= */

/* Check all tables */
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO


/* Check record counts */
SELECT 'Users' AS TABLE_NAME, COUNT(*) AS RECORD_COUNT
FROM [USER]

UNION ALL

SELECT 'Participants', COUNT(*)
FROM PARTICIPANT

UNION ALL

SELECT 'Organisers', COUNT(*)
FROM ORGANISER

UNION ALL

SELECT 'Events', COUNT(*)
FROM EVENT

UNION ALL

SELECT 'Categories', COUNT(*)
FROM CATEGORY

UNION ALL

SELECT 'Enrolments', COUNT(*)
FROM ENROLMENT

UNION ALL

SELECT 'Results', COUNT(*)
FROM RESULT;
GO