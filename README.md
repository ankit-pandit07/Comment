# Nested Comments Tree

A Flutter application that displays a nested comment tree with support for out-of-order comments, replies, live updates, search, and internet connectivity monitoring.

---

## Features

- 🌳 Nested comments tree
- 🔄 Handles out-of-order parent comments
- 📂 Expand / Collapse comments
- 💬 Reply to any comment
- 🔍 Search comments by author or message
- ⚡ Live comment updates (simulated)
- 🌐 Internet connectivity detection
- 🎯 Built using Provider state management

---

## Tech Stack

- Flutter
- Dart
- Provider
- connectivity_plus

---

## Project Structure

```
lib/
│
├── models/
│   └── comment.dart
│
├── providers/
│   ├── comment.dart
│   └── connectivity.dart
│
├── services/
│   └── dummy.dart
│
├── widgets/
│   ├── title.dart
│   └── reply.dart
│
├── screens/
│   └── home_screen.dart
│
└── main.dart
```

---

## How to Run

### Clone the repository

```bash
git clone <repository-url>
```

### Install dependencies

```bash
flutter pub get
```

### Run the project

```bash
flutter run
```

---

## Implemented Requirements

- [x] Nested Comment Tree
- [x] Out-of-order Parent Handling
- [x] Expand / Collapse
- [x] Reply Functionality
- [x] Search
- [x] Live Updates
- [x] Internet Connectivity Monitoring

---

## Assumptions

- Comments are loaded from a dummy service.
- Live updates are simulated using a periodic timer.
- New comments may be root comments or replies.
- Search is case-insensitive.

---

## Packages Used

| Package | Purpose |
|---------|---------|
| provider | State Management |
| connectivity_plus | Internet Connectivity |

---

## Author

**Ankit Pandit**