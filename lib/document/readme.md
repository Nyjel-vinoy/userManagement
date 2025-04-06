1. Overview
   This Flutter project is a fully functional User Management App integrated with the ReqRes API. It supports login, registration, and complete user CRUD operations (Create, Read, Update, Delete). The app uses Provider for state management and Flutter Secure Storage for secure authentication tokens.
2. Login Page
   The Login Page allows users to sign in using their email and password. Upon successful login, the token received from the ReqRes API is stored securely using Flutter Secure Storage. Form validation ensures no empty fields are submitted.
3. Register Page
   The Register Page provides user registration functionality. It collects email and password and sends them to ReqRes for a token. The received token is stored securely. Basic validation is applied.
4. User Management Page
   This is the main screen after login. It shows a list of users fetched from the ReqRes API. Features include:

- Searching users by name or email
- Creating a new user using a modal form
- Updating user information via a dialog
- Deleting users with confirmation dialogs
  All actions show relevant SnackBar feedback.

5. Provider
   Two providers are used:

- AuthProvider: Handles login, logout, and storing/loading tokens.
- UserProvider: Manages fetching, filtering, creating, updating, and deleting users.

6. Secure Storage
   Flutter Secure Storage is used to securely store the authentication token. This token persists between app restarts and is used to auto-login users if valid.
7. Summary
   This app demonstrates a complete user management flow in Flutter using REST APIs, secure storage, state management, form validation, and UI best practices.
