import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/reusable_widgets.dart';
import 'otp_verify_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _tagController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _acceptTerms = false;
  final bool _tagValid = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _tagController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OtpVerifyScreen(
          email: _emailController.text.isNotEmpty
              ? _emailController.text
              : 'your email',
          onVerified: () {
            // Navigate to success, then PIN, etc.
          },
        ),
      ),
    );
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
              const SignUpBackBtn(),
              Text(
                'Sign up now!',
                style: GoogleFonts.dmSans(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Create an account now, challenge, play, and win yourself some cash.',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),

              // Full Name
              AppTextField(
                hint: 'Full Name',
                prefixIcon: Icons.person_outline_rounded,
                controller: _nameController,
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Please use your legal name',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: AppColors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Email
              AppTextField(
                hint: 'Email',
                prefixIcon: Icons.mail_outline_rounded,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),

              // Phone with country picker
              _PhoneField(controller: _phoneController),
              const SizedBox(height: 14),

              // Username tag
              AppTextField(
                hint: 'johndoe',
                prefixIcon: Icons.alternate_email_rounded,
                controller: _tagController,
                showSuccessIcon: _tagValid && _tagController.text.isNotEmpty,
              ),
              const SizedBox(height: 14),

              // Password
              AppTextField(
                hint: 'Password',
                prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 20),

              // Terms checkbox
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _acceptTerms = !_acceptTerms),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _acceptTerms ? AppColors.black : Colors.transparent,
                        border: Border.all(
                          color: _acceptTerms
                              ? AppColors.black
                              : AppColors.textHint,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: _acceptTerms
                          ? const Icon(Icons.check,
                              size: 14, color: AppColors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        const TextSpan(text: 'I accept the '),
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),

              // Sign up button
              PrimaryButton(
                label: 'Sign up',
                onPressed: _acceptTerms ? _onSignUp : null,
              ),
              const SizedBox(height: 20),

              // Already have account
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        const TextSpan(text: 'Already have an account?  '),
                        TextSpan(
                          text: 'Log in',
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
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const _PhoneField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: [
          // Country picker button
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Text('🇳🇬', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 6),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      size: 18, color: AppColors.textHint),
                ],
              ),
            ),
          ),
          Container(width: 1, height: 30, color: AppColors.inputBorder),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.dmSans(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Phone number',
                hintStyle: GoogleFonts.dmSans(
                  fontSize: 15,
                  color: AppColors.textHint,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
