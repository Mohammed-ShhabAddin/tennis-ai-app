import 'package:flutter/material.dart';
import 'package:tennis_ai_app/core/utilies/assets.dart';
import 'package:tennis_ai_app/core/utilies/strings.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/curved_shape_widget.dart';
import '../../../../core/widgets/gradient_button.dart';
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
            CurvedShapeWidget(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                    child: Image.asset(
                      AppAssets.tennisBall,
                      height: size.height * 0.12,
                    ),
                  ),
                  // Welcome Text
                  Text(
                    AppStrings.welcomeToApp,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.065,
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
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                        height: size.height * 0.07,
                      ),
                      SizedBox(height: size.height * 0.02),
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
                        height: size.height * 0.07,
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
