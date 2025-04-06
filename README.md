# User Management App

A simple yet functional Flutter application for managing users. The app supports authentication (login/signup), CRUD operations (create, read, update, delete) for users, secure storage for tokens, state management using Provider, and API integration with [ReqRes](https://reqres.in/).

---

## 🚀 Features

- User **Signup** and **Login**
- **Token storage** using `flutter_secure_storage`
- **User listing** with avatars
- **Search** users by name/email
- **Create**, **Update**, and **Delete** users
- **Logout** functionality
- State management using `Provider`
- API Integration with ReqRes

---

## 📷 Screenshots

| Login | Register | User List | Create User |
|-------|----------|-----------|-------------|
| ![Login](screenshots/login.png) | ![Register](screenshots/register.png) | ![Users](screenshots/userlist.png) | ![Create](screenshots/create.png) |

---

## 🧱 Tech Stack

- **Flutter**
- **Provider** (State Management)
- **flutter_secure_storage**
- **HTTP** package
- **ReqRes API**

---

## 🛠 Installation

1. **Clone the repo**
   ```bash
   git clone https://github.com/Nyjel-vinoy/userManagement.git
   cd userManagement
2 .**Install dependencies** 
flutter pub get

3. **Run the app** 
flutter run

🗃️ **Project Structure**
lib/
├── main.dart
├── provider/
│   ├── auth_provider.dart
│   └── user_provider.dart
├── screens/
│   ├── login.dart
│   ├── register.dart
│   └── usermanagement.dart
├── services/
│   ├── auth_service.dart
│   └── user_service.dart
└── widgets/
    └── custom_widgets.dart (if any)

🔐 **Authentication**
Authentication uses the ReqRes API (https://reqres.in/api/login & .../register)

Tokens are stored securely using flutter_secure_storage

On app restart, token presence decides if the user is logged in

🧪 **API Used (ReqRes)**
Get Users: GET https://reqres.in/api/users

Create User: POST https://reqres.in/api/users

Update User: PUT https://reqres.in/api/users/{id}

Delete User: DELETE https://reqres.in/api/users/{id}

Login: POST https://reqres.in/api/login

Register: POST https://reqres.in/api/register


