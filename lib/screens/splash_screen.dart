import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoFade;
  late Animation<double> _textFade;
  late Animation<double> _logoScale;

  bool _showFullBrand = false;

  @override
  // animation
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    _logoScale = Tween<double>(begin: 0.85, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _textFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
    _controller.forward();

    // delay the animation from first to second logo by 1.5secs
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _showFullBrand = true);
    });

    // Navigate after 3s
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const OnboardingScreen(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            if (!_showFullBrand) {
              return FadeTransition(
                opacity: _logoFade,
                child: ScaleTransition(
                  scale: _logoScale,
                  child: buildMiniLogo(),
                ),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: _textFade,
                    child: _buildFullBrand(),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildMiniLogo() {
    return const Image(
      image: (AssetImage('assets/images/gamblr_mini.png')
      ),
    );
  }

  Widget _buildFullBrand() {
    return const Image(
        image: (AssetImage('assets/images/gamblr_logo.png'))
    );
  }
}
