# RaceDay — RESTful API

## 1. Project Overview

RaceDay is an ASP.NET Core Web API developed in C# to support the management of running, walking, and cycling events. The API connects to a SQL Server database using Entity Framework Core and provides endpoints for account registration, authentication, profiles, events, categories, enrolments, and results.

The project is developed as part of the RaceDay Programming Project — Part 2: RESTful API Development.

## 2. Technologies Used

- C#
- ASP.NET Core Web API
- .NET 10
- Microsoft SQL Server LocalDB
- Entity Framework Core
- Swagger / OpenAPI
- Git and GitHub
- Visual Studio 2022

## 3. Main Features

### User Authentication
- Register as an Organiser or Participant.
- Log in and log out using session-based authentication.
- Hash passwords before storing them in the database.
- Store the authenticated user's ID and role in the session.

### User Profiles
- Retrieve and update user profile information.

### Event Management
- Retrieve all events.
- Retrieve an event by ID.
- Create an event.
- Update an event.
- Delete an event.

### Category Management
- Retrieve all categories.
- Retrieve a category by ID.
- Create a category.
- Update a category.
- Delete a category when it has no enrolments.

### Enrolment Management
- Retrieve enrolments.
- Retrieve an enrolment by ID.
- Register a participant for a category.
- Check that the participant and category exist.
- Prevent duplicate enrolments through application-level validation.

### Results Management
- Retrieve results.
- Retrieve a result by ID.
- Create a result for an existing enrolment.
- Validate result positions and prevent duplicate results for the same enrolment.

## 4. Database Design

The database uses SQL Server and Entity Framework Core Code-First migrations.

The main database tables are:

1. `USER` — account details and user roles.
2. `PARTICIPANT` — participant profile information.
3. `ORGANISER` — organiser profile information.
4. `EVENT` — event information.
5. `CATEGORY` — event categories, distances, and entry fees.
6. `ENROLMENT` — participant registrations for categories.
7. `RESULT` — finishing times, positions, and result statuses.

Relationships between these tables are configured through primary keys, foreign keys, and Entity Framework Core relationships.

## 5. Prerequisites

Before running the project, install:

- Visual Studio 2022 with the ASP.NET and web development workload.
- The .NET 10 SDK.
- SQL Server LocalDB.
- The required NuGet packages, restored through the solution.

## 6. Configuration

The development database connection is configured in `appsettings.json`.

The current local connection string is:

`Server=(localdb)\\MSSQLLocalDB;Database=RaceDay;Trusted_Connection=True;TrustServerCertificate=True;`

Change the connection string if your SQL Server instance differs.

Do not commit production passwords, API keys, or other secrets to GitHub.

## 7. How to Run the API

1. Clone or download the repository.
2. Open the RaceDay solution in Visual Studio.
3. Restore the NuGet packages.
4. Ensure SQL Server LocalDB is installed and running.
5. Open the Package Manager Console.
6. Select `RaceDay.API` as the default project.
7. Apply database migrations using:

   `Update-Database`

8. Set `RaceDay.API` as the startup project.
9. Run the application using HTTPS.
10. Open the Swagger UI URL displayed by Visual Studio.

Swagger can be used to inspect and test the available API endpoints.

## 8. API Endpoint Summary

| Method | Endpoint | Purpose |
|---|---|---|
| POST | `/api/auth/register` | Register a user |
| POST | `/api/auth/login` | Log in |
| POST | `/api/auth/logout` | Log out |
| GET | `/api/profile` | Retrieve profile |
| PUT | `/api/profile` | Update profile |
| GET | `/api/events` | List events |
| GET | `/api/events/{id}` | Retrieve an event |
| POST | `/api/events` | Create an event |
| PUT | `/api/events/{id}` | Update an event |
| DELETE | `/api/events/{id}` | Delete an event |
| GET | `/api/categories` | List categories |
| GET | `/api/categories/{id}` | Retrieve a category |
| POST | `/api/categories` | Create a category |
| PUT | `/api/categories/{id}` | Update a category |
| DELETE | `/api/categories/{id}` | Delete a category |
| GET | `/api/enrolments` | List enrolments |
| GET | `/api/enrolments/{id}` | Retrieve an enrolment |
| POST | `/api/enrolments` | Create an enrolment |
| GET | `/api/results` | List results |
| GET | `/api/results/{id}` | Retrieve a result |
| POST | `/api/results` | Create a result |

## 9. Testing

The API has been built successfully in Visual Studio. The following manual tests have been performed in Swagger:

- `GET /api/events` returned `200 OK`.
- `POST /api/events` returned `201 Created`.
- The created event appeared in the events list.

Further endpoint testing and automated unit testing should be completed and documented before final submission.

## 10. Security Considerations

The project uses password hashing and session-based login.

The API must enforce role-based access control and verify resource ownership. Organisers should only manage their own events and related records, while participants should only access their own profile, enrolments, and results.

Security testing should confirm that unauthenticated users and users with the wrong role cannot perform restricted actions.

## 11. Continuous Integration

GitHub Actions should be configured to restore dependencies, build the solution, and run automated tests whenever changes are pushed to GitHub or a pull request is opened.

The workflow should report failures so that code issues can be identified before submission.

## 12. Project Status

Core API controllers and database integration have been implemented, and initial event endpoints have been tested successfully.

Remaining work includes completing and verifying role-based security, testing all endpoints, running unit tests, configuring GitHub Actions, and preparing final assessment evidence.

## 13. Author

Student: [NKUNA PHOSHANE LESLEY ST10487072]

Institution: IIE Rosebank College

Project: RaceDay — Part 2: RESTful API Development
