import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../theme/app_theme.dart';
import '../widgets/reusable_widgets.dart';
import 'create_pin_screen.dart';

// ─── OTP Verification Screen ──────────────────────────────────────────────────
class OtpVerifyScreen extends StatefulWidget {
  final String email;
  final VoidCallback? onVerified;

  const OtpVerifyScreen({
    super.key,
    required this.email,
    this.onVerified,
  });

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  int _secondsRemaining = 60;
  Timer? _timer;
  String _otp = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onVerify() {
    // Navigate to success screen
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AccountCreatedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(1, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBackButton(),
              const SizedBox(height: 12),
              Text(
                'Verify your account',
                style: GoogleFonts.dmSans(
                  fontSize: 31,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'We sent a 6-digit OTP to your email. Enter the code below',
                style: GoogleFonts.dmSans(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 15),
              OtpInputRow(
                length: 6,
                onCompleted: (otp) => setState(() => _otp = otp),
              ),
              const SizedBox(height: 15),
              Text(
                'Resend: $minutes:$seconds',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Verify',
                onPressed: _otp.length == 6 ? _onVerify : null,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Account Created Success Screen ──────────────────────────────────────────
class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const Spacer(),
              // Success icon
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.green, width: 6),
                ),
                child: const Icon(Icons.check_rounded,
                    size: 55, color: AppColors.green,),
              ),
              const SizedBox(height: 10),
              Text(
                'Congratulations!',
                style: GoogleFonts.dmSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Your account has been created successfully.',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Continue',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const CreatePinScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
