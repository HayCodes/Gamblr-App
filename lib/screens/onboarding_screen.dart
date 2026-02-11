import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/reusable_widgets.dart';
import 'signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingData {
  final String title;
  final String imageUrl;
  final String subtitle;
  final Color imageColor;
  final bool textFromTop;

  _OnboardingData({
    required this.imageUrl,
    this.textFromTop = false,
    required this.title,
    required this.subtitle,
    required this.imageColor,
  });
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      title: 'Challenge, stake and\nplay your favorite games',
      imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800',
      subtitle:
          'Turn your gaming skills into winning opportunities on Gamblr.',
      imageColor: const Color(0xFF0D1B2A),
      textFromTop: false
    ),
    _OnboardingData(
      title: 'Face off with your padii\nin a 1v1 duel',
      imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800',
      subtitle:
          "Elevate your gaming experience with Gambler's interactive betting.",
      imageColor: const Color(0xFF1A1A0D),
      textFromTop: true
    ),
    _OnboardingData(
      title: 'Rank up and earn',
      imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800',
      subtitle:
          'The more you win, the higher your rank and the more cash token you earn.',
      imageColor: const Color(0xFF1A0D1A),
      textFromTop: false
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bgColor from the preset colors in themes.dart.
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          // Animation to make those 3 screens in the same page
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              return _OnboardingPage(data: _pages[index]);
            },
          ),

          // Bottom overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 48),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xCC000000)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page indicator
                  Row(
                    children: List.generate(_pages.length, (i) {
                      final isActive = i == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 6),
                        width: isActive ? 28 : 10,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.white
                              : AppColors.white.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  WhitePrimaryButton(
                    label: 'Get started',
                    onPressed: goToSignUp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image placeholder with gradient overlay
        Container(
          color: data.imageColor,
          child: Opacity(
            opacity: 0.4,
            child: Image.network(
              data.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
        ),

        // Dark gradient from top/bottom
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: data.textFromTop ? Alignment.bottomCenter : Alignment.topCenter,
                end: data.textFromTop ? Alignment.topCenter : Alignment.bottomCenter,
                stops: const [0.3, 0.7, 1.0],
                colors: [
                  Colors.transparent,
                  AppColors.darkBg.withOpacity(0.6),
                  AppColors.darkBg,
                ],
              ),
            ),
          ),
        ),


        if (data.textFromTop)
          Positioned(
            left: 24,
            right: 24,
            top: 80, // sits near the top (below status bar)
            child: _TextContent(data: data),
          )
        else
          Positioned(
            left: 24,
            right: 24,
            bottom: 160, // sits above the button overlay
            child: _TextContent(data: data),
          ),

      ],
    );
  }
}

class _TextContent extends StatelessWidget {
  final _OnboardingData data;

  const _TextContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.title,
          style: GoogleFonts.dmSans(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          data.subtitle,
          style: GoogleFonts.dmSans(
            fontSize: 16,
            color: AppColors.white.withOpacity(0.7),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
