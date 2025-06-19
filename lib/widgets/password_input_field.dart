import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_chaos_new/providers/game_provider.dart';
import 'package:password_chaos_new/screens/home_screen.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class PasswordInputField extends ConsumerStatefulWidget {
  const PasswordInputField({super.key});

  @override
  ConsumerState<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends ConsumerState<PasswordInputField> {
  bool _isPasswordVisible = false;
  final _controller = TextEditingController();
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _controller.addListener(() {
      ref.read(passwordControllerProvider.notifier).state = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _checkPassword() {
    final password = _controller.text;
    ref.read(gameProvider.notifier).validatePassword(password);

    if (ref.read(gameProvider.notifier).areAllRulesSatisfied) {
      _confettiController.play();
      Future.delayed(const Duration(seconds: 1), () {
        ref.read(gameProvider.notifier).nextLevel();
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _controller,
            obscureText: !_isPasswordVisible,
            style: Theme.of(context).textTheme.bodyLarge,
            onSubmitted: (_) => _checkPassword(),
            decoration: InputDecoration(
              hintText: 'Enter your password...',
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Theme.of(context).colorScheme.primary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2,
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.1,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
            ],
          ),
        ),
      ],
    ).animate().fadeIn().slideY(delay: 300.ms);
  }
}
