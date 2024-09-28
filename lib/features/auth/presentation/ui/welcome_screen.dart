import 'package:flutter/material.dart';
import 'package:tennis_ai_app/core/utilies/assets.dart';
import 'package:tennis_ai_app/core/utilies/strings.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/curved_shape_widget.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.blueColor.withOpacity(0.75),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Top Section: Background Container with Gradient, Image, and Text
            CurvedShapeWidget(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: size.height * 0.02), // 2% of screen height
                    child: Image.asset(
                      AppAssets.tennisBall,

                      height: size.height * 0.12, // 10% of screen height
                    ),
                  ),
                  // Welcome Text
                  Text(
                    AppStrings.welcomeToApp,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.065, // 6% of screen width
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Spacer to Push Buttons to the Center
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1), // 10% of screen width
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Wrap content vertically
                    children: [
                      // "Sign Up" Button
                      GradientButton(
                        text: 'Sign Up',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()),
                          );
                        },
                        width: double.infinity,
                        height: size.height * 0.07, // 7% of screen height
                      ),
                      SizedBox(
                          height: size.height * 0.02), // 2% of screen height
                      // "Log In" Button
                      GradientButton(
                        text: 'Log In',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        width: double.infinity,
                        height: size.height * 0.07, // 7% of screen height
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.2),
          ],
        ),
      ),
    );
  }
}

/// Reusable Gradient Button Widget
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.xBlueColor.withOpacity(0.75),
            AppColors.xgreenColor.withOpacity(0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
            height * 0.5), // Circular border based on height
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.transparent, // Makes the button background transparent
          shadowColor: Colors.transparent, // Removes the shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height * 0.5),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: height * 0.4, // 40% of button height
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
