class PasswordRule {
  final String description;
  final bool Function(String password) validator;
  final String? hint;

  const PasswordRule({
    required this.description,
    required this.validator,
    this.hint,
  });
}

class PasswordRules {
  static List<PasswordRule> get allRules => [
    PasswordRule(
      description: 'Must contain the letter Z',
      validator: (password) => password.toLowerCase().contains('z'),
      hint: 'Add the letter Z somewhere in your password',
    ),
    PasswordRule(
      description: 'Total of numbers must be 25',
      validator: (password) {
        final numbers = password.replaceAll(RegExp(r'[^0-9]'), '');
        return numbers.length == 25;
      },
      hint: 'Add exactly 25 numbers to your password',
    ),
    PasswordRule(
      description: 'Must start and end with a special character',
      validator: (password) {
        final specialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
        return specialChars.hasMatch(password[0]) &&
            specialChars.hasMatch(password[password.length - 1]);
      },
      hint: 'Add a special character at the beginning and end',
    ),
    PasswordRule(
      description: 'No vowels allowed',
      validator: (password) {
        final vowels = RegExp(r'[aeiouAEIOU]');
        return !vowels.hasMatch(password);
      },
      hint: 'Remove all vowels (a, e, i, o, u) from your password',
    ),
    PasswordRule(
      description: 'Length must be a prime number',
      validator: (password) {
        final length = password.length;
        if (length < 2) return false;
        for (int i = 2; i <= length ~/ 2; i++) {
          if (length % i == 0) return false;
        }
        return true;
      },
      hint: 'Make your password length a prime number (2, 3, 5, 7, 11, etc.)',
    ),
    PasswordRule(
      description: 'Use only alternating uppercase and lowercase characters',
      validator: (password) {
        if (password.isEmpty) return false;
        for (int i = 0; i < password.length - 1; i++) {
          final current = password[i];
          final next = password[i + 1];
          if (current == current.toUpperCase() && next == next.toUpperCase() ||
              current == current.toLowerCase() && next == next.toLowerCase()) {
            return false;
          }
        }
        return true;
      },
      hint: 'Alternate between uppercase and lowercase letters',
    ),
  ];
}
