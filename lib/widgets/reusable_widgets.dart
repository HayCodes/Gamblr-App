import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ─── Primary Black Button ────────────────────────────────────────────────────
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Text(
                label,
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
      ),
    );
  }
}

// ─── White Button (for dark screens) ─────────────────────────────────────────
class WhitePrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const WhitePrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}

// ─── Input Field ─────────────────────────────────────────────────────────────
class AppTextField extends StatefulWidget {
  final String hint;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final bool isPassword;
  final bool showSuccessIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? errorText;

  const AppTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.prefixWidget,
    this.isPassword = false,
    this.showSuccessIcon = false,
    this.controller,
    this.keyboardType,
    this.errorText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscure,
      keyboardType: widget.keyboardType,
      style: GoogleFonts.dmSans(
        fontSize: 15,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: GoogleFonts.dmSans(
          fontSize: 15,
          color: AppColors.textHint,
        ),
        prefixIcon: widget.prefixWidget ??
            (widget.prefixIcon != null
                ? Icon(widget.prefixIcon,
                    size: 20, color: AppColors.textPrimary)
                : null),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () => setState(() => _obscure = !_obscure),
                child: Icon(
                  _obscure
                      ? Icons.visibility_sharp
                      : Icons.visibility_off_sharp,
                  size: 20,
                  color: AppColors.textHint,
                ),
              )
            : widget.showSuccessIcon
                ? Container(
                    margin: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check,
                        size: 16, color: AppColors.white),
                  )
                : null,
        filled: true,
        fillColor: AppColors.background,
        errorText: widget.errorText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.black, width: 1.5),
        ),
      ),
    );
  }
}

// ─── Back Button ─────────────────────────────────────────────────────────────
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.inputBorder),
        ),
        child: const Icon(Icons.chevron_left_rounded,
            size: 24, color: AppColors.textPrimary),
      ),
    );
  }
}

// ─── Back Button In Sign Up ─────────────────────────────────────────────────────────────
class SignUpBackBtn extends StatelessWidget {
  const SignUpBackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/onboarding'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.inputBorder),
        ),
        child: const Icon(Icons.chevron_left_rounded,
            size: 24, color: AppColors.textPrimary),
      ),
    );
  }
}

// ─── OTP Box Row ──────────────────────────────────────────────────────────────
class OtpInputRow extends StatefulWidget {
  final int length;
  final Function(String)? onCompleted;

  const OtpInputRow({super.key, this.length = 6, this.onCompleted});

  @override
  State<OtpInputRow> createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<OtpInputRow> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (i) {
        return SizedBox(
          width: 48,
          height: 56,
          child: TextField(
            controller: _controllers[i],
            focusNode: _focusNodes[i],
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: AppColors.background,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.black, width: 1.5),
              ),
            ),
            onChanged: (val) {
              if (val.isNotEmpty && i < widget.length - 1) {
                _focusNodes[i + 1].requestFocus();
              }
              if (val.isEmpty && i > 0) {
                _focusNodes[i - 1].requestFocus();
              }
              final otp = _controllers.map((c) => c.text).join();
              if (otp.length == widget.length) {
                widget.onCompleted?.call(otp);
              }
            },
          ),
        );
      }),
    );
  }
}

// ─── Status Dialog ────────────────────────────────────────────────────────────
class StatusDialog extends StatelessWidget {
  final bool isSuccess;
  final String title;
  final String message;
  final VoidCallback? onDismiss;

  const StatusDialog({
    super.key,
    required this.isSuccess,
    required this.title,
    required this.message,
    this.onDismiss,
  });

  static Future<void> show(
    BuildContext context, {
    required bool isSuccess,
    required String title,
    required String message,
    VoidCallback? onDismiss,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => StatusDialog(
        isSuccess: isSuccess,
        title: title,
        message: message,
        onDismiss: onDismiss,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = isSuccess ? AppColors.green : AppColors.red;
    final icon = isSuccess ? Icons.check : Icons.close;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2.5),
              ),
              child: Icon(icon, color: color, size: 36),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                onDismiss?.call();
              },
              child: Text(
                'Dismiss',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Biometric Dialog ─────────────────────────────────────────────────────────
class BiometricDialog extends StatelessWidget {
  const BiometricDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => const BiometricDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Authorize transaction',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 28),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.inputBorder, width: 1.5),
              ),
              child: const Icon(Icons.fingerprint,
                  size: 36, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            Text(
              'Touch the fingerprint sensor',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
