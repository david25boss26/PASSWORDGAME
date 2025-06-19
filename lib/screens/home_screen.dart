import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_chaos_new/providers/game_provider.dart';
import 'package:password_chaos_new/widgets/level_indicator.dart';
import 'package:password_chaos_new/widgets/password_input_field.dart';
import 'package:password_chaos_new/widgets/password_rules_card.dart';

final passwordControllerProvider = StateProvider<String>((ref) => '');

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LevelIndicator(),
                const SizedBox(height: 24),
                Text(
                  'Password Chaos',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ).animate().fadeIn().slideX(),
                const SizedBox(height: 8),
                Text(
                  'Create passwords that follow these crazy rules!',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                ).animate().fadeIn().slideX(delay: 200.ms),
                const SizedBox(height: 32),
                const PasswordRulesCard(),
                const SizedBox(height: 24),
                const PasswordInputField(),
                const Spacer(),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final password = ref.read(passwordControllerProvider);
                      ref
                          .read(gameProvider.notifier)
                          .validatePassword(password);

                      if (ref
                          .read(gameProvider.notifier)
                          .areAllRulesSatisfied) {
                        ref.read(gameProvider.notifier).nextLevel();
                      }
                    },
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Check Password'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                ).animate().fadeIn().scale(delay: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
