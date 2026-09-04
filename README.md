# RACE-DAY
RaceDay System
1. Project Description

RaceDay is a web-based race and event management system designed to manage running events, participants, organisers, event categories, enrolments and race results.

The system is designed around two main user roles:

Participant – can register, log in, view available events and categories, enrol in race categories, view enrolments and view results.
Organiser – can register, log in, manage events and categories, view participant enrolments and record or update race results.

The project is being developed progressively, beginning with system planning and database design before the development of the REST API and application functionality.

2. Project Objectives

The main objectives of the RaceDay system are to:

Provide a structured system for managing race events.
Allow participants to register and enrol in race categories.
Allow organisers to create and manage events.
Manage different race categories and entry fees.
Store participant enrolments.
Record and manage race results.
Apply role-based access to system functionality.
Use a relational SQL Server database with appropriate primary and foreign keys.
Provide a planned REST API for future application development.
3. User Roles
Participant

Participants can:

Register for an account.
Log into the system.
Manage their profile.
View available events.
View event categories.
Enrol in a category.
View their enrolments.
Cancel their own enrolments.
View their race results.
Organiser

Organisers can:

Register for an account.
Log into the system.
Manage their profile.
Create events.
Update events.
Delete events.
Create and manage event categories.
View participant enrolments.
Record race results.
Update race results.
4. Database Design

The RaceDay database is implemented using Microsoft SQL Server.

The database contains the following main tables:

USER – stores user account and role information.
PARTICIPANT – stores participant-specific information.
ORGANISER – stores organiser-specific information.
EVENT – stores race event information.
CATEGORY – stores categories belonging to events.
ENROLMENT – stores participant enrolments.
RESULT – stores race results.

The database uses:

Primary keys
Foreign keys
NOT NULL constraints
UNIQUE constraints
CHECK constraints
DEFAULT values
Referential integrity

The ENROLMENT table resolves the many-to-many relationship between participants and event categories.

5. Project Structure
RaceDay
│
├── docs
│   ├── ERD.png
│   ├── API-Endpoint-Plan.pdf
│   └── RaceDay-Database.sql
│
├── .github
│   └── workflows
│       └── ...
│
└── README.md

The /docs folder contains the planning documentation required for Part 1.

6. Part 1 Documentation

The following planning documents are included in the /docs folder:

ERD

The Entity Relationship Diagram shows the database entities, attributes, primary keys, foreign keys and relationships between the tables.

API Endpoint Plan

The API plan documents the REST API endpoints that will be implemented during the development stage.

The plan includes:

Authentication
User Profile
Events
Categories
Event Enrolments
Results

Each endpoint specifies the HTTP method, route, description, required role, request body and expected response.

SQL Database Script

The SQL script creates the RaceDay database and its tables, constraints and sample seed data.

The seed data includes:

2 Organisers
3 Participants
3 Events
4 Event Categories
4 Enrolments
4 Results
7. Sample Users

The database contains the following sample users:

Email	Role	Name
organiser1@raceday.com	Organiser	John Organiser
organiser2@raceday.com	Organiser	Sarah Events
participant1@raceday.com	Participant	Tom Runner
participant2@raceday.com	Participant	Lisa Walker
participant3@raceday.com	Participant	Mike Cyclist
8. Sample Events

The database contains three sample events:

Limpopo Marathon
Spring Fun Run
Mountain Challenge

Each event has associated race categories with distances and entry fees.

9. Technologies Used
Microsoft SQL Server – database management
SQL Server Management Studio (SSMS) – database development and testing
Draw.io – ERD design
Microsoft Word / PDF – documentation
Git – version control
GitHub – source-code repository and project documentation
GitHub Actions – continuous integration
REST API – planned application interface
10. Testing

The database was tested in SQL Server Management Studio.

Testing included:

Creating the RaceDay database.
Creating all required tables.
Checking that all seven tables exist.
Inserting seed data.
Checking the number of records in each table.
Testing relationships through foreign keys.
Verifying that the database contains the required organisers, participants, events, categories, enrolments and results.

Screenshots of the SQL execution and results are retained as evidence for the project.

11. CI/CD

GitHub Actions is used to validate the project repository.

The workflow checks that the required project structure and documentation are present.

A successful GitHub Actions build is represented by the green build/check shown in the repository.

CI/CD Screenshot:

Add your screenshot of the successful green GitHub Actions build here.

12. GitHub Repository

Repository:

Add your GitHub repository link here.

13. YouTube Demonstration

An unlisted YouTube video is required to demonstrate the Part 1 planning and database work.

The video will demonstrate:

The RaceDay project structure.
The ERD and database design decisions.
The API endpoint plan.
The SQL database design.
Running the SQL script in SSMS.
The resulting tables and seed data.
Verification of the database.

YouTube Video:

Add your unlisted YouTube video link here.

14. Future Development

Part 2 will build upon the planning completed in Part 1.

The planned development will include:

REST API implementation.
Authentication.
Role-based authorisation.
Event management.
Category management.
Participant enrolment.
Results management.
Database integration.
API testing.
15. Conclusion

The RaceDay project provides a structured foundation for a race and event management system. Part 1 establishes the database design, entity relationships, API requirements and project documentation before application development begins.

The ERD, API endpoint plan and SQL database script provide the foundation required for the next stage of development.
