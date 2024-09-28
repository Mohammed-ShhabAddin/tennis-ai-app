//Curved Shape Widget

import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class CurvedShapeWidget extends StatelessWidget {
  final Widget? child;

  const CurvedShapeWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    // Obtain screen size for responsive design
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5, // 50% of screen height
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            AppColors.xBlueColor.withOpacity(0.75),
            AppColors.xgreenColor.withOpacity(0.75),
          ],
          radius: 0.85,
          center: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(size.width * 0.45),
          bottomRight: Radius.circular(size.width * 0.45),
        ),
      ),
      // Optional Child Widget
      child: child,
    );
  }
}
