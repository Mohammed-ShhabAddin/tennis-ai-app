import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_ai_app/core/theme/colors.dart';
import 'package:tennis_ai_app/core/widgets/curved_shape_widget.dart';
import 'package:tennis_ai_app/features/auth/data/models/login_model.dart';
import 'package:tennis_ai_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tennis_ai_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:tennis_ai_app/features/auth/presentation/ui/signup_screen.dart';
import 'package:tennis_ai_app/features/auth/presentation/ui/widgets/custom_text_form_field.dart';
import 'package:tennis_ai_app/features/auth/presentation/ui/widgets/having_account_widget.dart';
import 'package:tennis_ai_app/features/location/presentation/location_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final paddingBottom = mediaQuery.viewInsets.bottom;

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
                          height: screenHeight * 0.1,
                          width: screenWidth * 0.2,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Login',
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
                      SizedBox(height: screenHeight * 0.26),
                      CustomTextFormField(
                        controller: emailController,
                        labelText: 'Email',
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // Simple email validation
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Password Field
                      CustomTextFormField(
                        controller: passwordController,
                        labelText: 'Password',
                        isPasswordField: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login successful!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // Navigate to  Location Screen
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocationScreen(),
                              ),
                              (route) => false,
                            );
                          } else if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator();
                          }
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.xBlueColor.withOpacity(0.75),
                                  AppColors.xgreenColor.withOpacity(0.75),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                // Validate inputs before proceeding
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();

                                if (email.isEmpty || password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please fill in all the fields'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                final loginModel = LoginModel(
                                  email: email,
                                  password: password,
                                );
                                context.read<AuthCubit>().login(loginModel);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenHeight * 0.02,
                                ),
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Navigation to Signup Screen
                      HavingAccountWidget(
                        screenWidth: screenWidth,
                        msgText: ' Don\'t have an account? ',
                        buttonText: 'Sign Up',
                        navTo: SignupScreen(),
                      ),
                      SizedBox(height: paddingBottom),
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
