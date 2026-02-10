# MobileMech App Blueprint

## Overview

A Flutter application that connects vehicle owners with mobile mechanics for on-demand roadside assistance.

## Project Structure (Feature-first)

```
lib/
├── src/
│   ├── auth/
│   │   ├── data/
│   │   │   └── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       └── widgets/
│   ├── core/
│   │   ├── services/
│   │   ├── utils/
│   │   └── widgets/
│   ├── jobs/
│   │   ├── data/
│   │   │   └── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       └── widgets/
│   ├── map/
│   │   ├── data/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       └── widgets/
│   ├── user/
│   │   ├── data/
│   │   │   └── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       └── widgets/
│   └── main.dart
└── pubspec.yaml
```

## MVP Plan

### 1. Project Setup
- Create the Flutter project.
- Set up the folder structure.
- Add necessary dependencies to `pubspec.yaml` (e.g., `firebase_auth`, `cloud_firestore`, `google_maps_flutter`, `provider`).

### 2. Authentication
- Implement email/password authentication.
- Create user roles (`vehicle_owner`, `mechanic`).
- Implement role-based access control.

### 3. Vehicle Owner Flow
- Implement location sharing.
- Create the "request a mechanic" form.
- Implement mechanic tracking on the map.
- Implement job completion and rating.

### 4. Mobile Mechanic Flow
- Implement availability status (Online/Offline).
- Implement real-time location sharing.
- Implement job request notifications.
- Implement job acceptance/rejection.
- Implement navigation to the user's location.
- Implement job completion.

### 5. Admin Flow
- Create a simple admin dashboard (can be a hidden screen in the app for the MVP).
- Display lists of users and mechanics.
- Implement mechanic approval/deactivation.
- Display all job requests and their statuses.

### 6. Location & Matching
- Implement real-time location tracking for both users and mechanics.
- Implement the matching logic to find the nearest available mechanic.

### 7. Map & UI
- Integrate Google Maps.
- Display user and mechanic markers.
- Implement live location updates on the map.
- Design and build the UI for all screens.
