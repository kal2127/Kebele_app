# Kebele Appointment Management System

A frontend-only Flutter application for managing appointment booking and service information in Ethiopian Kebele offices.

## Overview

`Kebele_app` is a mobile-first Flutter project built to showcase a community service booking flow with:

- appointment booking and confirmation
- appointment editing and cancellation
- service browsing with detailed requirements
- theme switching and localization support
- local persistence via shared preferences

This app is designed for Ethiopian users and supports English and Amharic languages.

## Key Features

- Book appointments for Kebele services such as ID issuance, renewals, birth certificates, marriage certificates, and death certificates.
- View service details, required documents, processing times, and instructions.
- Edit or cancel existing appointments.
- Persistent local storage for appointments, theme preferences, and language selection.
- Light / dark theme toggle.
- Bilingual support with English and Amharic translations.

## Tech Stack

- Flutter
- Dart
- Provider for state management
- easy_localization for multilingual support
- shared_preferences for local persistence

## Supported Platforms

- Android
- iOS
- Web
- macOS
- Linux
- Windows

## Getting Started

### Prerequisites

- Flutter SDK installed
- A compatible IDE such as VS Code or Android Studio
- Platform-specific tooling for Android/iOS if you want to run on device/emulator

### Run the App

From the project root:

```bash
flutter pub get
flutter run
```

To run on a specific platform, use:

```bash
flutter run -d chrome
flutter run -d android
flutter run -d ios
```

### Build Release

```bash
flutter build apk
flutter build ios
flutter build web
```

## Project Structure

- `lib/main.dart` — app entry point and provider initialization
- `lib/app.dart` — application routes and theme/localization setup
- `lib/screens/` — screen implementations for booking, services, settings, feedback, and more
- `lib/providers/` — state management for appointments, theme, and language
- `lib/models/` — appointment and service data models
- `lib/data/local_services_data.dart` — static service catalog displayed in the app
- `lib/themes/app_theme.dart` — light and dark theme definitions
- `assets/translations/` — translation strings for English and Amharic

## Localization

The app uses `easy_localization` and supports:

- English (`en`)
- Amharic (`am`)

Language preference is saved locally so the selected language persists across app launches.

## Persistent Storage

The app stores:

- booked appointments
- selected theme mode
- selected language

using `shared_preferences`.

## Notes

This project is frontend-only and does not include a backend API. Appointment data is stored locally on the device.

