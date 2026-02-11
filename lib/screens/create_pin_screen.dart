import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/reusable_widgets.dart';
import 'bvn_verify_screen.dart';

// ─── Shared PIN Numpad ────────────────────────────────────────────────────────
class _PinNumpad extends StatelessWidget {
  final List<String> entered;
  final Function(String) onKey;
  final VoidCallback onDelete;

  const _PinNumpad({
    required this.entered,
    required this.onKey,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final keys = ['1','2','3','4','5','6','7','8','9','','0','⌫'];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 8,
      ),
      itemCount: keys.length,
      itemBuilder: (context, i) {
        final key = keys[i];
        if (key.isEmpty) return const SizedBox();

        return GestureDetector(
          onTap: () {
            if (key == '⌫') {
              onDelete();
            } else {
              onKey(key);
            }
          },
          child: Container(
            alignment: Alignment.center,
            child: key == '⌫'
                ? Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.backspace_sharp,
                        size: 21, color: AppColors.textPrimary),
                  )
                : Text(
                    key,
                    style: GoogleFonts.dmSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
          ),
        );
      },
    );
  }
}

// ─── PIN Display Boxes ────────────────────────────────────────────────────────
class _PinBoxes extends StatelessWidget {
  final int length;
  final int filled;

  const _PinBoxes({required this.length, required this.filled});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(length, (i) {
        final isFilled = i < filled;
        return Container(
          margin: const EdgeInsets.only(right: 12),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: isFilled ? AppColors.surface : AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isFilled ? AppColors.black : AppColors.inputBorder,
              width: 1.5,
            ),
          ),
          child: isFilled
              ? const Center(
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: AppColors.black,
                  ),
                )
              : null,
        );
      }),
    );
  }
}

// ─── Create PIN Screen ────────────────────────────────────────────────────────
class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  List<String> _pin = [];

  void _onKey(String key) {
    if (_pin.length < 4) {
      setState(() => _pin.add(key));
    }
  }

  void _onDelete() {
    if (_pin.isNotEmpty) {
      setState(() => _pin.removeLast());
    }
  }

  void _onCreate() {
    if (_pin.length == 4) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ConfirmPinScreen(pin: _pin.join()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBackButton(),
              const SizedBox(height: 28),
              Text(
                'Create PIN',
                style: GoogleFonts.dmSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Create a Pin for your transaction authorizations',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 28),
              _PinBoxes(length: 4, filled: _pin.length),
              const Spacer(),
              _PinNumpad(
                entered: _pin,
                onKey: _onKey,
                onDelete: _onDelete,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Create PIN',
                onPressed: _pin.length == 4 ? _onCreate : null,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Confirm PIN Screen ───────────────────────────────────────────────────────
class ConfirmPinScreen extends StatefulWidget {
  final String pin;

  const ConfirmPinScreen({super.key, required this.pin});

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  List<String> _pin = [];

  void _onKey(String key) {
    if (_pin.length < 4) {
      setState(() => _pin.add(key));
    }
  }

  void _onDelete() {
    if (_pin.isNotEmpty) {
      setState(() => _pin.removeLast());
    }
  }

  void _onConfirm() {
    final entered = _pin.join();
    if (entered == widget.pin) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const BvnVerifyScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'PINs do not match. Try again.',
            style: GoogleFonts.dmSans(color: AppColors.white),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: AppColors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      setState(() => _pin = []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBackButton(),
              const SizedBox(height: 28),
              Text(
                'Confirm PIN',
                style: GoogleFonts.dmSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Enter the 4-digit PIN again',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 28),
              _PinBoxes(length: 4, filled: _pin.length),
              const Spacer(),
              _PinNumpad(
                entered: _pin,
                onKey: _onKey,
                onDelete: _onDelete,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Confirm',
                onPressed: _pin.length == 4 ? _onConfirm : null,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
