import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../signup_screen.dart';

class HavingAccountWidget extends StatelessWidget {
  const HavingAccountWidget({
    super.key,
    required this.screenWidth,
    required this.msgText,
    required this.buttonText,
    required this.navTo,
  });

  final double screenWidth;
  final String msgText;
  final String buttonText;
  final Widget navTo;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: msgText,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: screenWidth * 0.04, //
        ),
        children: [
          TextSpan(
            text: buttonText,
            style: TextStyle(
              fontSize: screenWidth * 0.045, //
              color: AppColors.greenColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => navTo),
                );
              },
          ),
        ],
      ),
    );
  }
}
