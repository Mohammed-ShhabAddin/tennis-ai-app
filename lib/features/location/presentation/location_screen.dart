import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/curved_shape_widget.dart';
import '../../auth/presentation/ui/widgets/custom_text_form_field.dart';
import '../../weather/presentation/ui/weather_screen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    final TextEditingController cityController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.blueColor.withOpacity(0.75),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight -
                mediaQuery.padding.top -
                mediaQuery.padding.bottom,
          ),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CurvedShapeWidget(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.1),
                        Image.asset(
                          'assets/images/tennis-ball.png',
                          height: screenHeight * 0.15,
                          width: screenWidth * 0.2,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Enter desired city ',
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.3),
                      CustomTextFormField(
                        controller: cityController,
                        labelText: 'city name eg. cairo ',
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.xBlueColor.withOpacity(0.75),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          final city = cityController.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeatherScreen(city: city),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.02,
                          ),
                          child: Text(
                            'Get weather',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
