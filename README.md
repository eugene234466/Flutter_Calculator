# Flutter Calculator

A simple, clean calculator app built with Flutter. Built as a hands-on project to practice Flutter state management, widget composition, and UI layout with GridView.

## Features

- Basic arithmetic: addition, subtraction, multiplication, division
- Clear (C) button to reset
- Chained calculations (e.g. `5 + 3 + 2` computes step by step)
- Divide-by-zero handled gracefully
- Responsive button grid using `GridView.builder`

## Built With

- [Flutter](https://flutter.dev)
- Dart

## Getting Started

### Prerequisites

- Flutter SDK installed ([installation guide](https://docs.flutter.dev/get-started/install))

### Run locally

```bash
git clone https://github.com/<your-username>/calculator_app.git
cd calculator_app
flutter pub get
flutter run
```

## Screenshots

_(add a screenshot or screen recording here)_

## What I Learned

- Managing UI state with `StatefulWidget` and `setState()`
- Structuring a Flutter app: `StatelessWidget` → `StatefulWidget` → `State` class
- Building dynamic layouts with `GridView.builder`
- Separating display logic (String) from computation logic (double)

## License

MIT