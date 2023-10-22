# Flutter Assessment - Simpsons Demo

## Overview

This project is a Flutter-based application that demonstrates the use of Bloc for state management and data manipulation. The app fetches and displays data from two different sources, the Simpsons and the Wire. It provides search functionality and is responsive, adapting to both phone and tablet layouts.

## Essential Components

### State Management

- **Bloc**: The project heavily relies on the Bloc pattern for state management. `DataSourceBloc` and `SearchBloc` are the core blocs that handle most of the logic.

### Data Sources

- **SimpsonsDataSourceImpl**: Fetches data related to the Simpsons characters.
- **WireDataSourceImpl**: Fetches data related to the Wire characters.

### UI

- **DeviceLayout**: A custom widget to adapt the layout based on the device type (phone/tablet).
- **SearchView**: Provides a search bar and displays the filtered list of characters.
- **DetailView**: Shows detailed information about a selected character.

## How to Run The App

1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Execute `flutter run` to start the application.

```bash
git clone <repository_url>
cd <project_directory>
flutter pub get
flutter run
```

## How to Run Tests

1. Navigate to the project directory.
2. Run `flutter test` to execute all tests.

```bash
cd <project_directory>
flutter test test/bloc_tests.dart
```
