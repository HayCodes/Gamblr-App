import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/reusable_widgets.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Simulate: if user has logged in before, show returning user UI
  bool _isReturningUser = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (!_isReturningUser) {
      setState(() => _isReturningUser = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _isReturningUser
                  ? _ReturningUserView(
                      onLogin: _onLogin,
                      onForgotPassword: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen()),
                      ),
                    )
                  : _StandardLoginView(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      onLogin: _onLogin,
                      onForgotPassword: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen()),
                      ),
                      onSignUp: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Standard Login ───────────────────────────────────────────────────────────
class _StandardLoginView extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;
  final VoidCallback onSignUp;

  const _StandardLoginView({
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.onForgotPassword,
    required this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign in',
          style: GoogleFonts.dmSans(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Log into your account',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 32),
        AppTextField(
          hint: 'Email / tag',
          prefixIcon: Icons.person_outline_rounded,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 14),
        AppTextField(
          hint: 'Password',
          prefixIcon: Icons.lock_outline_rounded,
          isPassword: true,
          controller: passwordController,
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: onForgotPassword,
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              children: [
                const TextSpan(text: 'Forgot password? '),
                TextSpan(
                  text: 'Reset',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 80),
        PrimaryButton(label: 'Login', onPressed: onLogin),
        const SizedBox(height: 20),
        Center(
          child: GestureDetector(
            onTap: onSignUp,
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                children: [
                  const TextSpan(text: "Don't have an account?  "),
                  TextSpan(
                    text: 'Sign Up',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Returning User Login ──────────────────────────────────────────────────────
class _ReturningUserView extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;

  const _ReturningUserView({
    required this.onLogin,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        // Avatar
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFFCDD2), width: 6),
            color: const Color(0xFFB71C1C),
          ),
          child: const Icon(Icons.person, size: 44, color: AppColors.white),
        ),
        const SizedBox(height: 8),
        Text(
          '@johndoe',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Welcome back!',
          style: GoogleFonts.dmSans(
            fontSize: 31,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Log into your account',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 28),
        const AppTextField(
          hint: 'Password',
          prefixIcon: Icons.lock_outline_rounded,
          isPassword: true,
        ),
        const SizedBox(height: 14),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: onForgotPassword,
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                children: [
                  const TextSpan(text: 'Forgot password? '),
                  TextSpan(
                    text: 'Reset',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),

        // Biometric button
        GestureDetector(
          onTap: () => BiometricDialog.show(context),
          child: Column(
            children: [
              Container(
                width: 82,
                height: 85,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.inputBorder, width: 1.5),
                  color: AppColors.surface,
                ),
                child: const Icon(Icons.fingerprint,
                    size: 44, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'Use biometrics',
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 80),
        PrimaryButton(label: 'Login', onPressed: onLogin),
        const SizedBox(height: 16),
      ],
    );
  }
}
