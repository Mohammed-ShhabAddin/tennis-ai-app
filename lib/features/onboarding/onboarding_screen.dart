import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';
import '../../core/utilies/assets.dart';
import '../../core/utilies/strings.dart';
import '../../core/widgets/curved_shape_widget.dart';
import '../../core/widgets/gradient_button.dart';
import '../auth/presentation/ui/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> _onboardingPages = [
    OnboardingPageData(
      image: AppAssets.onboarding1,
      text: AppStrings.welcomeMsg,
    ),
    OnboardingPageData(
      image: AppAssets.onboarding2,
      text: AppStrings.trackPlay,
    ),
  ];

  void _onNextPressed() {
    if (_currentPage < _onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.blueColor.withOpacity(0.75),
      body: Stack(
        children: [
          _buildBackground(size),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _onboardingPages.length,
                    itemBuilder: (context, index) {
                      final page = _onboardingPages[index];
                      return OnboardingPage(
                        image: page.image,
                        text: page.text,
                        screenHeight: size.height,
                      );
                    },
                  ),
                ),
                _buildBottomSection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(Size size) {
    return const Positioned(
        top: 0, left: 0, right: 0, child: CurvedShapeWidget());
  }

  Widget _buildBottomSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _currentPage < _onboardingPages.length - 1
            ? Row(
                children: List.generate(
                  _onboardingPages.length,
                  (index) => _buildDot(index == _currentPage),
                ),
              )
            : const SizedBox(width: 100), // Placeholder when on last page
        GradientButton(
          text: _currentPage == _onboardingPages.length - 1
              ? 'Get Started'
              : 'Next',
          onPressed: _onNextPressed,
        ),
      ],
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 12.0 : 8.0,
      height: isActive ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? AppColors.xBlueColor : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class OnboardingPageData {
  final String image;
  final String text;

  OnboardingPageData({required this.image, required this.text});
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String text;
  final double screenHeight;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.text,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: screenHeight * 0.4), // 40% of screen height
        const SizedBox(height: 20),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppColors.xBlueColor,
              AppColors.xgreenColor,
              AppColors.xBlueColor
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Arial',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
