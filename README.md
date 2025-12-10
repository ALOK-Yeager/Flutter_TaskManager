# Task & Event Manager

A Flutter application for managing tasks and events with local persistence.

## 📥 Download APK

**[Download Latest Debug APK](https://github.com/ALOK-Yeager/Flutter_TaskManager/releases/tag/v1.0.0)**

The APK file is located in the repository root as `app-debug.apk`.

## Features
- Create, read, update, and delete tasks
- Create, read, update, and delete events
- Mark tasks as completed/incomplete
- Local data persistence using Hive
- Modern state management with Riverpod
- Clean architecture following SOLID principles

## Tech Stack
- Flutter (Dart)
- Riverpod (State Management)
- Hive (Local Storage)
- Freezed (Immutable Data Classes)
- intl (Date/Time Formatting)

## Architecture
- Feature-based project structure
- Repository pattern
- Use cases for business logic
- Separation of data, domain, and presentation layers

## Setup
1. Clone the repository
   ```bash
   git clone https://github.com/ALOK-Yeager/Flutter_TaskManager.git
   cd Flutter_TaskManager
   ```
2. Run `flutter pub get`
3. Run `dart run build_runner build --delete-conflicting-outputs`
4. Run `flutter run`

## Build Instructions
To build the APK yourself:
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter build apk --debug
```

The APK will be generated at `build/app/outputs/flutter-apk/app-debug.apk`
