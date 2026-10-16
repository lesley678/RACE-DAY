RaceDay API — Part 2
Project Overview

RaceDay is a RESTful Web API developed using ASP.NET Core Web API, C#, Entity Framework Core 10 and Microsoft SQL Server. The system supports race event management, participant enrolments, race categories and race results.

Part 2 builds on the initial project by implementing backend functionality for user authentication, session management, profile management, category management, enrolments and results. Access to protected resources is controlled according to the user's role and ownership of the relevant event or enrolment.

Technologies Used
C# and ASP.NET Core Web API
.NET 10
Entity Framework Core 10
Microsoft SQL Server
ASP.NET Core session management
ASP.NET Core Identity password hashing
Swagger / OpenAPI
xUnit for automated testing
Main Features
1. User Authentication
Register accounts as either a Participant or an Organiser.
Validate registration details and role-specific information.
Hash passwords before storing them in the database.
Authenticate users through email and password.
Store the authenticated user's ID and role in a server-side session.
Log out by clearing the current session.
Prevent duplicate email registrations.
2. Profile Management
Retrieve the logged-in user's profile.
Update the user's first and last names.
Validate required fields and name lengths.
Restrict profile access to authenticated users.
3. Category Management
View all race categories.
Retrieve a category by ID.
Allow Organisers to create, update and delete categories for their own events.
Validate category names, distances and entry fees.
Prevent categories from being moved to another event through an update request.
Prevent deletion of categories that have enrolments.
4. Enrolment Management
Allow Participants to enrol in race categories.
Automatically associate new enrolments with the authenticated Participant.
Prevent duplicate enrolments in the same category.
Allow Participants to view their own enrolments.
Allow Organisers to view enrolments associated with their own events.
5. Results Management
Allow Participants to view their own results.
Allow Organisers to view results for their own events.
Allow Organisers to create results for enrolments belonging to their events.
Validate finishing positions and result statuses.
Prevent duplicate results for the same enrolment.
User Roles and Permissions
Feature	Public	Participant	Organiser
View categories	Yes	Yes	Yes
Register and log in	Yes	Yes	Yes
View and update own profile	No	Yes	Yes
Create, update and delete categories	No	No	Own events only
View enrolments	No	Own enrolments	Own events only
Create enrolments	No	Yes	No
View results	No	Own results	Own events only
Create results	No	No	Own events only
API Endpoints

All endpoints use the /api base path.

Authentication
Method	Endpoint	Description
POST	/api/auth/register	Register a new account
POST	/api/auth/login	Log in
POST	/api/auth/logout	Log out
Profile
Method	Endpoint	Description
GET	/api/profile	Retrieve the current user's profile
PUT	/api/profile	Update the current user's first and last names
Categories
Method	Endpoint	Description
GET	/api/categories	Retrieve all categories
GET	/api/categories/{id}	Retrieve a category by ID
POST	/api/categories	Create a category for an owned event
PUT	/api/categories/{id}	Update an existing category
DELETE	/api/categories/{id}	Delete a category if it has no enrolments
Enrolments
Method	Endpoint	Description
GET	/api/enrolments	Retrieve enrolments visible to the current user
GET	/api/enrolments/{id}	Retrieve an individual enrolment
POST	/api/enrolments	Enrol the current Participant in a category
Results
Method	Endpoint	Description
GET	/api/results	Retrieve results visible to the current user
GET	/api/results/{id}	Retrieve an individual result
POST	/api/results	Create a result for an enrolment in the Organiser's event
Database Design

The application uses Entity Framework Core to interact with a Microsoft SQL Server database.

The main entities are:

User — stores account details, password hashes and roles.
Participant — stores participant-specific information.
Organiser — stores organiser and organisation information.
Event — stores race event details and its associated Organiser.
Category — stores event categories, distances and entry fees.
Enrolment — links Participants to Categories.
Result — stores finishing times, positions and result statuses.

The database context is RaceDayContext. Entity relationships, unique indexes and check constraints help maintain data integrity.

Security
Passwords are hashed using ASP.NET Core Identity's PasswordHasher<User>.
Session-based authentication stores the user's ID and role.
The SessionAuthorizeAttribute checks the session against the current user record and verifies the required role.
Organisers can only manage categories and results associated with their own events.
Participants can only access their own enrolments and results.
Session cookies are configured as HTTP-only, essential and secure-only.
Input validation is performed before relevant database operations.
Installation and Setup
Prerequisites

Install the following:

.NET 10 SDK
Microsoft SQL Server
Visual Studio 2026 or another compatible C# development environment
Git
1. Clone the repository
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd <YOUR_REPOSITORY_FOLDER>

2. Configure the database connection

Configure the RaceDayConnection connection string in your local development configuration.

Example appsettings.Development.json:

{
  "ConnectionStrings": {
    "RaceDayConnection": "Server=YOUR_SERVER;Database=RaceDayDB;Trusted_Connection=True;TrustServerCertificate=True;"
  }
}


Replace YOUR_SERVER with your SQL Server instance. Use the appropriate authentication settings for your environment.

Do not commit passwords, production credentials or other secrets to GitHub.

3. Restore dependencies
dotnet restore

4. Create or update the database

If the project contains Entity Framework Core migrations, apply them using:

dotnet ef database update


If migrations have not been created, configure the database schema using the database setup process required by your project before starting the API.

5. Run the API

From the API project directory:

dotnet run


In the Development environment, Swagger UI is enabled for exploring and testing the available endpoints.

Use the HTTPS URL printed in the terminal.

Testing

The project uses xUnit for automated testing.

Run the tests from the solution directory:

dotnet test


If the test project is named RaceDay.API.Tests, run:

dotnet test RaceDay.API.Tests


Unit tests can verify controller behaviour, validation rules and access-control logic. Integration tests using WebApplicationFactory<Program> can additionally verify HTTP routing, session cookies, authorization filters and API responses.

HTTP Responses

The API uses standard HTTP status codes, including:

200 OK — successful retrieval or update.
201 Created — successful creation.
204 No Content — successful update or deletion without a response body.
400 Bad Request — invalid request data.
401 Unauthorized — authentication is required or the session is invalid.
403 Forbidden — the user does not have permission.
404 Not Found — the requested resource does not exist.
409 Conflict — a duplicate operation or restricted deletion.
Project Structure
RaceDay/
├── RaceDay.API/
│   ├── Attributes/
│   │   └── SessionAuthorizeAttribute.cs
│   ├── Controllers/
│   │   ├── AuthController.cs
│   │   ├── ProfileController.cs
│   │   ├── CategoriesController.cs
│   │   ├── EnrolmentsController.cs
│   │   └── ResultsController.cs
│   ├── Data/
│   │   └── RaceDayContext.cs
│   ├── Models/
│   │   ├── User.cs
│   │   ├── Participant.cs
│   │   ├── Organiser.cs
│   │   ├── Event.cs
│   │   ├── Category.cs
│   │   ├── Enrolment.cs
│   │   └── Result.cs
│   ├── Security/
│   │   └── SessionHelper.cs
│   ├── Program.cs
│   └── appsettings.json
└── RaceDay.API.Tests/
    └── Automated tests


The structure above is illustrative; adjust it to match the actual folders and files in the repository.

Conclusion

RaceDay API Part 2 extends the initial project with authenticated user operations, role-based access control, category management, enrolments and race results. Entity Framework Core provides database access, while validation, database constraints and ownership checks help protect the consistency and security of the application's data.
