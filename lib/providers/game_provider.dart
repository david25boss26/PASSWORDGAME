import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_chaos_new/models/password_rule.dart';
import 'dart:math';

class GameState {
  final int level;
  final List<PasswordRule> currentRules;
  final Map<PasswordRule, bool> ruleValidation;
  final bool hasUsedHint;
  final int score;

  GameState({
    required this.level,
    required this.currentRules,
    required this.ruleValidation,
    required this.hasUsedHint,
    required this.score,
  });

  GameState copyWith({
    int? level,
    List<PasswordRule>? currentRules,
    Map<PasswordRule, bool>? ruleValidation,
    bool? hasUsedHint,
    int? score,
  }) {
    return GameState(
      level: level ?? this.level,
      currentRules: currentRules ?? this.currentRules,
      ruleValidation: ruleValidation ?? this.ruleValidation,
      hasUsedHint: hasUsedHint ?? this.hasUsedHint,
      score: score ?? this.score,
    );
  }
}

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier()
      : super(
          GameState(
            level: 1,
            currentRules: _getRandomRules(1),
            ruleValidation: {},
            hasUsedHint: false,
            score: 0,
          ),
        );

  static List<PasswordRule> _getRandomRules(int level) {
    final random = Random();
    final allRules = PasswordRules.allRules;
    final ruleCount = min(level + 1, allRules.length);
    final rules = <PasswordRule>[];

    while (rules.length < ruleCount) {
      final rule = allRules[random.nextInt(allRules.length)];
      if (!rules.contains(rule)) {
        rules.add(rule);
      }
    }

    return rules;
  }

  void validatePassword(String password) {
    final validation = <PasswordRule, bool>{};
    for (final rule in state.currentRules) {
      validation[rule] = rule.validator(password);
    }
    state = state.copyWith(ruleValidation: validation);
  }

  bool get areAllRulesSatisfied {
    return state.ruleValidation.values.every((isValid) => isValid);
  }

  void useHint() {
    if (!state.hasUsedHint) {
      state = state.copyWith(hasUsedHint: true);
    }
  }

  void nextLevel() {
    final newLevel = state.level + 1;
    final newRules = _getRandomRules(newLevel);
    state = state.copyWith(
      level: newLevel,
      currentRules: newRules,
      ruleValidation: {},
      score: state.score + 100,
    );
  }

  String? getHintForRule(PasswordRule rule) {
    if (state.hasUsedHint) return null;
    return rule.hint;
  }
}

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
});
