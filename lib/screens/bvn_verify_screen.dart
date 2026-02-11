import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/reusable_widgets.dart';
import 'login_screen.dart';

class BvnVerifyScreen extends StatefulWidget {
  const BvnVerifyScreen({super.key});

  @override
  State<BvnVerifyScreen> createState() => _BvnVerifyScreenState();
}

class _BvnVerifyScreenState extends State<BvnVerifyScreen> {
  final _bvnController = TextEditingController();

  @override
  void dispose() {
    _bvnController.dispose();
    super.dispose();
  }

  void _onVerify() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void _onSkip() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Skip button top right
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: _onSkip,
                    child: Row(
                      children: [
                        Text(
                          'Skip for now',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right_rounded,
                            size: 18, color: AppColors.textPrimary),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),

              // Illustration placeholder
              const Center(
                child: SizedBox(
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/images/verify_icon.png'))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Verify your identity',
                style: GoogleFonts.dmSans(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'To enhance security and comply with regulations, we require your BVN (Bank Verification Number). Rest assured, your information is safe with us.',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),

              // BVN input
              AppTextField(
                hint: 'Enter your BVN',
                controller: _bvnController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),

              // Privacy note
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.blueLight,
                  borderRadius: BorderRadius.circular(12)

                ),
                child: Text(
                  'Your BVN is securely encrypted and used solely for identity verification. We adhere to strict privacy and security measures to safeguard your information.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue,
                    height: 1.5,
                  ),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Verify',
                onPressed: _onVerify,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
