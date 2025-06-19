# Password Chaos

A fun and challenging Flutter game where players create passwords that follow increasingly complex and chaotic rules.

## 🎮 Game Overview

Password Chaos is a game that challenges players to create passwords that satisfy a set of rules. As players progress through levels, new rules are added, making the challenge more complex and interesting.

## 🏗️ Project Structure

```
lib/
├── models/
│   └── password_rule.dart      # Defines password rules and validation logic
├── providers/
│   └── game_provider.dart      # Manages game state using Riverpod
├── screens/
│   └── home_screen.dart        # Main game screen
├── widgets/
│   ├── level_indicator.dart    # Shows current level and progress
│   ├── password_input_field.dart # Password input with validation
│   └── password_rules_card.dart # Displays current rules
└── main.dart                   # App entry point
```

## 🎯 Features

### 1. Dynamic Password Rules

- Rules are randomly selected for each level
- Each level adds one new rule
- Rules include various challenges like:
  - Character requirements
  - Length constraints
  - Pattern matching
  - Mathematical conditions

### 2. Real-time Validation

- Instant feedback on rule satisfaction
- Visual indicators for each rule
- Hint system for difficult rules

### 3. Progressive Difficulty

- Level-based progression
- Increasing number of rules
- Score system based on level completion

## 🛠️ Technical Implementation

### State Management

- Uses `flutter_riverpod` for state management
- `GameProvider` manages:
  - Current level
  - Active rules
  - Rule validation
  - Score tracking

### Password Rules System

```dart
class PasswordRule {
  final String description;
  final bool Function(String password) validator;
  final String? hint;
}
```

- Each rule has:
  - Description for players
  - Validation function
  - Optional hint for help

### UI Components

#### Home Screen

- Main game interface
- Level indicator
- Rules display
- Password input
- Check button

#### Password Input Field

- Secure text entry
- Show/hide password toggle
- Real-time validation
- Confetti animation on success

#### Rules Card

- Dynamic rule list
- Validation status indicators
- Hint system integration

## 🎨 Design Features

### Animations

- Uses `flutter_animate` for smooth transitions
- Confetti celebration on level completion
- Fade and slide effects for UI elements

### Theme

- Material 3 design
- Dynamic color scheme
- Dark mode support
- Custom typography using Google Fonts

## 🚀 Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## 📦 Dependencies

- `flutter_riverpod`: State management
- `flutter_animate`: UI animations
- `confetti`: Celebration effects
- `google_fonts`: Typography
- `emoji_picker_flutter`: Emoji support
- `shared_preferences`: Local storage
- `path_provider`: File system access
- `uuid`: Unique ID generation

## 🎯 Game Rules

The game includes various password rules such as:

1. Must contain specific letters
2. Length requirements
3. Character type requirements
4. Pattern matching
5. Mathematical conditions
6. Case sensitivity rules

## 🔄 Game Flow

1. Player starts at level 1
2. Rules are displayed
3. Player enters password
4. System validates against rules
5. On success:
   - Level increases
   - New rule added
   - Score increases
   - Confetti celebration
6. Repeat

## 🛠️ Development

### Adding New Rules

To add a new rule, extend the `PasswordRules` class in `password_rule.dart`:

```dart
PasswordRule(
  description: 'Your rule description',
  validator: (password) => // your validation logic,
  hint: 'Optional hint for players',
)
```

### Customizing UI

- Theme colors in `main.dart`
- Animation timings in widget files
- Layout adjustments in screen files

## 📱 Platform Support

- Android
- iOS
- Web
- Windows
- macOS
- Linux

## 🔜 Future Enhancements

1. More password rules
2. Achievement system
3. Leaderboard
4. Custom rule creation
5. Multiplayer support
6. Rule difficulty levels

## 🤝 Contributing

Feel free to contribute to the project by:

1. Adding new rules
2. Improving UI/UX
3. Adding new features
4. Fixing bugs
5. Improving documentation

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
